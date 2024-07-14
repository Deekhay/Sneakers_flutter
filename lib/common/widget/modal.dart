import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KModal extends StatelessWidget {
  const KModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(34), topRight: Radius.circular(34))),
      child: Container(
          width: 320.w,
          height: 300.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          )),
    );
  }
}
