import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Widgets/CustomeButton/GreenButton.dart';
import '../Functions/signinnavigation.dart';
import '../Provider/booleanvalueProvider.dart';
import '../Widgets/FormFieldTitle.dart';
import '../Widgets/TextFormField.dart';
import 'RoleSelectionPage.dart';
class Signinpage extends ConsumerWidget {
  final _Formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isObscure = ref.watch(obscurepasswordProvider);
    final TextEditingController emailcontroller= TextEditingController();
    final TextEditingController passwordcontroller=TextEditingController();
    return Scaffold(
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
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
                              ref.read(obscurepasswordProvider.notifier).update((state) => false);
                            } else {
                              ref.read(obscurepasswordProvider.notifier).update((state) => true);
                            }
                          },
                          icon: isObscure
                              ? Icon(
                                  Icons.visibility_off_sharp,
                                  color: Colors.green,
                                )
                              : Icon(Icons.remove_red_eye, color: Colors.green),
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
                      padding: const EdgeInsets.fromLTRB(8,20,8,8),
                      child: Greenbutton(
                        btname: "Sign in",
                        btfunction: () {
                          if(_Formkey.currentState!.validate()){
                            SigninNavigation(emailcontroller.text.trim(),passwordcontroller.text.trim(),context);
                          }
                          else{
                            print("data not enter completely");
                          }
                        },
                        btwidth: double.infinity,
                        btheight: 45.sp,
                        textsize: 14.sp,
                      ),
                    ),

                    // Or text with divider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: Divider(color: Colors.black12,)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('or',style: GoogleFonts.poppins(color: Colors.grey),),
                        ),
                        Expanded(child: Divider(color: Colors.black12,)),
                      ],
                    ),

                    // Continue with Google button
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,30,8,8),
                      child: InkWell(
                       onTap: (){},
                       borderRadius: BorderRadius.circular(15.r),
                       splashColor: Colors.transparent,
                       child: Container(
                         height: 45.h,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15.r),
                           border: BoxBorder.all(
                             color: Colors.grey,
                             width: 0.5
                           )
                         ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("lib/assets/images/google_logo.svg",height: 20.h,width: 20.h,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Continue with Google",style:GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500),),
                            )
                          ],
                        ),
                       ),
                                         ),
                    ),

                    // Create Account TextButton
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,15,8,8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("New to KrishiSetu?",style: GoogleFonts.poppins(color: Colors.grey,fontSize: 13.sp),),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Roleselectionpage(),));
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
    );
  }
}
