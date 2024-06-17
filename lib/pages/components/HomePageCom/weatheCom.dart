import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/AppPallate.dart';

Column WeatherComp(String path, String type, String text) {
  return Column(
    children: [
      SvgPicture.asset(
        path,
        height: 25,
        width: 25,
      ),
      Text(
        type,
        style: const TextStyle(
            color: AppPallate.white, fontSize: 13, fontWeight: FontWeight.w600),
      ),
      Text(
        text,
        style: const TextStyle(
            color: AppPallate.white, fontSize: 13, fontWeight: FontWeight.w400),
      )
    ],
  );
}
