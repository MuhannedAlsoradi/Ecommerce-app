// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:salla_app/models/on_board_model.dart';
import 'package:salla_app/modules/login_screen.dart';
import 'package:salla_app/shared/components/components.dart';
import 'package:salla_app/shared/network/local/cache_helper.dart';
import 'package:salla_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> boarding = [
    OnBoardingModel(
      image: 'assets/images/ecommerce.png',
      title: 'On board title 1',
      body: 'On board body 1',
    ),
    OnBoardingModel(
      image: 'assets/images/ecommerce.png',
      title: 'On board title 2',
      body: 'On board body 2',
    ),
    OnBoardingModel(
      image: 'assets/images/ecommerce.png',
      title: 'On board title 3',
      body: 'On board body 3',
    ),
  ];

  var onBoardController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text(
              'SKIP',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14.0,
                    color: kDefualtColor,
                  ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildBoardItem(context, boarding[index]),
                itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
                controller: onBoardController,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                    print('last page');
                  } else {
                    setState(() {
                      isLast = false;
                    });
                    print('not last page');
                  }
                },
              ),
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: onBoardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      expansionFactor: 3,
                      dotColor: Colors.grey,
                      activeDotColor: kDefualtColor),
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      onBoardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then(
      (value) {
        if (value) {
          navigateAndFinish(context: context, widget: LoginScreen());
          print(value);
        }
      },
    );
  }
}

Widget buildBoardItem(context, OnBoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(
            model.image,
            height: 600.0,
            width: 600.0,
          ),
        ),
        Text(
          model.title,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          model.body,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
