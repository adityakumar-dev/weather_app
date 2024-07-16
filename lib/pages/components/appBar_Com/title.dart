import 'package:flutter/material.dart';

RichText appBar_title(dynamic data) {
  return RichText(
    text: TextSpan(
      text: data['place'] == null ? 'Loading City..' : data['place'] + ', ',
      style: const TextStyle(
          color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 20),
      children: [
        TextSpan(
            text: data['place'] == null ? 'Loading City..' : data['placeCon'],
            style: const TextStyle(color: Colors.white38, fontSize: 15))
      ],
    ),
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
  );
}
