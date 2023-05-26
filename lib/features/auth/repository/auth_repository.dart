import 'dart:io';

import 'package:chatbro/common/widgets/show_alert_dialog.dart';
import 'package:chatbro/common/widgets/show_loading_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatbro/common/repositories/common_firebase_storage_repository.dart';
import 'package:chatbro/features/auth/screens/otp_screen.dart';
import 'package:chatbro/features/auth/screens/user_information_screen.dart';
import 'package:chatbro/models/user_model.dart';
import 'package:chatbro/mobile_layout_screen.dart';

// Membuat provider untuk AuthRepository
final authRepositoryProvider = Provider(
  (ref) => AuthRepositoryInterface(
    repository: _AuthRepository(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ),
  ),
);

class _AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  // Constructor AuthRepository
  _AuthRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

// Method untuk mengambil data user saat ini
  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await _firestore.collection('users').doc(_auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

// Method untuk melakukan sign in dengan nomor telepon
  Future<void> signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      showLoadingDialog(
        context: context,
        message: "Sending a verification code to $phoneNumber",
      );
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
            context,
            UserInformationScreen.routeName,
            (route) => false,
          );
        },
        verificationFailed: (e) {
          showAlertDialog(context: context, message: e.toString());
        },
        codeSent: ((String verificationId, int? resendToken) async {
          Navigator.pushNamed(
            context,
            OTPScreen.routeName,
            arguments: verificationId,
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.message!);
    }
  }

// Method untuk memverifikasi kode OTP
  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      showLoadingDialog(
        context: context,
        message: 'Verifiying code ... ',
      );
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await _auth.signInWithCredential(credential);
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        UserInformationScreen.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showAlertDialog(context: context, message: e.message!);
    }
  }

// Method untuk menyimpan data user ke firebase
  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      showLoadingDialog(
        context: context,
        message: "Saving user info ... ",
      );
      String uid = _auth.currentUser!.uid;
      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase(
              'profilePic/$uid',
              profilePic,
            );
      }

      var user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        isOnline: true,
        phoneNumber: _auth.currentUser!.phoneNumber!,
        groupId: [],
      );

      await _firestore.collection('users').doc(uid).set(user.toMap());

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MobileLayoutScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

// Mendapatkan data pengguna dari Firestore
  Stream<UserModel> userData(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

// Mengatur status pengguna apakah sedang online atau offline
  void setUserState(bool isOnline) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      'isOnline': isOnline,
    });
  }
}

// Kelas AuthRepositoryInterface berfungsi sebagai antarmuka publik untuk berinteraksi dengan AuthRepository.
class AuthRepositoryInterface {
  final _AuthRepository _repository;

  AuthRepositoryInterface({required _AuthRepository repository})
      : _repository = repository;

  Future<UserModel?> getCurrentUserData() => _repository.getCurrentUserData();

  Future<void> signInWithPhone(BuildContext context, String phoneNumber) =>
      _repository.signInWithPhone(context, phoneNumber);

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) =>
      _repository.verifyOTP(
        context: context,
        verificationId: verificationId,
        userOTP: userOTP,
      );

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) =>
      _repository.saveUserDataToFirebase(
        name: name,
        profilePic: profilePic,
        ref: ref,
        context: context,
      );

  Stream<UserModel> userData(String userId) => _repository.userData(userId);

  void setUserState(bool isOnline) => _repository.setUserState(isOnline);
}
