import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppbar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(FontAwesomeIcons.chevronLeft,),
            Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.commentAlt),
                SizedBox(width: 20.0,),
                Icon(FontAwesomeIcons.headphonesAlt),
                SizedBox(width: 20.0,),
                Icon(FontAwesomeIcons.externalLinkAlt),
              ],
            ),
          ],
        ),
      ),
    );
  }
}