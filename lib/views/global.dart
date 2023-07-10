// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Token {
  static double chairlatitude = 39.1290;
  static double chairlongitude = -122.2930;

  static int caregiverid = 0;
  static String server =
      'https://caregiver-fastapi-bf7f5c929f08.herokuapp.com/';
   static  List<int> chairParcodeIds =
        []; // Create an empty list to store the chair_parcode_id values
  static int counter = 0;
  static int selectedwheelchair = -1;
  static var token = "";
  static var globalusername = 'zahraa';
  static var globalage = "15";
  static var globalgender = 'female';
  static var heartreading = 0.0;
  static var tempreading = 0.0;
  static var oxygenreading = 0.0;
  static var bloodreading = '0.0';
  static var text = Colors.grey[600];
  static var country = 'Egypt';
  static var selectedchairid;
  static var phone = '01222222222';
  static var username = '';
  static int ageuser = 0;
  static bool emergencyStateheart = false;
  static bool emergencyStateoxy = false;
  static bool emergencyStatetemp = false;
  static String first_nameuser = '';
  static String last_nameuser = '';
  static String emailuser = '';
  static var countryuser = '';
  static String phoneuser = '';
  static String bdateuser = 'g';
  static Position? position;

  static var photofile = 'Upload Picture';
  static var password = 'ggggggg';
  static DateTime birthdate = DateTime(2023, 4, 5);
  static String deviceToken = '';
  static String fcmKey = '';
  static String googleApiKey = 'AIzaSyAP4C-a8BDQFXENf2MokLJHkvf3sTBmnfk';
  static String devicetokeennn =
      'csYSIjP5TQa9j37kwlPf7r:APA91bE5-kQz17VtJ2DFB8aFSEB-Hc1nq2uguUXggFkgI3-LA7ebt5TIZLa06NtU_wlsaXosa5dVVbbcP8aEop87ee9wVxD_UvPO3PQfu0I6WGFqf10daJbNqJ-bjHk_N79C4B-uZ8IJ';
  static String servertoken =
      'AAAAXUQrMc0:APA91bE_xkl6TVyTbAQ9gZlFXlzXl8up3a9j0zLof9fWznPOv0ni8oWmwkP_HZM7QMRwQPRevtJAQADSGp91Zc_3dIClagkFaK98GuSGKITgfSObqcA-cYnnTm0PkAK4ciEF_ZhjQYqw';
  static File? image;
  static String urlprofile =
      "https://firebasestorage.googleapis.com/v0/b/kickfunding-a2c6e.appspot.com/o/zahraa.jpg?alt=media&token=1e786cec-f5f8-4611-ba5f-9b36838788fd";
  static String? urlprofileimage =
      "https://firebasestorage.googleapis.com/v0/b/kickfunding-a2c6e.appspot.com/o/zahraa.jpg?alt=media&token=1e786cec-f5f8-4611-ba5f-9b36838788fd";
}
