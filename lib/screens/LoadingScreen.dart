import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class LoadingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
          child: SpinKitThreeBounce(
            color: Color(0xff2B106A),
          ),
    );

  }

}