import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';

import "add_place_screen.dart";

import 'place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Your Great Places"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                },
              )
            ],
          ),
          body: FutureBuilder(
            future:
                Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<Places>(
                    builder: (ctx, placesData, ch) =>
                        placesData.places.length <= 0
                            ? ch
                            : ListView.builder(
                                itemBuilder: (ctx, i) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(placesData.places[i].image),
                                  ),
                                  title: Text(placesData.places[i].title),
                                  subtitle: Text(
                                      placesData.places[i].location.address),
                                  onTap: () {
                                    //place detail page
                                    Navigator.of(context).pushNamed(
                                        PlaceDetailScreen.routeName,
                                        arguments: placesData.places[i].id);
                                  },
                                ),
                                itemCount: placesData.places.length,
                              ),
                    child: Center(
                      child: Text("Got no places yet, start adding some"),
                    ),
                  ),
          )),
    );
  }
}
