import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../consts.dart';

class LocationInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  Completer<GoogleMapController> _controller = Completer();
  final _markerId = MarkerId('marker');
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  Map<String, dynamic> _coordinates = {'lat': 49.9974806 , 'lng': 36.2366602};
  final FocusNode _addressInputFocusNode = FocusNode();
  final TextEditingController _addressInputController = TextEditingController();

  @override
  void initState() {
    _markers[_markerId] = Marker(
      markerId: MarkerId('marker'),
      position: LatLng(_coordinates['lat'], _coordinates['lng']),
      icon: BitmapDescriptor.defaultMarker,
    );
    _addressInputFocusNode.addListener(_updateLocation);
    super.initState();
  }

  @override
  void dispose() {
    _addressInputFocusNode.removeListener(_updateLocation);
    super.dispose();
  }

  void updateMap(String address) async {
    if (address.isNotEmpty) {
      final Uri uri = Uri.https(
        'maps.googleapis.com',
        '/maps/api/geocode/json',
        {'address': address, 'key': mapsApiKey},
      );
      final http.Response response = await http.get(uri);
      final decodedResponse = json.decode(response.body);
      final formattedAddress = decodedResponse['results'][0]['formatted_address'];
      await _goToNewLocation(decodedResponse['results'][0]['geometry']['location']);
      setState(() {
        _addressInputController.text = formattedAddress;
        _coordinates = decodedResponse['results'][0]['geometry']['location'];
        _markers[_markerId] = Marker(
          markerId: MarkerId('marker'),
          position: LatLng(decodedResponse['results'][0]['geometry']['location']['lat'], decodedResponse['results'][0]['geometry']['location']['lng']),
          icon: BitmapDescriptor.defaultMarker,
        );
      });
    }
  }

  GoogleMap getMap() {
    return GoogleMap(
      markers: Set<Marker>.of(_markers.values),
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(_coordinates['lat'], _coordinates['lng']),
        zoom: 14.4746,
      ),
      onTap: (_) {},
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Future<void> _goToNewLocation(coordinates) async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(
      CameraUpdate.newLatLng(LatLng(coordinates['lat'], coordinates['lng'])),
    );
  }

  void _updateLocation() {
    if (!_addressInputFocusNode.hasFocus) {
      updateMap(_addressInputController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          focusNode: _addressInputFocusNode,
          controller: _addressInputController,
          decoration: InputDecoration(labelText: 'Address'),
        ),
        SizedBox(
          height: 10.0,
        ),
        SizedBox(
          width: double.infinity,
          height: 200.0,
          child: getMap(),
        ),
      ],
    );
  }
}
