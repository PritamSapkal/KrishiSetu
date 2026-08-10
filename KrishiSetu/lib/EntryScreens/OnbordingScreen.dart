import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../CustomeButton/GreenButton.dart';
import '../Data/onbordingScreenList.dart';
import '../Provider/IndexHandlingProvider.dart';
import 'SignInPage.dart';

class Onbordingscreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<Onbordingscreen> createState() => _OnbordingscreenState();
}

class _OnbordingscreenState extends ConsumerState<Onbordingscreen> {
  @override
  Widget build(BuildContext context) {
    PageController _pagecontoller = PageController();
    var bordinglist = onbordingscreenlist;
    int index = ref.watch(OnbordingindexProvider);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            PageView.builder(
              controller: _pagecontoller,
              physics: ClampingScrollPhysics(),
              onPageChanged: (index) {
                ref
                    .read(OnbordingindexProvider.notifier)
                    .update((state) => index);
              },
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // Image
                    Expanded(
                      child: Image.asset(
                        bordinglist[index].imgepath,
                        fit: BoxFit.fill,
                      ),
                    ),
                    // text Container
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 30.sp,
                              spreadRadius: 50.sp,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,

                          children: [
                            // headline text
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                              child: Text(
                                bordinglist[index].headline,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                    ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            // subcontent text
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10,
                              ),
                              child: Text(
                                bordinglist[index].subcontent,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: Colors.grey,
                                      fontSize: 13.sp,
                                    ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: bordinglist.length,
            ),
            // Skip Button
            Positioned(
              top: 20.h,
              right: 10.w,
              child: ElevatedButton(
                onPressed: () {
                  ref
                      .read(OnbordingindexProvider.notifier)
                      .update((state) => 2);
                  _pagecontoller.animateToPage(
                    3,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.001),
                ),
                child: Text(
                  "Skip",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Smooth page Indicator
            Positioned(
              bottom: 140.h,
              child: SmoothPageIndicator(
                controller: _pagecontoller,
                count: bordinglist.length,
                effect:SwapEffect(activeDotColor: Color(0xff2E7D32),radius:10.r,dotWidth:10.w,dotHeight:10.h),
              ),
            ),
            // Next & Get Started Button
            Positioned(
              bottom: 70.h,
              child: index < 2
                  ? Greenbutton(
                      btname: "Next",
                      textsize: 15.sp,
                      btheight: 40.h,
                      btwidth: 300.w,
                      btfunction: () {
                        ref
                            .read(OnbordingindexProvider.notifier)
                            .update((state) => state++);
                        _pagecontoller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear,
                        );
                      },
                    )
                  : Greenbutton(
                      btname: "Get Started",
                      textsize: 15.sp,
                      btheight: 40.h,
                      btwidth: 300.w,
                      btfunction: () {
                        ref
                            .read(OnbordingindexProvider.notifier)
                            .update((state) => state++);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signinpage()),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
