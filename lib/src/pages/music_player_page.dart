import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_player/src/helpers/helpers.dart';
import 'package:music_player/src/models/audioplayer_model.dart';
import 'package:music_player/src/widgets/custom_widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

class MusicPlayerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: height*0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60.0)),
                gradient: LinearGradient(
                  colors: [Color(0xff33333E),Color(0xff201E28)],
                  begin: Alignment.center,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                children: <Widget>[
                  CustomAppbar(),
                  Expanded(child: _DiscImageDuration()),
                  SizedBox(height: 30.0,),
                  _TitlePlay(),
                ],
              ),
            ),
            Expanded(
              child: _Lyrics(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Lyrics extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final lyrics = getLyrics();

    return Container(
      child: ListWheelScrollView(
        itemExtent: 42.0,
        diameterRatio: 1.5,
        physics: BouncingScrollPhysics(),
        children: lyrics.map(
          (e) => Text(e,style: TextStyle(fontSize: 20.0,color: Colors.white.withOpacity(0.6)),),
        ).toList(),
      ),
    );
  }
}

class _TitlePlay extends StatefulWidget {

  @override
  __TitlePlayState createState() => __TitlePlayState();
}

class __TitlePlayState extends State<_TitlePlay> with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  bool firstTime = true;
  AnimationController playAnimation;
  final assetAudioPlayer = new AssetsAudioPlayer();

  @override
  void initState() { 
    super.initState();
    playAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() { 
    playAnimation.dispose();
    super.dispose();
  }

  void open() {
    final audioPlayerModel = Provider.of<AudioplayerModel>(context,listen: false);

    assetAudioPlayer.open(Audio('assets/music/Breaking-Benjamin-Far-Away.mp3'));
    
    assetAudioPlayer.currentPosition.listen((event) {
      audioPlayerModel.setCurrent = event;
    });

    assetAudioPlayer.current.listen((Playing playing) {
      audioPlayerModel.setSongDuration = playing.audio.duration;
    });

  }

  @override
  Widget build(BuildContext context) {
    final playerModel = Provider.of<AudioplayerModel>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Far Away',style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 30.0),),
                Text('-Breaking Benjamin-',style: TextStyle(color: Colors.white.withOpacity(0.4),fontSize: 15.0),)
              ],
            ),
            FloatingActionButton(
              onPressed: () {
                if(this.isPlaying){
                  playAnimation.reverse();
                  this.isPlaying = false;
                  playerModel.getAnimation.stop();
                }else{
                  playAnimation.forward();
                  this.isPlaying = true;
                  playerModel.getAnimation.repeat();
                }

                if(firstTime) {
                  this.open();
                  firstTime = false;
                }else{
                  assetAudioPlayer.playOrPause();
                }
              },
              backgroundColor: Colors.yellow,
              child: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: playAnimation,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscImageDuration extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0,right: 10.0),
      child: Container(
        child: Row(
          children: <Widget>[
            _DiscImage(),
            SizedBox(width: 3.0,),
            _ProgressBar(), 
          ],
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioplayerModel>(context);
    final porcentage = audioPlayerModel.getSongPorcentage;

    return Container(
      child: Column(
        children: <Widget>[
          Text('${audioPlayerModel.getSongTotalDuration}',style: TextStyle(color: Colors.white.withOpacity(0.4)),),
          SizedBox(height: 10.0,),
          Stack(
            children: <Widget>[
              Container(width: 5.0,height: 200.0,color: Colors.white.withOpacity(0.1),),
              Positioned(child: Container(width: 5.0,height:200.0*porcentage,color: Colors.white.withOpacity(0.8)),bottom: 0.0,),
            ],
          ),
          SizedBox(height: 10.0,),
          Text('${audioPlayerModel.getCurrentSecond}',style: TextStyle(color: Colors.white.withOpacity(0.4)),),
        ],
      ),
    );
  }
}

class _DiscImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final playerModel = Provider.of<AudioplayerModel>(context);

    return Container(
      width: 250.0,
      height: 250.0,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff484750),Color(0xff1E1C24)],
          begin: Alignment.topLeft,
        ),
        shape: BoxShape.circle,

      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SpinPerfect(
              animate: false,
              duration: Duration(seconds: 5),
              infinite: true,
              manualTrigger: true,
              controller: (animationController) => playerModel.setAnimation = animationController,
              child: Image(
                image: AssetImage('assets/images/aurora.jpg'),
              )
            ),
            Container(
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: Colors.black38,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 25.0,
              height: 25.0,
              decoration: BoxDecoration(
                color: Color(0xff1C1C25),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}