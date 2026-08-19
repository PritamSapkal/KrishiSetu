import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Data/FPO_Dummy_Data/Order_dummy_data.dart';
import '../../../Data/FPO_Dummy_Data/farmer_dummy_data.dart';
import '../../../Data/FPO_Dummy_Data/fpo_dummy_data.dart';
import '../../../Data/FPO_Dummy_Data/listing_dummy_data.dart';
import '../../../Data/FPO_Dummy_Data/produce_dummy_data.dart';
import '../../../Functions/GreetingFunction.dart';
import '../../../Provider/FPO_totalproducesProvider.dart';
import '../../../Provider/IndexHandlingProvider.dart';
import '../../../Widgets/Customebackgroundcontainer.dart';
import '../../../Widgets/DashBoardOverviewCart.dart';
import '../../../Widgets/QuickActionCart.dart';
import '../../../Widgets/customTitle.dart';

class Homescreen extends ConsumerStatefulWidget{
  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffF8F9FA),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Fpo name and Location block
             Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff9E551B),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.r),bottomRight: Radius.circular(20.r)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15,20,15,20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(getGreeting()+" ,",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20.sp),),
                      Text(fpoData.name+" FPO",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20.sp),),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            FaIcon(FontAwesomeIcons.locationDot,color: Colors.white.withOpacity(0.8),size: 12.sp,),
                             SizedBox(width: 3.w,),
                            Text(fpoData.district+" District,"+fpoData.state,style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.8),fontWeight: FontWeight.bold,)),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),

            // Dashboard Overview title
            Padding(
              padding: const EdgeInsets.fromLTRB(15,20,15,10),
              child: Customtitle(title:"Dashboard Overview",size: 15.sp,),
            ),

            // Gridview Dashboard Overview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 220.h,
                child: GridView.count(crossAxisCount: 2,
                physics: ClampingScrollPhysics(),
                crossAxisSpacing:20.sp,
                  mainAxisSpacing: 10.sp,
                  mainAxisExtent: 100.sp,
                  children: [
                    // Farmer
                    InkWell(
                      borderRadius:BorderRadius.circular(20),
                      onTap: (){
                        ref.read(BottomAppbarIndexProvider.notifier).update((state)=>3);
                      },
                      child: Dashboardoverviewcart(carttitle:"Farmer" ,icon:Icons.people_alt_outlined ,iconColor:Color(0xff964900) ,widget: Customtitle(title: farmerslist.length.toString(),size: 25.sp,),),
                    ),

                    //Produces
                    InkWell(
                      borderRadius:BorderRadius.circular(20),
                      onTap: (){
                        ref.read(BottomAppbarIndexProvider.notifier).update((state)=>1);
                      },
                      child: Dashboardoverviewcart(carttitle:"Produce" ,icon:Icons.energy_savings_leaf_outlined,iconColor:Color(0xff328035) ,widget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Customtitle(title:ref.watch(totalProducesProvider).toString() ,size: 25.sp,),
                           Text("  Tons",style: GoogleFonts.poppins(color: Colors.grey,fontWeight: FontWeight.bold),)
                        ],
                      ),),
                    ),

                    //Listings
                    InkWell(
                      borderRadius:BorderRadius.circular(20),
                      onTap: (){},
                      child: Dashboardoverviewcart(carttitle:"Listings" ,icon:Icons.list_outlined ,iconColor:Color(0xff0277BD) ,widget: Customtitle(title: listingslist.length.toString(),size: 25.sp,),),
                    ),

                    //Sales
                    InkWell(
                      borderRadius:BorderRadius.circular(20),
                      onTap: (){},
                      child: Dashboardoverviewcart(carttitle:"Sales" ,icon:Icons.currency_rupee_sharp ,iconColor:Color(0xffC62828) ,widget: Customtitle(title:"₹2.4L",size: 25.sp,),),
                    ),
                ],
                ),
              ),
            ),

            // Quick Actions title
            Padding(
              padding: const EdgeInsets.fromLTRB(15,10,15,15),
              child: Customtitle(title:"Quick Actions",size: 15.sp,),
            ),

            // Gridview  Quick Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 200.h,
                child: GridView.count(crossAxisCount: 2,
                  crossAxisSpacing:20.sp,
                  mainAxisSpacing: 10.sp,
                  mainAxisExtent: 90.sp,
                  physics: ClampingScrollPhysics(),
                  children: [
                    // Add Produce
                    InkWell(
                      borderRadius:BorderRadius.circular(20),
                      onTap: (){},
                      child:Quickactioncart(icon:Icons.add_box_outlined ,iconcolor: Color(0xff964900),iconsize: 22.sp,label: "Add Produce",),
                    ),

                    //Add Farmer
                    InkWell(
                      borderRadius:BorderRadius.circular(20),
                      onTap: (){},
                      child:Quickactioncart(icon:Icons.people_alt_outlined ,iconcolor: Color(0xff964900),iconsize: 22.sp,label: "Add Farmer",),
                    ),

                    // View Orders
                    InkWell(
                      borderRadius:BorderRadius.circular(20),
                      onTap: (){},
                      child:Quickactioncart(icon:Icons.receipt_long_sharp ,iconcolor: Color(0xff964900),iconsize: 22.sp,label: "View Orders",),
                    ),

                    //Buyer Reqs
                    InkWell(
                      borderRadius:BorderRadius.circular(20),
                      onTap: (){},
                      child:Quickactioncart(icon:Icons.campaign_outlined,iconcolor: Color(0xff964900),iconsize: 22.sp,label: "Buyer Reqs",),
                    ),
                  ],
                ),
              ),
            ),

            // Action Required Text & View All Text Button
            Padding(
              padding: const EdgeInsets.fromLTRB(15,0,15,10),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.start,
                children: [
                  Icon(Icons.error_outline_sharp,color: Color(0xffBA1A19),size: 20.sp,),
                  SizedBox(width: 5.w,),
                  Customtitle(title: "Action Required", size: 15.sp),
                  Spacer(),
                  // View All text Button
                  TextButton(onPressed: (){}, child: Text("View All",style: GoogleFonts.poppins(color:Color(0xff964900),fontSize: 10.sp,fontWeight: FontWeight.w600),))
                ],
              ),
            ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              height: 500,
              width: double.infinity,
              child: ListView.separated(
                  itemBuilder: (context, index){
                    return Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(orderslist[index].orderId.toString(),style: TextStyle(color: Colors.grey,fontSize: 20.sp),)
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount:orderslist.length ),
            ),
          )

          ],
        ),
      )
    );
  }
}