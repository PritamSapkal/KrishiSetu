import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Data/FPO_Dummy_Data/farmer_dummy_data.dart';
import '../../../Widgets/customTitle.dart';
import 'FarmerInfoPage.dart';

class Farmersscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController farmername = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xffF8F9FA),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Search Bar  TextField for searching Farmer name
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
            child: TextField(
              controller: farmername,
              onChanged: (name) {},
              style: TextStyle(color: Colors.black),
              autocorrect: true,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search_sharp, color: Color(0xff585F6C)),
                hintText: "Search Farmers",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0xff964900)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0xff964900)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0xff964900)),
                ),
              ),
            ),
          ),

          // Farmer List
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding:  const EdgeInsets.symmetric(horizontal:20,vertical:5),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Farmerinfopage(index: index,),));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 3,
                                color: Colors.black12
                            )]

                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20.r,
                          backgroundColor: Color(0xff964900).withOpacity(0.15),
                          child: Icon(Icons.person_2_outlined,color: Color(0xff964900),),
                        ),
                        // farmer name
                        title:Customtitle(title:farmerslist[index].fullName ,size: 13.sp,) ,

                        //  farmer crops and teh contribution
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(farmerslist[index].primaryCrops[0]+"."+farmerslist[index].primaryCrops[1],style: GoogleFonts.poppins(color: Color(0xff585F6C)),),
                            Row(
                              children: [
                                Text("Contribution: ",style: GoogleFonts.poppins(color: Color(0xff585F6C)),),
                                Text(farmerslist[index].currentContribution.value.toString()+" "+farmerslist[index].currentContribution.unit,style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: farmerslist.length,
            ),
          ),
        ],
      ),
    );
  }
}
