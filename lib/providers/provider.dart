
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../database_utils/database_utils.dart';
import '../models/user_model.dart';

class MyProvider extends ChangeNotifier{
  MyUser? myUser  ;
  User? firebaseUser;

  MyProvider(){
    firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser != null){
      initUser();
    }
  }

  void initUser()async{
    myUser = await DataBaseUtils.readUserFromFirestore(firebaseUser?.uid??'');
  }

}