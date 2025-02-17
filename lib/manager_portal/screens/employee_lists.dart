import 'dart:convert';

import 'package:office_orbit/manager_portal/screens/employee_Detail.dart';
import 'package:office_orbit/manager_portal/screens/team_attendance.dart';
import 'package:office_orbit/model/working_hour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../cards/appbar_card.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/strings.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorRefer.kBackgroundColor,
      appBar: appBar(
        title: 'Employees',
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: Constants.teamList!.length,
          itemBuilder: (BuildContext context, int index) {
            WorkingHoursModel? workingHrs;
            if (Constants.teamList![index].workingHours! != '') {
              final output = Constants.teamList![index].workingHours!;
              workingHrs = WorkingHoursModel.fromMap(output);
            }
            return Container(
              child: EmployeeCard(
                image: Constants.teamList![index].image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: FadeInImage.assetNetwork(
                          image:
                              '${StringRefer.imagesPath}${Constants.teamList![index].image}',
                          fit: BoxFit.cover,
                          placeholder: StringRefer.user,
                          height: 60,
                          width: 60,
                        ))
                    : SvgPicture.asset(
                        'assets/icons/person.svg',
                        height: 60,
                        width: 60,
                      ),
                status: workingHrs != null ? workingHrs.type! : '',
                name: Constants.teamList![index].name!,
                email: Constants.teamList![index].email!,
                attendanceCall: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeamAttendanceScreen(
                              employeeId:
                                  Constants.teamList![index].id.toString(),
                            )),
                  );
                },
                detailCall: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmployeeDetailScreen(
                            detail: Constants.teamList![index])),
                  );
                },
                reportCall: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final Widget? image;
  final String? name;
  final String? email;
  final String? status;
  final Function? attendanceCall;
  final Function? reportCall;
  final Function? detailCall;

  EmployeeCard(
      {this.image,
      this.name,
      this.email,
      this.status,
      this.attendanceCall,
      this.detailCall,
      this.reportCall});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          // height: 100,
          // margin: const EdgeInsets.symmetric(horizontal: 6.0),
          padding: const EdgeInsets.all(10),
          // margin:  const EdgeInsets.only(right: 10, left: 10, bottom: 10),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 15),
                child: image, // Replace with your image widget
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        name!
                            .capitalizeFirstLetter(), // Replace with your name variable
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      // SizedBox(height: 5),
                      // Text(
                      //  email!,
                      //   style: TextStyle(color: Colors.grey),
                      //   // Replace with your email variable
                      // ),
                      SizedBox(height: 5),
                      Text(
                        status != ''
                            ? '${status!.capitalizeFirstLetter()} Time'
                            : 'Working hrs not assign',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                        // style: TextStyle(color: status == 'full' ? Colors.green : Colors.red),
                        // Replace with your email variable
                      ),
                      SizedBox(height: 5),
                      status != ''
                          ? Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    attendanceCall!.call();
                                  },
                                  child: Text(
                                    'Attendance',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  height: 15.0,
                                  width: 1.0,
                                  color: Colors.grey,
                                ),
                                InkWell(
                                  onTap: () {
                                    detailCall!.call();
                                  },
                                  child: Text(
                                    'Detail',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.symmetric(horizontal: 8.0),
                                //   height: 15.0,
                                //   width: 1.0,
                                //   color: Colors.grey,
                                // ),
                                // InkWell(
                                //   onTap: () {
                                //     reportCall!.call();
                                //   },
                                //   child: Text(
                                //     'Report',
                                //     style: TextStyle(
                                //       color: Colors.green,
                                //       fontSize: 12.0,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // ),
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     // Add button functionality here
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blue, // Replace with ColorRefer.kPrimaryColor if defined
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(18.0),
              //     ),
              //   ),
              //   child: Text('View', style: TextStyle(color: Colors.white)),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
