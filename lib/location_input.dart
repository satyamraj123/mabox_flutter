import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'location_helper.dart';
import 'map_screen.dart';
import 'package:latlong/latlong.dart';

class LocationInput extends StatefulWidget {
final Function selectplace;
LocationInput(this.selectplace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  String previewImageUrl;

  void _showPreview(double lat,double lng){

 final staticMapImageUrl = LocationHelper.generateLocationPriviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
   _showPreview(locData.latitude,locData.longitude);
    widget.selectplace(locData.latitude,locData.longitude);
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
              isSelecting: true,
            )));
    if (selectedLocation == null) {
      return;
    }
   _showPreview(selectedLocation.latitude,selectedLocation.longitude);
    widget.selectplace(selectedLocation.latitude,selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 5, color: Colors.grey)),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          child: previewImageUrl == null
              ? Text(
                  'No Location Chosen!!',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  previewImageUrl,
                  fit: BoxFit.contain,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
