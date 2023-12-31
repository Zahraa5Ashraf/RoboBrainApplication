import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'global.dart';

class BirthdateInputField extends StatefulWidget {
  const BirthdateInputField({
    Key? key,
    required this.title,
    this.assetName,
    this.onTap,
    this.hintText,
    required this.onChanged,
    this.controller,
    required this.validateStatus,
    required this.onSaved,
    required this.height,
    required this.color,
  }) : super(key: key);

  final int height;
  final Color color;
  final String title;
  final String? assetName;
  final void Function()? onTap;
  final String? hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validateStatus;
  final ValueChanged<String> onSaved;

  @override
  // ignore: library_private_types_in_public_api
  _BirthdateInputFieldState createState() => _BirthdateInputFieldState();
}

class _BirthdateInputFieldState extends State<BirthdateInputField> {
  DateTime _selectedDate = Token.birthdate;
  TextEditingController? _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = widget.controller ?? TextEditingController();
  }

  // @override
  // void dispose() {
  //   _dateController?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //  height: 100.h,
      // padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                widget.onChanged(value);
                widget.onSaved(value);
              },
              style: const TextStyle(
                color: Colors.grey,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: widget.color,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
                hintText: widget.hintText ?? '',
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: widget.height.h,
                ),
              ),
              readOnly: true,
              onTap: _openDatePicker,
              controller: _dateController,
              validator: widget.validateStatus,
            ),
          ),
        ],
      ),
    );
  }

  void _openDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        Token.birthdate = picked;
        _dateController?.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
        widget.onSaved(_dateController?.text ?? '');
      });
    }
  }
}
