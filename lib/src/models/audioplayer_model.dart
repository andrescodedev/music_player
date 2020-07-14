import 'package:flutter/material.dart';

class AudioplayerModel with ChangeNotifier {
  bool _isPlaying = false;
  AnimationController _controller;
  Duration _songDuration = new Duration(milliseconds: 0);
  Duration _current      = new Duration(milliseconds: 0);

  String get getSongTotalDuration => this.printDuration(this._songDuration);
  String get getCurrentSecond => this.printDuration(this._current);

  double get getSongPorcentage =>(this._songDuration.inSeconds > 0) 
    ? this._current.inSeconds / this._songDuration.inSeconds
    : 0;  

  bool get getPlaying => this._isPlaying;
  AnimationController get getAnimation => this._controller;
  Duration get getSongDuration => this._songDuration;
  Duration get getCurrent => this._current;

  set setPlaying(bool value) {
    this._isPlaying = value;
    notifyListeners();
  }

  set setAnimation(AnimationController value) {
    this._controller = value;
  }

  set setSongDuration(Duration value) {
    this._songDuration = value;
    notifyListeners();
  }

  set setCurrent(Duration value) {
    this._current = value;
    notifyListeners();
  }

  String printDuration (Duration duration) {
    String twoDigits(int n){
      if(n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "$twoDigitMinutes : $twoDigitSeconds";
  }
}