import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/views/profile screen/editprofile.dart';
import '../../constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 80.w,
          width: 80.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              8.r,
            ),
            color: ktextcolor1,
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/images/image_placeholder.svg',
              width: 32.w,
            ),
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
                'Zahraa Ashraf',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold, color: kPrimaryColor),
              ),
              Text(
                'EG +0201222318030',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: ktextcolor2,
                    ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            try {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const editProfile(),
                ),
              );
            } catch (e) {
              print(e.toString());
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
