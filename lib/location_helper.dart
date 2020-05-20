import 'package:http/http.dart' as http;
import 'dart:convert';

const MapBox_API_KEY= 'pk.eyJ1Ijoic2F0eWFtcmFqNDA1MiIsImEiOiJja2Fkamhra24xcjZiMzBtdHd0ZDZ6YXhsIn0.Ii8xV6yJPFL34PxGcTsqbA';
class LocationHelper{
  static String generateLocationPriviewImage({double latitude,double longitude}){
    return "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/$longitude,$latitude,13.0,0,0/600x300?access_token=$MapBox_API_KEY";
 //return 'https://api.mapbox.com/styles/v1/satyamraj4052/cjikt35x83t1z2rnxpdmjs7y7/static/85.9015587,20.4479345,13.0,0,60/600x300?access_token=pk.eyJ1Ijoic2F0eWFtcmFqNDA1MiIsImEiOiJja2Fkamhra24xcjZiMzBtdHd0ZDZ6YXhsIn0.Ii8xV6yJPFL34PxGcTsqbA&markers={pin-s}-({$longitude},{$latitude})';
  }
  static Future<String> getplaceAddress({double latitude,double longitude})async{
    final url='https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$MapBox_API_KEY';
    final response=await http.get(url);
    return json.decode(response.body)['features'][0]['place_name'];
    


  } 
}

//https://api.mapbox.com/geocoding/v5/mapbox.places/20,80.json?access_token=pk.eyJ1Ijoic2F0eWFtcmFqNDA1MiIsImEiOiJja2Fkamhra24xcjZiMzBtdHd0ZDZ6YXhsIn0.Ii8xV6yJPFL34PxGcTsqbA

/* String testUrl='https://api.mapbox.com/styles/v1/satyamraj4052/cjikt35x83t1z2rnxpdmjs7y7/static/85.9015587,20.4479345,13.0,0,60/600x300?access_token=pk.eyJ1Ijoic2F0eWFtcmFqNDA1MiIsImEiOiJja2Fkamhra24xcjZiMzBtdHd0ZDZ6YXhsIn0.Ii8xV6yJPFL34PxGcTsqbA';
cjikt35x83t1z2rnxpdmjs7y7 */
/* {pin-s}-({lon},{lat}) */
/* {pin-s}-({$longitude},{$latitude}) */
//&addlayer={"id":"marker",    "id":"road-overlay","type":"line","source":"composite","source-layer":"road","filter":["==",["get","class"],"motorway"],"paint":{"line-color":"%23ff0000","line-width":5}}&before_layer=road-label
//https://api.mapbox.com/styles/v1/satyamraj4052/cjikt35x83t1z2rnxpdmjs7y7/static/85.9015587,20.4479345,13.0,0,60/600x300?access_token=pk.eyJ1Ijoic2F0eWFtcmFqNDA1MiIsImEiOiJja2Fkamhra24xcjZiMzBtdHd0ZDZ6YXhsIn0.Ii8xV6yJPFL34PxGcTsqbA&addlayer={{pin-s}-({$longitude},{$latitude})} 