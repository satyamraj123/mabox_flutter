import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'place.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: 20, longitude: 80),
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  

  static double latitude = 20;
  static double longitude = 80;
 static LatLng _pickedLocation=LatLng(latitude,longitude);

  


  Future<void> _getlocation() async {
    try{
final locData = await Location().getLocation();
 setState(() {
      if(locData!=null){
      latitude = locData.latitude;
      longitude = locData.longitude;
      _pickedLocation = LatLng(latitude,longitude);
      }});
    }catch(e){
      return;
      //errror handling

    }
    
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        
        actions: widget.isSelecting?<Widget>[
          widget.isSelecting?
          FlatButton.icon(
            icon: Icon(
              Icons.gps_fixed,
              color: Colors.amber,
            ),
            label: Text(
              'Your Location',
              style: TextStyle(color: Colors.amber),
            ),
            onPressed: _getlocation,
          ):null
        ]:null,
      ),
      floatingActionButton:widget.isSelecting? FloatingActionButton(
            child: Icon(Icons.check),
            /* iconSize: 50,color: Colors.amber,icon:Icon(Icons.check_circle), */ 
            onPressed:
                () {
                  Navigator.of(context).pop(_pickedLocation);
                },
      ):null,
      body: FlutterMap(
        options: MapOptions(
          onTap: widget.isSelecting ? _selectLocation : null,
          center: LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude),
          zoom: 2.0,
        ),
        layers: [
          new TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2F0eWFtcmFqNDA1MiIsImEiOiJja2Fkamhra24xcjZiMzBtdHd0ZDZ6YXhsIn0.Ii8xV6yJPFL34PxGcTsqbA",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1Ijoic2F0eWFtcmFqNDA1MiIsImEiOiJja2Fkamhra24xcjZiMzBtdHd0ZDZ6YXhsIn0.Ii8xV6yJPFL34PxGcTsqbA',
              'id': 'mapbox.streets',
            },
          ),
          new MarkerLayerOptions(
            markers: [
              /* new Marker(
            
              width: 80.0,
              height: 80.0,
              point: new LatLng(latitude,longitude),
              builder: (ctx) =>
              new Container(
                child: new FlutterLogo(colors: Colors.blue,),
              ),
          
            ), */

              Marker(
                width: 50.0,
                height: 50.0,
                point: !widget.isSelecting?
                     LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude)
                    : LatLng(_pickedLocation.latitude, _pickedLocation.longitude),
                builder: (ctx) => new Container(
                  child: new FlutterLogo(
                    colors: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
        /* initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ), */
      ),
    );
  }
}
