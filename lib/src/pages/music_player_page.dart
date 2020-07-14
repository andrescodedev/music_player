import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_player/src/widgets/custom_widgets.dart';

class MusicPlayerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: height*0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60.0)),
            gradient: LinearGradient(
              colors: [Color(0xff201E28),Colors.white.withOpacity(0.1)],
              begin: Alignment.center,
              end: Alignment.centerLeft,
            ),
          ),
          child: Column(
            children: <Widget>[
              CustomAppbar(),
              _DiscImageDuration(),
              _TitlePlay(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitlePlay extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
              backgroundColor: Colors.yellow,
              child: Icon(FontAwesomeIcons.play),
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
            SizedBox(width: 10.0,),
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
    return Container(
      child: Column(
        children: <Widget>[
          Text('04:53',style: TextStyle(color: Colors.white.withOpacity(0.4)),),
          SizedBox(height: 10.0,),
          Stack(
            children: <Widget>[
              Container(width: 5.0,height: 200.0,color: Colors.white.withOpacity(0.1),),
              Positioned(child: Container(width: 5.0,height: 150.0,color: Colors.white.withOpacity(0.8)),top: 70.0,),
            ],
          ),
          SizedBox(height: 10.0,),
          Text('03:50',style: TextStyle(color: Colors.white.withOpacity(0.4)),),
        ],
      ),
    );
  }
}

class _DiscImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
            Image(image: AssetImage('assets/images/aurora.jpg'),),
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