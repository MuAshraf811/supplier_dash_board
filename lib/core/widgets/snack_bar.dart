import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showCustomSnackBar(BuildContext context, String text, Color backgroundColor,
    {int duration = 3}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: duration),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(color: Colors.white, width: 2.h),
      ),
      content: Text(
        text,
        style:const  TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    ),
  );
}
