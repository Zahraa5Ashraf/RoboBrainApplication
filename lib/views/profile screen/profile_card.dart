import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../global.dart';
import '../services/routes.dart';
import '../../constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 80.w,
          width: 80.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: kPrimary2,
          ),
          child: Image.network(
            'https://raw.githubusercontent.com/Zahraa5Ashraf/flutter/main/new%20logo%20finalllllllyyyy.jpg', // Replace with your image URL
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${Token.first_nameuser} ${Token.last_nameuser}',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold, color: kPrimaryColor),
              ),
              Text(
                'age: ${Token.ageuser}',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ktextcolor2,
                    ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            try {
              Navigator.of(context).pushNamed(RouteGenerator.edit);
            } catch (e) {
              //print(e.toString());
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.w,
              horizontal: 8.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                4.r,
              ),
              color: kPlaceholder2,
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
              color: ktextcolor1,
            ),
          ),
        )
      ],
    );
  }
}
