import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chatbro/models/user_model.dart';

abstract class AbstractAuth {
  Future<UserModel?> getUserData();
  Future<void> signInWithPhone(BuildContext context, String phoneNumber);
  void verifyOTP(BuildContext context, String verificationId, String userOTP);
  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic);
  Stream<UserModel> userDataById(String userId);
  void setUserState(bool isOnline);
}
