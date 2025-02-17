import 'dart:io';
import 'package:office_orbit/utils/strings.dart';
import 'package:office_orbit/widgets/ImagePicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../cards/appbar_card.dart';
import '../../cards/text_field_card.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  File? image;
  final picker = ImagePicker();
  DateTime selectedDate = DateTime.now();
  bool showImage = false;
  Color borderColor = Colors.transparent;
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  bool isLoading = false;
  void pickImage(ImageSource imageSource) async {
    XFile? galleryImage = await picker.pickImage(source: imageSource);
    setState(() {
      image = File(galleryImage!.path);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      nameController.text = Constants.managerDetail!.name!;
      dateController.text = Constants.managerDetail!.joinDate!;
      departmentController.text = Constants.managerDepartment!.name!;
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(Constants.managerDetail);
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator:
          const CircularProgressIndicator(color: ColorRefer.kPrimaryColor),
      child: Scaffold(
        backgroundColor: ColorRefer.kBackgroundColor,
        appBar: appBar(
          title: 'Profile',
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
                          child:
                              // image != null
                              //     ? ClipRRect(
                              //         borderRadius: BorderRadius.circular(65),
                              //         child: Image.file(image!, fit: BoxFit.cover),
                              //       )
                              //     :
                              Constants.managerDetail?.image != null &&
                                      Constants.managerDetail?.image!.isEmpty ==
                                          false
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(65),
                                      child: FadeInImage.assetNetwork(
                                        image:
                                            '${StringRefer.imagesPath}${Constants.managerDetail?.image as String}',
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
                  child: Text(Constants.managerDetail!.email!,
                      style: TextStyle(
                          fontSize: 16, color: ColorRefer.kPrimaryColor)),
                ),
                SizedBox(height: 5),
                TextFieldCard(
                  readOnly: false, // Make this one editable
                  title: "Name",
                  controller: nameController,
                  hintText: "Enter your name",
                  suffixIcon: Icon(Icons.person),
                  onChanged: (value) => nameController.text = value,
                ),
                TextFieldCard(
                  readOnly: true, // Make this one non-editable
                  title: "Department",
                  controller: departmentController,
                  hintText: "Department",
                  suffixIcon: Icon(Icons.account_balance_outlined),
                  onChanged: (value) => departmentController.text = value,
                ),
                TextFieldCard(
                  readOnly: true, // Make this one non-editable
                  title: 'Joining Date',
                  controller: dateController,
                  hintText: "Joining Date",
                  suffixIcon: Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showImageDialogBox() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFF737373),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: CameraGalleryBottomSheet(
              cameraClick: () => pickImage(ImageSource.camera),
              galleryClick: () => pickImage(ImageSource.gallery),
            ),
          ),
        );
      },
    );
  }
}
