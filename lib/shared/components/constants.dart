import 'package:flutter/material.dart';
import '../network/local/cache_helper.dart';


/*void singOut(context) {
  CacheHelper.clearData(key: 'ID').then((value) {
    CacheHelper.clearData(key: 'TokenId');
    if (value == true) {
      // HomeCubit.get(context).userData = null ;
      navigateFish(context, const LoginScreen()); // add Login Screen here because singOut and login again
      debugPrint("token inside clear data : $token uid : $uid");
    }
  });

  if (token != null || uid != null) {
    token = null;
    uid = null;
    debugPrint("token in side if condition: $token uid : $uid");
  }
  debugPrint('token : $token');
  debugPrint('uid: $uid');
}*/


void navigateFish(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
        (route) => false,
  );
}

String? token = CacheHelper.getData(key: 'TokenId');

String? refreshToken = CacheHelper.getData(key: 'refreshToken');

String? uid = CacheHelper.getData(key: 'ID');

bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

bool? language = CacheHelper.getData(key: 'SettingsPage');

