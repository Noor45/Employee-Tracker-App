import 'package:office_orbit/cards/appbar_card.dart';
import 'package:office_orbit/cards/notification_card.dart';
import 'package:office_orbit/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:office_orbit/manager_portal/screens/main_screen_manager.dart';


  class ManagerNotificationScreen extends StatefulWidget{
  const ManagerNotificationScreen({super.key});

  @override
  State<ManagerNotificationScreen> createState() => _ManagerNotificationScreenState();
}

class _ManagerNotificationScreenState extends State<ManagerNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    bool isLoading=false;
      return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: const CircularProgressIndicator(
       
        color: ColorRefer.kPrimaryColor,
      ),
      child: Scaffold(
        appBar: appBar(
          title: 'Notifications',
           leadingWidget: IconButton(
            onPressed:() {
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back)
            )
          
        ),
        body: SingleChildScrollView(
          child: Column( 
            children: [ 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  
                  onTap: () {
                    
                  },
                  child: NotificationCard(
         
                    title: "Mark Attendance",
                    subtitle:"Please mark your attendance for today. Click here to mark your status." ,
                    trailing:"1:00 PM" ,
                     image:Image.asset("assets/images/check.png",color: ColorRefer.kPrimaryColor,fit: BoxFit.cover) ,
                    
                    )
                ),
              ),
              SizedBox(height: 4),

              InkWell(
                onTap: () {
                  
                },
                child: NotificationCard(
             
                  title:"Break Time Started" , 
                  subtitle:"Your scheduled break time has started. Enjoy your break!" ,
                   trailing:"11:00 AM" ,
                    image: Image.asset("assets/images/food.png",color: ColorRefer.kPrimaryColor,fit: BoxFit.cover) ,
                    )
              ),
                SizedBox(height: 4),
              InkWell(
                onTap: () {
                  
                },
                child: NotificationCard(
                
                  title:"Leave Request Approval",
                   subtitle:"Your leave request has been submitted. Please await approval from your manager." ,
                    trailing:"Yesterday" ,
                     image:Image.asset("assets/images/approved.png",color: ColorRefer.kPrimaryColor,fit: BoxFit.cover) 
                     )
              ),
              //     SizedBox(height: 4),
              // InkWell(
              //   onTap: () {
                  
              //   },
              //   child: NotificationCard(title: title, subtitle: subtitle, trailing: trailing, image: image)
              // ),
              //     SizedBox(height: 4),
              // InkWell(
              //   onTap: () {
                  
              //   },
              //   child: NotificationCard(title: title, subtitle: subtitle, trailing: trailing, image: image)
              // ),
              //      SizedBox(height: 4),
              // InkWell(
              //   onTap: () {
                  
              //   },
              //   child: NotificationCard(title: title, subtitle: subtitle, trailing: trailing, image: image)
              // ),
              //    SizedBox(height: 4),
              // InkWell(
              //   onTap: () {
                  
              //   },
              //   child: NotificationCard(title: title, subtitle: subtitle, trailing: trailing, image: image)
              // ),
              //  SizedBox(height: 4),
              // InkWell(
              //   onTap: () {
                  
              //   },
              //   child: NotificationCard(title: title, subtitle: subtitle, trailing: trailing, image: image)
              // ),
          
            ],
          ),
        ),
        )
        );
    
  }
}