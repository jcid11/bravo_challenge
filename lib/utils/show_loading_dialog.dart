import 'package:bravo_challenge/utils/extensions.dart';
import 'package:bravo_challenge/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


Future<void> showLoading(BuildContext context) {
  return showDialog<void>(
    context: context,
    useSafeArea: false,
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100.0,
            width: 88.0,
            child: Card(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: -2,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Lottie.asset(
                          'assets/lottie/loading-animation.json',
                          width: 80,
                          height: 80,
                          filterQuality: FilterQuality.medium,
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      top: 63,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Loading...',
                            style: context.loginTextStyle!.copyWith(
                                color: ThemeApp.primaryColor, fontSize: 10),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      );
    },
  );
}