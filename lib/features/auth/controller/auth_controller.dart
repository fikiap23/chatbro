import 'dart:io';
import 'package:chatbro/features/auth/abstraction/abstract_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chatbro/features/auth/repository/auth_repository.dart';
import 'package:chatbro/models/user_model.dart';

// Provider untuk mengatur controller yang terkait dengan autentikasi pengguna
final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

// Provider untuk memberikan data pengguna saat ini pada aplikasi
final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController implements AbstractAuth {
  final AuthRepositoryInterface authRepository;
  final ProviderRef ref;

  AuthController({
    required this.authRepository,
    required this.ref,
  });

  // Method untuk mendapatkan data pengguna saat ini dari repository
  @override
  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  // Method untuk melakukan proses sign-in dengan nomor telepon
  @override
  Future<void> signInWithPhone(BuildContext context, String phoneNumber) async {
    await authRepository.signInWithPhone(context, phoneNumber);
  }

  // Method untuk memverifikasi kode OTP yang diterima oleh pengguna
  @override
  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  // Method untuk menyimpan data pengguna ke Firebase
  @override
  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirebase(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }

  // Method untuk mendapatkan data pengguna berdasarkan ID-nya
  @override
  Stream<UserModel> userDataById(String userId) {
    return authRepository.userData(userId);
  }

  // Method untuk mengubah status online/offline pengguna
  @override
  void setUserState(bool isOnline) {
    authRepository.setUserState(isOnline);
  }
}
