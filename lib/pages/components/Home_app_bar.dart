// ignore_for_file: non_constant_identifier_names, file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/SearchPage.dart';
import 'package:weather_app/services/AppBartittleHandler.dart';
import 'package:weather_app/services/city_list_handler.dart';
import '../../core/theme/AppPallate.dart';
import 'appBar_Com/leading.dart';
import 'appBar_Com/title.dart';

AppBar Home_App_Bar(context) {
  final cityOfList = Provider.of<CityList>(context);
  final appBarIndex = Provider.of<AppBarHandler>(context);
  return AppBar(
    elevation: 0.0,
    backgroundColor: AppPallate.transparent,
    centerTitle: true,
    title: appBar_title(cityOfList.listCity[appBarIndex.getIndex]),
    leading: AppBarLeadingComponent(context),
    actions: [
      GestureDetector(
        onTap: () {
          showSearch(context: context, delegate: CustomSearchDelegate());
        },
        child: const Padding(
          padding: EdgeInsets.only(right: 22.0),
          child: Icon(
            Icons.search_sharp,
            color: AppPallate.white,
            size: 30,
          ),
        ),
      ),
    ],
  );
}
