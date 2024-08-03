import 'package:flutter/material.dart';

import '../../shared/components/constants.dart';
import '../../shared/resources/asset_manager.dart';

class SplashScreen extends StatefulWidget {
  final Widget startWidget ;
  const SplashScreen({super.key,required this.startWidget});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with SingleTickerProviderStateMixin{
  late AnimationController animationController ;
  late Animation<Offset> animation ;

  @override
  void initState() {
    super.initState();

    initSlidingAnimation();
    navigateToHome();
  }


  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SlideTransition(
          position: animation,
          child: Image.asset(ImageAssets.logo),
        )
      ),
    );
  }


  void initSlidingAnimation(){
    animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 800));
    animation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(animationController);
    animationController.forward();
  }


  void  navigateToHome(){
    Future.delayed(const Duration(seconds: 4),(){
      navigateFish(context,widget.startWidget);
    });
  }
}


