import 'package:flutter/material.dart';
import 'package:office_orbit/utils/colors.dart';

class TextFieldCard extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final Icon? suffixIcon;
  final String? hintText;
  final String title;
  final VoidCallback? onTap;
  final bool readOnly;

  const TextFieldCard({
    super.key,
    required this.controller,
    required this.title,
    this.onChanged,
    this.suffixIcon,
    this.hintText,
    this.onTap,
    this.readOnly = false,
  });

  @override
  State<TextFieldCard> createState() => _TextFieldCardState();
}

class _TextFieldCardState extends State<TextFieldCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(height: 3),
          Card(
            color: Colors.white,
            elevation: 3,
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 10,
                  color: ColorRefer.kPrimaryColor,
                ),
                Expanded(
                  child: TextField(
                    readOnly: widget.readOnly,
                    onTap: widget.readOnly ? null : widget.onTap,
                    controller: widget.controller,
                    onChanged: widget.onChanged,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      suffixIcon: widget.suffixIcon,
                      suffixIconColor: ColorRefer.kPrimaryColor,
                      focusColor: ColorRefer.kPrimaryColor,
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(8),
                      // ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
