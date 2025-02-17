import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../api/networkUtils.dart';
import '../../../../utils/colors.dart';
import '../../cards/appbar_card.dart';
import '../../utils/fonts.dart';
import '../../utils/strings.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/input_filed.dart';
import '../../widgets/round_btn.dart';

class PrivacyAndPolicyScreen extends StatefulWidget {
  static const String ID = "privacy_and_policy_screen";

  const PrivacyAndPolicyScreen({super.key});
  @override
  _PrivacyAndPolicyScreenState createState() => _PrivacyAndPolicyScreenState();
}

class _PrivacyAndPolicyScreenState extends State<PrivacyAndPolicyScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: 'Privacy and Policy',
        leadingWidget: const BackButton(
          color: ColorRefer.kBackgroundColor,
        ),
      ),
      backgroundColor: ColorRefer.kBackgroundColor,
      body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Text(StringRefer.privacyAndPolicy, textAlign: TextAlign.justify, style: TextStyle(fontFamily: FontRefer.Roboto, fontSize: 15)),
          )
      ),
    );
  }
}
