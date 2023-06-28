import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthcare/views/services/notif_service.dart';
//import 'package:http/http.dart' as http;
import 'package:healthcare/network/dio_helper.dart';

import 'package:healthcare/views/login/Login.dart';

import 'components/theme.dart';

void main() {
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(const healthcare());
}

class healthcare extends StatefulWidget {
  const healthcare({super.key});

  @override
  State<healthcare> createState() => _healthcareState();
}

class _healthcareState extends State<healthcare> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: (context, child) => MaterialApp(
        title: 'healthcare',
        theme: AppTheme(context).initTheme(),
        debugShowCheckedModeBanner: false,
        home: login(),
      ),
    );
  }
}
