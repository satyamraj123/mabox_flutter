import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_place_screen.dart';
import 'place_detail_screen.dart';
import 'places_list_screen.dart';
import 'great_places.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
value: GreatPlaces(),
          child: MaterialApp(
        title:'touring',
        theme: ThemeData(
          primarySwatch:Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes:{
          PlaceDetailScreen.routeName:(ctx)=>PlaceDetailScreen(),
          AddPlaceScreen.routeName:(ctx)=>AddPlaceScreen(),
          
        }
      ),
    );
  }
}

