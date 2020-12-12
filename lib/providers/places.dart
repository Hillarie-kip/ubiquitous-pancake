import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

import '../models/place.dart';

import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class Places with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: image,
        title: title,
        location: updatedLocation);
    _places.add(newPlace);
    notifyListeners();
    //store to sqlite
    DBHelper.insert("user_places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "loc_lat": newPlace.location.latitude,
      "loc_lng": newPlace.location.longitude,
      "address": newPlace.location.address
    });
  }

  Place findById(String id) {
    return _places.firstWhere((place) => place.id == id);
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData("user_places");
    _places = dataList
        .map((item) => Place(
            id: item["id"],
            title: item["title"],
            image: File(item["image"]), //path
            location: PlaceLocation(
                latitude: item["loc_lat"],
                longitude: item["loc_lng"],
                address: item["address"])))
        .toList();
    notifyListeners();
  }
}
