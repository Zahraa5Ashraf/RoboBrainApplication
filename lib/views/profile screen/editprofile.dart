// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare/constants.dart';
import '/views/global.dart';
import 'country.dart';
import 'charityInput.dart';
import '/views/birthdate.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  //   File? _profilePicture;

  // Future<void> pickercamera() async {
  //   final XFile? file = await ImagePicker()
  //       .pickImage(source: ImageSource.gallery, imageQuality: 20);
  //   if (file != null) {
  //     setState(() {
  //       _profilePicture = File(file.path);
  //       Token.image = _profilePicture;
  //       Token.photofile = _profilePicture!.path;
  //     });
  //   }
  // }

  void _updateSelectedCountry(String value) {
    setState(() {
      Token.country = value;
      Token.countryuser = value;
    });
  }

  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController phone;

  var birthdate;
  var country;
  var obsecurepassword = true;
  var obsecurepassword2 = true;
  Color iconcolor = Colors.grey;
  Color iconcolor2 = Colors.grey;
  var password1;
  var password2;
  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with existing data
    firstname = TextEditingController(text: Token.first_nameuser);
    lastname = TextEditingController(text: Token.last_nameuser);
    phone = TextEditingController(text: Token.phoneuser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          title: const Text(
            'edit profile',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/animatedbackground.gif'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  width: 120.w,
                  height: 120.w,
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 120.w,
                          width: 120.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              8.r,
                            ),
                            color: kPrimaryLightColor,
                          ),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                                image: DecorationImage(
                                    image: NetworkImage(Token.urlprofile),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: -12.w,
                          bottom: -12.w,
                          child: GestureDetector(
                            onTap: () {
                              //    _pickImage();
                            },
                            child: SvgPicture.asset(
                              'assets/images/edit.svg',
                              width: 32.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: CharityInputField(
                        'First Name',
                        onchanged: (String value) {
                          setState(() {
                            Token.first_nameuser = value;
                          });
                        },
                        validateStatus: (value) {
                          return value;
                        },
                        controller: firstname,
                        hintText: 'first name',
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: CharityInputField(
                        'Last Name',
                        onchanged: (String value) {
                          setState(() {
                            Token.last_nameuser = value;
                          });
                        },
                        validateStatus: (value) {
                          return value;
                        },
                        controller: lastname,
                        hintText: 'last name',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // CharityInputField(
                //   'Email',
                //   onchanged: (String value) {},
                //   validateStatus: (value) {},
                //   controller: email,
                // ),
                // SizedBox(height: 16.h),
                CharityInputField(
                  'Phone Number',
                  onchanged: (String value) {
                    setState(() {
                      Token.phoneuser = value;
                    });
                  },
                  validateStatus: (value) {
                    return value;
                  },
                  controller: phone,
                  hintText: 'phone',
                ),
                SizedBox(height: 26.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Country',
                      style: TextStyle(),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CountryInputField(
                      validateStatus: (value) {
                        return value;
                      },
                      
                      onChanged: _updateSelectedCountry,
                      onSaved: _updateSelectedCountry,
                      color: kPlaceholder2,
                      height: 20,
                    ),
                  ],
                ),

                SizedBox(height: 26.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Birthdate',
                      style: TextStyle(),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    BirthdateInputField(
                      validateStatus: (value) {
                        return value;
                      },
                      onChanged: (String value) {
                        setState(() {
                          birthdate = value;
                          Token.bdateuser = value;
                        });
                      },
                      title: 'birth',
                      hintText: Token.bdateuser,
                      onSaved: (String value) {
                        setState(() {
                          birthdate = value;
                          Token.bdateuser = value;
                        });
                      },
                      height: 20,
                      color: kPlaceholder2,
                    ),
                  ],
                ),
                SizedBox(height: 26.h),
                Column(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          kPlaceholder2,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8.r,
                            ),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(
                          Size(
                            double.infinity,
                            60.h,
                          ),
                        ),
                      ),
                      onPressed: () {
                        // updatePassword(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Update Password',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: ktextcolor2,
                                fontSize: 13),
                          ),
                          Icon(
                            Icons.lock,
                            color: ktextcolor2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        kPrimaryColor,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20.r,
                          ),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size(
                          double.infinity,
                          56.h,
                        ),
                      ),
                    ),
                    onPressed: () {
                      //  _submitForm();
                      //   saveprofile();
                    },
                    child: Text(
                      'Save Change',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          ),
        ));
  }
}
