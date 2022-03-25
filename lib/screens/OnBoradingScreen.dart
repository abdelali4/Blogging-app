import 'package:blogging_app/screens/LogIn_Screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoarding extends StatelessWidget {
  List<PageViewModel> getPages(){
    return[
      PageViewModel(
        decoration: PageDecoration(
          titleTextStyle: TextStyle(color: Color(0xff2b106a),fontWeight: FontWeight.bold,fontSize: 25),
          bodyTextStyle: TextStyle(color: Color(0xff2b106a),fontWeight: FontWeight.bold,fontSize: 20),
        ),
        image: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.network(
              "https://www.washingtonpost.com/resizer/xx8hf7YOL0KAR3KyIeiOfgg1KCQ=/"
                  "arc-anglerfish-washpost-prod-washpost/public/JVUR6EDDEUI6VATXP3Z7JVD5MQ.jpg",
              height: 300),
        ),
        title: "CRISIS FLUTTER 1",
        body: "best way to spread the knowledge 1",

      ),
      PageViewModel(
        decoration: PageDecoration(
          titleTextStyle: TextStyle(color: Color(0xff2b106a),fontWeight: FontWeight.bold,fontSize: 25),
          bodyTextStyle: TextStyle(color: Color(0xff2b106a),fontWeight: FontWeight.bold,fontSize: 20),
        ),
        image: Image.network("https://www.washingtonpost.com/resizer/xx8hf7YOL0KAR3KyIeiOfgg1KCQ=/"
            "arc-anglerfish-washpost-prod-washpost/public/JVUR6EDDEUI6VATXP3Z7JVD5MQ.jpg",
            height: 300),
        title: "CRISIS FLUTTER 2",
        body: "best way to spread the knowledge 2",

      ),
      PageViewModel(
        decoration: PageDecoration(
          titleTextStyle: TextStyle(color: Color(0xff2b106a),fontWeight: FontWeight.bold,fontSize: 25),
          bodyTextStyle: TextStyle(color: Color(0xff2b106a),fontWeight: FontWeight.bold,fontSize: 20),
        ),
        image: Center(
          child: Image.network(
              "https://www.washingtonpost.com/resizer/xx8hf7YOL0KAR3KyIeiOfgg1KCQ=/"
                  "arc-anglerfish-washpost-prod-washpost/public/JVUR6EDDEUI6VATXP3Z7JVD5MQ.jpg",
              fit: BoxFit.cover,),
        ),
        title: "CRISIS FLUTTER 3",
        body: "best way to spread the knowledge 3",
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
          done: Text('Continue',
            style: TextStyle(
              color: Color(0xff2b106a),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          onDone: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>
                    LoginScreen()));
          },
          pages: getPages(),
          dotsDecorator: DotsDecorator(
            activeColor: Color(0xff2b106a),
          ),
        ),
    );
  }
}
