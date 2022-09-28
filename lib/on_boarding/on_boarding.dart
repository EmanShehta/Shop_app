import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/Screens/login/login.dart';
import 'package:shop_app/network/local/cachehelper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../shared/Components.dart';

class modelbording {
  final String image;
  final String title;
  final String body;
  modelbording({
    required this.image,
    required this.title,
    required this.body,
  });
}

class onBoarding_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _onBoarding_screenState();
}

class _onBoarding_screenState extends State<onBoarding_screen> {
  var borad_controller = PageController();
  List<modelbording> boarding = [
    modelbording(
        image: 'assets/onbording.jpg',
        title: 'On borad 1title',
        body: 'on board 1body'),
    modelbording(
        image: 'assets/onboarding2.jpg',
        title: 'On borad 2title',
        body: 'on board 2body'),
    modelbording(
        image: 'assets/onboarding3.jpg',
        title: 'On borad 3title',
        body: 'on board 3body'),
  ];
  bool islast = false;
  @override
  @override
  void submit() {
    CahceHelper.saveData(Key: 'onBorading', Value: true).then((value) {
      if (value!) {
        navigateAndFinish(context, Shoplogin_screen());
      }
    });
    navigateAndFinish(context, Shoplogin_screen());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              // navigateAndFinish(context, Shoplogin_screen());
              submit();
            },
            child: Text('SKIP'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: borad_controller,
                onPageChanged: (int idx) {
                  if (idx == boarding.length - 1) {
                    setState(() {
                      islast = true;
                    });
                    print('last');
                  } else {
                    setState(() {
                      islast = false;
                    });
                    print('notlast');
                  }
                },
                itemBuilder: (context, index) =>
                    buildonbordingitem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: borad_controller,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: HexColor("FB716F"),
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      // navigateAndFinish(context, Shoplogin_screen());
                      submit();
                    } else {
                      borad_controller.nextPage(
                          duration: Duration(
                            milliseconds: 650,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios_sharp),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildonbordingitem(modelbording model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: 600,
              height: 400,
              child: Image(
                image: AssetImage('${model.image}'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          //PageView.builder(itemBuilder: (context,index))
        ],
      );
}
