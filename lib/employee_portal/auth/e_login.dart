import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:office_orbit/employee_portal/auth/e_signup.dart';
import 'package:office_orbit/manager_portal/auth/m_signup.dart';
import 'package:office_orbit/model/department_model.dart';
import 'package:office_orbit/model/manager_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../api/networkUtils.dart';
import '../../cards/appbar_card.dart';
import '../../funtions/helping_funtion.dart';
import '../../model/company_model.dart';
import '../../model/employee_model.dart';
import '../../model/user_model.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/fonts.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/input_filed.dart';
import '../../widgets/round_btn.dart';
import '../screens/main_screen_employee.dart';
import 'e_forget_password.dart';

class EmployeeSignInScreen extends StatefulWidget {
  static String signInScreenID = "/e_sign_in_screen";
  const EmployeeSignInScreen({super.key});

  @override
  State<EmployeeSignInScreen> createState() => _EmployeeSignInScreenState();
}

class _EmployeeSignInScreenState extends State<EmployeeSignInScreen> {
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: const CircularProgressIndicator(
        color: ColorRefer.kPrimaryColor,
      ),
      child: Scaffold(
        appBar: appBar(
          title: 'Sign In',
          leadingWidget: BackButton(
            color: ColorRefer.kBackgroundColor,
          ),
        ),
        backgroundColor: ColorRefer.kBackgroundColor,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 55),
                  Image.asset(
                    'assets/images/login.png',
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                  const SizedBox(height: 16),
                  const Text('Sign In as Employee',
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorRefer.kPrimaryColor,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(height: 20),
                  InputField(
                    textInputType: TextInputType.emailAddress,
                    label: 'Email',
                    hintText: 'user@mail.com',
                    validator: (String? emailValue) {
                      if (email?.isEmpty ?? true) {
                        return 'Email is required';
                      } else {
                        String p =
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                        RegExp regExp = RegExp(p);
                        if (regExp.hasMatch((email ?? ""))) {
                          return null;
                        } else {
                          return 'Email Syntax is not Correct';
                        }
                      }
                    },
                    onChanged: (value) => email = value,
                    controller: null,
                  ),
                  const SizedBox(height: 15),
                  PasswordInputField(
                    label: 'Password',
                    hintText: '• • • • • • • • •',
                    textInputType: TextInputType.emailAddress,
                    obscureText: true,
                    validator: (String? password) {
                      if (password?.isEmpty ?? true) {
                        return "Password is required!";
                      }
                      if ((password ?? "").length < 6) {
                        return "Minimum 6 characters are required";
                      }
                      return null;
                    },
                    onChanged: (value) => password = value,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, EmployeeForgetPasswordScreen.ID),
                        child: Center(
                          child: AutoSizeText(
                            'Forgot Password?',
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: FontRefer.DMSans,
                                color: ColorRefer.kTextColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  RoundedButton(
                      title: 'SIGN IN',
                      buttonRadius: 25,
                      colour: ColorRefer.kPrimaryColor,
                      height: 48,
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) return;
                        await signIn();
                      }),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: FontRefer.DMSans,
                          color: ColorRefer.kTextColor,
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                          onTap: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const EmployeeSignUPScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: FontRefer.DMSans,
                                color: ColorRefer.kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signIn() async {
    try {
      setState(() {
        isLoading = true; // Show loading indicator
      });
      if (email == null || password == null) {
        setState(() {
          isLoading = false; // Show loading indicator
        });
        throw Exception("Email or password is null");
      }
      final response = await NetworkUtil.internal().post(
        '/api/employee/login',
        body: {
          'email': email!,
          'password': password!,
        },
      ).timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        final output = jsonDecode(response.body);

        if (int.parse(output['employee']['status']) == 0) {
          showDialogAlert(
              context: context,
              title: "No Access",
              actionButtonTextStyle:
                  const TextStyle(color: ColorRefer.kPrimaryColor),
              message: 'Your account is not approved yet.',
              actionButtonTitle: "OK",
              actionButtonOnPressed: () {
                Navigator.pop(context);
                setState(() {
                  isLoading = false;
                });
              });
        } else {
          var sessionManager = SessionManager();
          await sessionManager.set('emp', true);
          await sessionManager.set(
              "employee_detail", jsonEncode(output['employee']));
          await sessionManager.set(
              "department", jsonEncode(output['department']));
          await sessionManager.set("manager", jsonEncode(output['manager']));
          await sessionManager.set("employee_token", output['token']);
          Constants.employeeDetail =
              EmployeeModel.fromMap(output['employee'] as Map<String, dynamic>);
          Constants.employeeDepartment = DepartmentModel.fromMap(
              output['department'] as Map<String, dynamic>);
          Constants.employeeManagerDetail =
              ManagerModel.fromMap(output['manager'] as Map<String, dynamic>);
          Constants.userId = Constants.employeeDetail!.id!;
          Constants.userToken = output['token'];
          Constants.companyToken = Constants.employeeDetail!.companyToken!;
          for (var e in Constants.companyList!) {
            if (Constants.companyToken == e.token!) {
              Constants.companyDetail = e;
            }
          }
          print(Constants.companyDetail);
          await getEmployeeData();
          setState(() {
            isLoading = false;
          });
          Navigator.pushNamedAndRemoveUntil(
              context, EmployeeMainScreen.ID, (r) => false);
        }
      } else {
        final output = jsonDecode(response.body);
        setState(() {
          isLoading = false; // Show loading indicator
        });
        showDialogAlert(
            context: context,
            title: "Invalid",
            actionButtonTextStyle:
                const TextStyle(color: ColorRefer.kPrimaryColor),
            message: output['message'],
            actionButtonTitle: "OK",
            actionButtonOnPressed: () {
              Navigator.pop(context);
            });
      }
    } on http.ClientException catch (e) {
      print('TimeoutException: $e');
      netWorkError();
    } on SocketException catch (e) {
      print('SocketException: $e');
      netWorkError();
    } on TimeoutException catch (e) {
      print('SocketException: $e');
      netWorkError();
    }
  }

  netWorkError() {
    setState(() {
      isLoading = false;
    });
    showDialogAlert(
        context: context,
        title: "Network Error",
        actionButtonTextStyle: const TextStyle(color: ColorRefer.kPrimaryColor),
        message: 'Connection has not been built, try again later',
        actionButtonTitle: "OK",
        actionButtonOnPressed: () {
          Navigator.pop(context);
          setState(() {
            isLoading = false;
          });
        });
  }
}
