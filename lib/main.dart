import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import 'providers/places.dart';
import "screens/add_place_screen.dart";
import 'screens/place_detail_screen.dart';
import "screens/places_list_screen.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        title: "Flutter Native Demo",
        theme:
            ThemeData(accentColor: Colors.amber, primarySwatch: Colors.indigo),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen()
        },
      ),
    );
  }
}
