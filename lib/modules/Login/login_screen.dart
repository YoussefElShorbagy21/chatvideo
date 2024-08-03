import 'package:chatvideo/shared/resources/asset_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
   const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:  CrossAxisAlignment.center,
        children: [
          Image.asset(ImageAssets.logo,
          fit: BoxFit.cover,
          ),
          const Text(
            'Login Screen With Google',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(Colors.white),
              ),
              onPressed: (){
                singInWithGoogle();
              },
              child: const Text('Sign in with Google',
              style: TextStyle(
                color: Colors.black,
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

singInWithGoogle() async {
  GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
  GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
  AuthCredential credential = GoogleAuthProvider.credential(
    idToken: googleSignInAuthentication.idToken,
    accessToken: googleSignInAuthentication.accessToken,
  );
  UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);

  await FirebaseFirestore.instance.collection('users').doc(user.user!.uid).set({
    'name': user.user!.displayName,
    'email': user.user!.email,
    'image': user.user!.photoURL,
    'uid': user.user!.uid,
  });


}