import 'dart:io';
import 'location_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'great_places.dart';
import 'place.dart';
import 'image_input.dart';
class AddPlaceScreen extends StatefulWidget {
  static const routeName = 'addplacescreen';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage){
_pickedImage=pickedImage;
  }
  void _selectPlace(double latitude,double longitude){
    _pickedLocation=PlaceLocation(latitude: latitude,longitude: longitude);
  }

  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImage==null || _pickedLocation==null){
      return;
    }
    Provider.of<GreatPlaces>(context,listen: false).addPlace(_titleController.text, _pickedImage,_pickedLocation);
    Navigator.of(context).pop();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(height:10),
                    //
                    ImageInput(_selectImage),
                    SizedBox(height: 10,),
                    //
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
