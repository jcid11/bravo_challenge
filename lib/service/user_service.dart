import 'package:bravo_challenge/data/user_interface.dart';
import 'package:bravo_challenge/utils/ws_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserService implements UserInterface {
  @override
  Future<WsResponse> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<WsResponse> createUserInFirebase(
      {required String email}) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('User').doc(email).get();
    String error = 'an error has occurred';
      try {
        await FirebaseFirestore.instance
            .collection('User')
            .doc(email)
            .set({'email': email});
        return WsResponse(success: true);
        // Navigate to the home screen
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          error = 'User not found';
        } else if (e.code == 'wrong-password') {
          error = 'Wrong password provided for that user.';
        } else {
          error = 'An error occurred';
        }
        return WsResponse(message: error, success: false);
      }
  }


}
