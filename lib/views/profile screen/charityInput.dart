// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare/constants.dart';

class CharityInputField extends StatelessWidget {
  const CharityInputField(
    this.title, {
    super.key,
    this.assetName,
    this.focusnode,
    this.onTap,
    this.hintText,
    required this.onchanged,
    this.controller,
    required this.validateStatus,
    this.keyboardtype,
  });

  final String title;
  final String? assetName;
  final FocusNode? focusnode;
  final TextInputType? keyboardtype;
  final void Function()? onTap;
  final String? hintText;
  final ValueChanged<String> onchanged;
  final controller;
  final FormFieldValidator validateStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(),
        ),
        SizedBox(
          height: 2.h,
        ),
        Stack(
          children: [
            TextFormField(
              style: const TextStyle(color: Colors.grey),
              focusNode: focusnode,
              keyboardType: keyboardtype,
              controller: controller,
              onChanged: onchanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    8.r,
                  ),
                  borderSide: BorderSide.none,
                ),
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.grey,
                    ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
              ),
            ),
            if (assetName != null)
              Positioned(
                top: 0,
                bottom: 0,
                right: 8.w,
                child: Center(
                  child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8.r,
                        ),
                        color: kPrimary2,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          assetName!,
                          width: 16.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        )
      ],
    );
  }
}
