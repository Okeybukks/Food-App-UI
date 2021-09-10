import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder{
  final Widget secondScreen;
  CustomPageRoute(this.secondScreen) : super(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation){
      return secondScreen;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation, Widget child){
      if(animation.status == AnimationStatus.reverse){
        return Opacity(opacity: 0, child: child,);
      }
      else{
        return child;
      }

    },
    transitionDuration: Duration(seconds: 1),
    reverseTransitionDuration: Duration(seconds: 1),
  );

}