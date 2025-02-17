import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../controller/employee_controller.dart';
import '../controller/manager_controller.dart';
import '../screens/option_screen.dart';
import '../utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';
import '../screens/term_and_condition.dart';
import '../screens/privacy_policy.dart';
import 'dialogs.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({this.scaffoldKey});
  final scaffoldKey;
  void _launchEmail() async {
    // Email email = Email(to: ['support@mail.com']);
    // await EmailLauncher.launch(email);
    // var url = Uri.parse("mailto:noorrose45@gmail.com");
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@desired-tech.com',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.only(
            left: 30,
            top: 50,
          ),
          children: <Widget>[
            SizedBox(height: 30),
            // ListTile(
            //   leading: SvgPicture.asset('assets/icons/about.svg',
            //       colorFilter: ColorFilter.mode(
            //           ColorRefer.kPrimaryColor, BlendMode.srcIn)),
            //   title: Text(
            //     'About',
            //     style: TextStyle(
            //       color: ColorRefer.kPrimaryColor,
            //     ),
            //   ),
            //   onTap: () => {},
            // ),
            ListTile(
              leading: SvgPicture.asset('assets/icons/privacy_policy.svg',
                  colorFilter: ColorFilter.mode(
                      ColorRefer.kPrimaryColor, BlendMode.srcIn)),
              title: Text(
                'Privacy Policy',
                style: TextStyle(
                  color: ColorRefer.kPrimaryColor,
                ),
              ),
              onTap: () {
                  Navigator.pushNamed(context, PrivacyAndPolicyScreen.ID);
              },
            ),
            ListTile(
              leading: SvgPicture.asset('assets/icons/term_condition.svg',
                  colorFilter: ColorFilter.mode(
                      ColorRefer.kPrimaryColor, BlendMode.srcIn)),
              title: Text(
                'Terms and Conditions',
                style: TextStyle(color: ColorRefer.kPrimaryColor),
              ),
              onTap: () {
                Navigator.pushNamed(context, TermsAndConditionScreen.ID);
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/faq.svg',
                color: ColorRefer.kPrimaryColor,
              ),
              title: Text(
                'Contact us',
                style: TextStyle(
                  color: ColorRefer.kPrimaryColor,
                ),
              ),
              onTap: () async {
                _launchEmail();
              },
            ),
            SizedBox(height: 40),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/logout.svg',
                color: ColorRefer.kPrimaryColor,
              ),
              title: Text(
                'Log Out',
                style: TextStyle(color: ColorRefer.kPrimaryColor),
              ),
              onTap: () async {
                showDialogAlert(
                  context: context,
                  title: 'Logout',
                  message: 'Are you sure you want to logout now?',
                  actionButtonTitle: 'Logout',
                  cancelButtonTitle: 'Cancel',
                  actionButtonTextStyle: const TextStyle(
                    color: Colors.red,
                  ),
                  cancelButtonTextStyle: const TextStyle(
                    color: Colors.black45,
                  ),
                  actionButtonOnPressed: () async {
                    dynamic employeeCheck =
                        await SessionManager().containsKey("emp");
                    dynamic managerCheck =
                        await SessionManager().containsKey("mang");
                    if (employeeCheck) {
                      EmployeeController.logout();
                    }
                    if (managerCheck) {
                      ManagerController.logout();
                    }
                    clear();
                    await SessionManager().remove("emp");
                    await SessionManager().remove("employee_token");
                    await SessionManager().remove("employee_detail");
                    await SessionManager().remove("manager");
                    await SessionManager().remove("department");
                    await SessionManager().remove("mang");
                    await SessionManager().remove("manager_token");
                    await SessionManager().remove("manager_detail");
                    Navigator.pushNamedAndRemoveUntil(context, OptionScreen.ID,
                        (Route<dynamic> route) => false);
                  },
                  cancelButtonOnPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
