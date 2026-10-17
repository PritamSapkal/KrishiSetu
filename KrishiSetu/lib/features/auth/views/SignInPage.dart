import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/Widgets/CustomeButton/GreenButton.dart';
import '../../../core/Widgets/FormFieldTitle.dart';
import '../../../core/Widgets/TextFormField.dart';
import '../../../core/utils/signinnavigation.dart';
import '../../fpo/viewmodels/booleanvalueProvider.dart';
import 'RegistrationScreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class Signinpage extends ConsumerStatefulWidget {
  const Signinpage({super.key});

  @override
  ConsumerState<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends ConsumerState<Signinpage> {
  final _Formkey = GlobalKey<FormState>();

  var _isLoading = false;

  Future<String?> signin(String email, String password,BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      var url=Uri.parse("http://10.227.34.36:8080/auth/login");

      http.Response response= await http.post(url,
          headers:{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body:jsonEncode({
      "email":email,
      "password":password,
      })).timeout(Duration(seconds: 5));

      if(response.statusCode==200||response.statusCode==201){
        var data=jsonDecode(response.body.toString());
        print(data);
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Login Successful",
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ));
        return data['user']['role'].toString();
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Login failed (${response.statusCode})",
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Login failed : Please Ckeck Your Internet Connection..!, but temporarly we continuw with teh offline login",
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
        ),
      );
      SigninNavigation(email,context);
    }

    finally{
      print('Executed Finally Block');

      if (mounted && _isLoading) {
        setState(() {
          _isLoading = false;
        });
      }
  }
  }
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isObscure = ref.watch(obscurepasswordProvider);

    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      progressIndicator: const CircularProgressIndicator(
        color: Colors.green,
        backgroundColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              // first green container welcome back and sign in to continue text
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff135018), Color(0xff43A047)],
                    begin: AlignmentGeometry.topCenter,
                    end: AlignmentGeometry.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Krishisetu logo and text row
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                        child: Row(
                          children: [
                            // logo container
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: Container(
                                height: 25.h,
                                width: 25.w,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20.sp,
                                      spreadRadius: 10.sp,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.seedling,
                                    color: Color(0xFFFFCC00),
                                    size: 10.sp,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "KrishiSetu",
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      //Welcome back 👋 text
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 8, 0),
                        child: Text(
                          "Welcome back 👋",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                        ),
                      ),
                      // Sign in to continue text
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 8, 8),
                        child: Text(
                          "Sign in to continue",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //second container
              Form(
                key: _Formkey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email Adress Field & Label
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Formfieldtitle(title: "Email Address"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Textformfieldwidget(
                          controller: emailcontroller,
                          KeyBoardType: TextInputType.emailAddress,
                          isObscure: false,
                          errormessage: "Please enter valid email address",
                          hinttext: "Enter e-mail address",
                          prefixicon: Icon(
                            Icons.mail_outline_sharp,
                            color: Colors.green,
                          ),
                        ),
                      ),

                      // PassWord Field & Label
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                        child: Formfieldtitle(title: "Password"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Textformfieldwidget(
                          controller: passwordcontroller,
                          suffixicon: IconButton(
                            onPressed: () {
                              if (isObscure) {
                                ref
                                    .read(obscurepasswordProvider.notifier)
                                    .update((state) => false);
                              } else {
                                ref
                                    .read(obscurepasswordProvider.notifier)
                                    .update((state) => true);
                              }
                            },
                            icon: isObscure
                                ? Icon(
                                    Icons.visibility_off_sharp,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.green,
                                  ),
                          ),
                          isObscure: isObscure,
                          errormessage: "Please enter valid password",
                          hinttext: "Enter your password",
                          prefixicon: Icon(Icons.lock, color: Colors.green),
                        ),
                      ),

                      // Forgot password Text Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?",
                              style: GoogleFonts.poppins(
                                color: Color(0xff165c24),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Sign in button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                        child: Greenbutton(
                          btname: "Sign in",
                          btfunction: ()async{
                            if (_Formkey.currentState!.validate()) {
                              String? role= await signin(emailcontroller.text.trim(),passwordcontroller.text.trim(),context);
                              print(role);
                              if(role!=null){
                               SigninNavigation(role,context);
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please  Enterr data Correctly",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  backgroundColor: Color(0xff135018),
                                ),
                              );
                            }
                          },

                          btwidth: double.infinity,
                          btheight: 45.sp,
                          textsize: 14.sp,
                        ),
                      ),

                      // Create Account TextButton
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New to KrishiSetu?",
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 13.sp,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegistrationScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Create Account",
                                style: GoogleFonts.poppins(
                                  color: Color(0xff165c24),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
