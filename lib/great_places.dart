import 'dart:io';
import 'package:flutter/foundation.dart';
import 'place.dart';
import 'db_helper.dart';
import 'location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }
Place findById(String id){
 return _items.firstWhere((place) => place.id==id);
}


  Future<void> addPlace(
      String title, File image, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getplaceAddress(
        latitude: pickedLocation.latitude, longitude: pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toIso8601String(),
        image: image,
        title: title,
        location: updatedLocation);
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address' : newPlace.location.address
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DbHelper.getData('places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              location: PlaceLocation(latitude: item['loc_lat'],longitude: item['loc_lng'],address: item['address']),
              image: File(item['image']),
            ))
        .toList();
    notifyListeners();
  }
}
