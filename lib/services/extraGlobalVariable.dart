import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/city_list_handler.dart';
import 'package:weather_app/services/weather_api_handler.dart';

class extraVariable extends ChangeNotifier {
  static final timeZones = [
    {
      'offset': -12,
      'duration': const Duration(hours: -12),
      'zones': ['Etc/GMT+12']
    },
    {
      'offset': -11,
      'duration': const Duration(hours: -11),
      'zones': ['Etc/GMT+11', 'Pacific/Pago_Pago']
    },
    {
      'offset': -10,
      'duration': const Duration(hours: -10),
      'zones': ['America/Adak', 'Hawaii']
    },
    {
      'offset': -9,
      'duration': const Duration(hours: -9),
      'zones': ['America/Anchorage', 'America/Yakutat']
    },
    {
      'offset': -8,
      'duration': const Duration(hours: -8),
      'zones': ['America/Los_Angeles', 'Etc/GMT+8']
    },
    {
      'offset': -7,
      'duration': const Duration(hours: -7),
      'zones': ['America/Denver', 'America/Yellowknife']
    },
    {
      'offset': -6,
      'duration': const Duration(hours: -6),
      'zones': ['America/Chicago', 'America/Mexico_City']
    },
    {
      'offset': -5,
      'duration': const Duration(hours: -5),
      'zones': ['America/New_York', 'America/Panama']
    },
    {
      'offset': -4,
      'duration': const Duration(hours: -4),
      'zones': ['America/Halifax', 'America/Puerto_Rico']
    },
    {
      'offset': -3,
      'duration': const Duration(hours: -3),
      'zones': ['America/Sao_Paulo', 'America/Argentina/Buenos_Aires']
    },
    {
      'offset': -2,
      'duration': const Duration(hours: -2),
      'zones': ['America/Noronha', 'Atlantic/South_Georgia']
    },
    {
      'offset': -1,
      'duration': const Duration(hours: -1),
      'zones': ['America/Scoresbysund', 'Atlantic/Azores']
    },
    {
      'offset': 0,
      'duration': const Duration(hours: 0),
      'zones': ['Africa/Abidjan', 'Europe/London', 'UTC']
    },
    {
      'offset': 1,
      'duration': const Duration(hours: 1),
      'zones': ['Europe/Amsterdam', 'Europe/Berlin', 'Europe/Paris']
    },
    {
      'offset': 2,
      'duration': const Duration(hours: 2),
      'zones': ['Africa/Cairo', 'Europe/Athens', 'Europe/Kiev']
    },
    {
      'offset': 3,
      'duration': const Duration(hours: 3),
      'zones': ['Africa/Nairobi', 'Asia/Baghdad', 'Europe/Moscow']
    },
    {
      'offset': 4,
      'duration': const Duration(hours: 4),
      'zones': ['Asia/Dubai', 'Asia/Yerevan', 'Europe/Samara']
    },
    {
      'offset': 4.5,
      'duration': const Duration(hours: 4, minutes: 30),
      'zones': ['Asia/Kabul']
    },
    {
      'offset': 5,
      'duration': const Duration(hours: 5),
      'zones': ['Asia/Karachi', 'Asia/Yekaterinburg']
    },
    {
      'offset': 5.5,
      'duration': const Duration(hours: 5, minutes: 30),
      'zones': ['Asia/Colombo', 'Asia/Kolkata']
    },
    {
      'offset': 6,
      'duration': const Duration(hours: 6),
      'zones': ['Asia/Almaty', 'Asia/Dhaka']
    },
    {
      'offset': 7,
      'duration': const Duration(hours: 7),
      'zones': ['Asia/Bangkok', 'Asia/Jakarta']
    },
    {
      'offset': 8,
      'duration': const Duration(hours: 8),
      'zones': ['Asia/Hong_Kong', 'Asia/Shanghai', 'Asia/Singapore']
    },
    {
      'offset': 9,
      'duration': const Duration(hours: 9),
      'zones': ['Asia/Tokyo', 'Asia/Yakutsk']
    },
    {
      'offset': 10,
      'duration': const Duration(hours: 10),
      'zones': ['Australia/Brisbane', 'Australia/Sydney']
    },
    {
      'offset': 11,
      'duration': const Duration(hours: 11),
      'zones': ['Asia/Magadan', 'Pacific/Bougainville']
    },
    {
      'offset': 12,
      'duration': const Duration(hours: 12),
      'zones': ['Etc/GMT-12']
    },
    {
      'offset': 13,
      'duration': const Duration(hours: 13),
      'zones': ['Pacific/Auckland']
    },
    {
      'offset': 14,
      'duration': const Duration(hours: 14),
      'zones': ['Pacific/Kiritimati']
    }
  ];
  dynamic currentOffset = 5.5;
  Duration duration = const Duration(hours: 5, minutes: 30);
  Future<void> updateDuration(dynamic offset, BuildContext context) async {
    final temp = timeZones.firstWhere((tz) => tz['offset'] == offset);
    duration = temp['duration'] as Duration;
    currentOffset = offset;
    await updateCityReport(context);
    notifyListeners();
  }
}
