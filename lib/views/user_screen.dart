import 'package:check/utilities/size_utilities.dart';
import 'package:flutter/material.dart';

import '../utilities/color.dart';
import '../utilities/images.dart';
import '../utilities/string.dart';
import '../widgets/custom_text.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:CustomTextWidget(
         text: strings.personal,
         fontWeight:  FontWeight.w600,
          ) ,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
           20.height,
            _profileCard(),
           30.height,
            _buildMenuItem(Images.setting,strings.konton),
            _buildMenuItem(Images.credit_card, strings.mina),
            _buildMenuItem(Images.support_agent,strings.support),
          ],
        ),
      ),
    );
  }

 Widget _profileCard() {
    return Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColor.bottomBackColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  CircleAvatar(
  radius: 30,
  backgroundColor: AppColor.greyColor,
  child: ClipOval(
    child: Image.asset(
      Images.profile,
      fit: BoxFit.cover,
      height: 60, 
      width: 60,
    ),
  ),
)
,
                  15.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CustomTextWidget(
         text:strings.irfan,
         color:AppColor.whiteColor,
         fontSize: 16,
         fontWeight:  FontWeight.w600,
          ) ,
             CustomTextWidget(
         text: strings.email,
         color:AppColor.whiteMedium,
         fontSize: 14,
         fontWeight:  FontWeight.w600,
          ) ,

              CustomTextWidget(
         text:strings.number,
         color:AppColor.whiteMedium,
         fontSize: 14,
         fontWeight:  FontWeight.w600,
          ) ,
       
                      
                     
                    ],
                  )
                ],
              ),
            );
            }
  Widget _buildMenuItem(String imagePath, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Image.asset(imagePath, width: 24, height: 24, fit: BoxFit.contain),
          15.width,
          CustomTextWidget(text: title,fontSize: 16,),
          
        ],
      ),
    );
  }
}
