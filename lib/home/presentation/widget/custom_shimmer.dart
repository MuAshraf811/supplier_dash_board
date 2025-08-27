import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUserCard extends StatelessWidget {
  const ShimmerUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.blue,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 14,
                  width: 100,
                  color: Colors.grey,
                ),
                Container(
                  height: 14,
                  width: 24,
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 12,
              width: 150,
              color: Colors.grey,
            ),
            const SizedBox(height: 8),
            Container(
              height: 12,
              width: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 8),
            Container(
              height: 12,
              width: 120,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
