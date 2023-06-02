import 'dart:io';

import 'package:chatbro/features/chat/screens/profile_screen.dart';
import 'package:chatbro/features/select_contacts/screens/contact_screen.dart';
import 'package:chatbro/features/status/screens/confirm_status_screen.dart';
import 'package:chatbro/features/status/screens/status_detail.dart';
import 'package:chatbro/features/status/screens/status_screen.dart';
import 'package:chatbro/models/status_model.dart';
import 'package:chatbro/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:chatbro/common/widgets/error.dart';
import 'package:chatbro/features/auth/screens/login_screen.dart';
import 'package:chatbro/features/auth/screens/otp_screen.dart';
import 'package:chatbro/features/auth/screens/user_information_screen.dart';
import 'package:chatbro/features/group/screens/create_group_screen.dart';

import 'package:chatbro/features/chat/screens/mobile_chat_screen.dart';

import 'package:page_transition/page_transition.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
        ),
      );
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInformationScreen(),
      );

    case ContactScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const ContactScreen(),
      );
    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final user = arguments['user'];
      final nameContact = arguments['nameContact'];
      final group = arguments['group'];
      final isGroupChat = arguments['isGroupChat'];
      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(
          group: group,
          user: user,
          isGroupChat: isGroupChat,
          nameContact: nameContact,
        ),
      );

    case ProfileScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final UserModel user = arguments['user'];
      final String nameContact = arguments['nameContact'];
      return PageTransition(
        child: ProfileScreen(user: user, nameContact: nameContact),
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 800),
      );

    case StatusScreen.routeName:
      // final status = settings.arguments as Status;
      return MaterialPageRoute(
        builder: (context) => const StatusScreen(),
      );
    case ConfirmStatusScreen.routeName:
      final file = settings.arguments as File?;
      return MaterialPageRoute(
        builder: (context) => ConfirmStatusScreen(
          file: file,
        ),
      );
    case StatusDetailScreen.routeName:
      final status = settings.arguments as Status;
      return MaterialPageRoute(
        builder: (context) => StatusDetailScreen(
          status: status,
        ),
      );
    case CreateGroupScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const CreateGroupScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exist'),
        ),
      );
  }
}
