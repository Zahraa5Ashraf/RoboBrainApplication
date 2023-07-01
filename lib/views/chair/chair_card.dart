import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare/views/chair/chair.dart';

import '../../../../models/chairs.dart';
import '../../constants.dart';

class chairCard extends StatelessWidget {
  final chair info;
  final Function edit;
  final Function delete;
  const chairCard({
    Key? key,
    required this.info,
    required this.edit,
    required this.delete, required CardItem item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context)
        //     .pushNamed(RouteGenerator.details, arguments: info);
      },
      child: Container(
        height: 310.h,
        width: 240.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            12.r,
          ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 5),
              color: Color.fromARGB(255, 233, 233, 233),
              blurRadius: 5,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 8.h,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 180.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                    color: const Color.fromARGB(255, 233, 233, 233),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/image_placeholder.svg',
                      width: 80.w,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: SvgPicture.asset(
                    'assets/images/bookmark.svg',
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              info.id,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              IconButton(
                splashColor: kPrimaryLightColor,
                onPressed: delete as VoidCallback,
                icon: const Icon(
                  Icons.remove_rounded,
                  size: 35,
                  color: kPrimaryColor,
                ),
              ),
              IconButton(
                splashColor: kPrimary2,
                onPressed: edit as VoidCallback,
                icon: const Icon(
                  Icons.edit,
                  size: 25,
                  color: kPrimaryColor,
                ),
              ),
            ]

                /**percentage slider */
                // Container(
                //   width: (240.w - 20.w) * double.parse(info.percent) / 100,
                //   height: 4.h,
                //   decoration: ShapeDecoration(
                //     shape: const StadiumBorder(),
                //     color: AppColor.kBlue,
                //   ),
                // ),
                // Spacer(),
                // Container(
                //   width: (240.w - 20.w) *
                //       (100 - double.parse(info.percent)) /
                //       100,
                //   height: 4.h,
                //   decoration: ShapeDecoration(
                //     shape: const StadiumBorder(),
                //     color: AppColor.kPlaceholder1,
                //   ),
                // )

                ),
            SizedBox(
              height: 8.h,
            ),
          ],
        ),
      ),
    );
  }
}
