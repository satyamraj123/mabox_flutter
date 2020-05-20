import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'map_screen.dart';
import 'great_places.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName='placedetailscreen';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 250,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            child: Text('View On Map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                        initialLocation: selectedPlace.location,
                        isSelecting: false,
                      )));
            },
          )
        ],
      ),
    );
  }
}
