import 'dart:io';
import 'package:office_orbit/model/manager_team.dart';
import 'package:office_orbit/model/working_hour_model.dart';
import 'package:office_orbit/utils/constants.dart';
import 'package:office_orbit/utils/strings.dart';
import 'package:flutter/material.dart';
import '../../cards/appbar_card.dart';
import '../../cards/text_field_card.dart';
import '../../utils/colors.dart';

class EmployeeDetailScreen extends StatefulWidget {
  const EmployeeDetailScreen({this.detail, super.key});
  final ManagerTeamModel? detail;

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  DateTime selectedDate = DateTime.now();
  bool showImage = false;
  Color borderColor = Colors.transparent;
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      nameController.text = widget.detail!.name!;
      dateController.text = widget.detail!.joinDate!;
      departmentController.text = widget.detail!.name!;
      final output = widget.detail!.workingHours!;
      WorkingHoursModel workingHrs = WorkingHoursModel.fromMap(output);
      timeController.text = '${workingHrs.startTime!} - ${workingHrs.endTime!}';
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('${StringRefer.imagesPath}${Constants.managerDetail?.image}');
    return Scaffold(
      backgroundColor: ColorRefer.kBackgroundColor,
      appBar: appBar(
        title: 'Employee Detail',
        leadingWidget: BackButton(
          color: ColorRefer.kBackgroundColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // showImageDialogBox();
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 125,
                        width: 125,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: borderColor),
                        ),
                        child: widget.detail!.image != null &&
                                widget.detail!.image!.isEmpty == false
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(65),
                                child: FadeInImage.assetNetwork(
                                  image:
                                      '${StringRefer.imagesPath}${widget.detail!.image as String}',
                                  fit: BoxFit.cover,
                                  placeholder: StringRefer.user,
                                ),
                              )
                            : Image.asset('assets/images/user.png'),
                      ),
                      // Positioned(
                      //   left: 90,
                      //   bottom: 10,
                      //   child: SvgPicture.asset(
                      //     'assets/icons/camera.svg',
                      //     width: 30,
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              TextButton(
                onPressed: () {},
                child: Text(widget.detail!.email!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorRefer.kPrimaryColor)),
              ),
              SizedBox(height: 5),
              TextFieldCard(
                readOnly: true, // Make this one editable
                title: "Name",
                controller: nameController,
                hintText: "Enter your name",
                suffixIcon: Icon(Icons.person),
                onChanged: (value) => nameController.text = value,
              ),
              // TextFieldCard(
              //   readOnly: true, // Make this one non-editable
              //   title: "Department",
              //   controller: departmentController,
              //   hintText: "Enter your department",
              //   suffixIcon: Icon(Icons.account_balance_outlined),
              //   onChanged: (value) => departmentController.text = value,
              // ),
              TextFieldCard(
                readOnly: true, // Make this one non-editable
                title: "Timing",
                controller: timeController,
                hintText: "Timing",
                suffixIcon: Icon(Icons.business_center),
                onChanged: (value) => timeController.text = value,
              ),
              TextFieldCard(
                readOnly: true, // Make this one non-editable
                title: "Joining Date",
                controller: dateController,
                hintText: "Select",
                suffixIcon: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
