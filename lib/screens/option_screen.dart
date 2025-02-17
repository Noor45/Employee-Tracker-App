import 'package:office_orbit/employee_portal/auth/e_login.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';
import '../utils/fonts.dart';
import '../widgets/round_btn.dart';
import '../manager_portal/auth/m_login.dart';

class OptionScreen extends StatefulWidget {
  static const String ID = "option_screen";

  const OptionScreen({super.key});
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<OptionScreen> {
  // final _formKey = GlobalKey<FormState>();
  // late String _email;
  // bool isLoading = false;
  //
  // Future<void> _sendPasswordResetEmail() async {
  //   try {
  //     if (!_formKey.currentState!.validate()) return;
  //     _formKey.currentState!.save();
  //     setState(() {
  //       isLoading = true;
  //     });
  //     final response = await NetworkUtil.internal().post('forgot-password', body: {
  //       'email':  _email,
  //     });
  //     final output = jsonDecode(response.body);
  //     setState(() {
  //       isLoading = false;
  //     });
  //     if (output['code'] == 200) {
  //       msg(context,
  //           'Success',
  //           output['message']
  //       );
  //     } else if (output['code'] == 400){
  //       msg(
  //           context,
  //           'Failed',
  //           output['message']
  //       );
  //     }
  //   } catch(e){
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print(e);
  //   }
  //
  // }
  //
  // msg(BuildContext context, String title, String msg){
  //   showDialogAlert(
  //       context: context,
  //       title: title,
  //       message: msg,
  //       actionButtonTitle: 'OK',
  //       actionButtonOnPressed: (){
  //         Navigator.pop(context);
  //       }
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: ColorRefer.kPrimaryColor,
      //   centerTitle: true,
      //   iconTheme: const IconThemeData(
      //     color: ColorRefer.kPrimaryColor, //change your color here
      //   ),
      //   title: const Text(
      //     'Expense App',
      //     style:
      //     TextStyle(fontFamily: FontRefer.OpenSans),
      //   ),
      // ),
      body: Container(
        color: ColorRefer.kBackgroundColor,
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset('assets/images/onboarding.png', fit: BoxFit.cover,),


            // const AutoSizeText(
            //   'Expense Manager',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 18,
            //     color: ColorRefer.kPrimaryColor,
            //     fontWeight: FontWeight.w600,
            //     fontFamily: FontRefer.Roboto,
            //   ),
            // ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text('Streamline your company\'s operations. Begin by registering your company.', textAlign: TextAlign.center, style: TextStyle(color: ColorRefer.kPrimaryColor),),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CornerButton(
                title: 'Join as company',
                buttonRadius: const BorderRadius.only(topLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                textColor: ColorRefer.kPrimaryColor,
                colour: ColorRefer.kBackgroundColor,
                height: 50,
                onPressed: () async{
                  const baseUrl = 'https://office-orbit.desired-techs.com/register'; // Replace with your URL
                  final uniqueParam = DateTime.now().millisecondsSinceEpoch.toString();
                  final fullUrl = '$baseUrl?cache_buster=$uniqueParam';
                  final Uri _url = Uri.parse(fullUrl);
                  if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                  }
                  // Navigator.pushNamed(context, CompanySignInScreen.companySignInScreenID);
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CornerButton(
                title: 'Join as Employee',
                buttonRadius: const BorderRadius.only(topLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                textColor: ColorRefer.kPrimaryColor,
                colour: ColorRefer.kBackgroundColor,
                height: 50,
                onPressed: () {
                  Navigator.pushNamed(context, EmployeeSignInScreen.signInScreenID);
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CornerButton(
                title: 'Join as Manager',
                buttonRadius: const BorderRadius.only(topLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                textColor: ColorRefer.kPrimaryColor,
                colour: ColorRefer.kBackgroundColor,
                height: 50,
                onPressed: () {
                  Navigator.pushNamed(context, ManagerSignInScreen.signInScreenID);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
