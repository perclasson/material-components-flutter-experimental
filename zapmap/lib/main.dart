import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

void main() {
  runApp(OldNewYorkApp());
}

String apiKey = 'YOUR_KEY_HERE';

String keyFromPhoto(dynamic p) =>
    '${p['location']['lat']},${p['location']['lon']}';
String keyFromLatLng(LatLng latLng) => '${latLng.latitude},${latLng.longitude}';

double lat = 40.7484;
double lng = -73.9857;
LatLng center = LatLng(lat, lng);
LatLng sw = LatLng(lat - 0.08, lng - 0.15);
LatLng ne = LatLng(lat + 0.08, lng + 0.15);
double minZoom = 15;
double maxZoom = 18;

class OldNewYorkApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/data.json')
            .then((s) {
          Map<String, List<dynamic>> photos = new Map();
          for (var p in jsonDecode(s)['photos']) {
            String key = keyFromPhoto(p);
            photos.putIfAbsent(key, () => []);
            photos[key].add(p);
          }
          return photos;
        }),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data == null
              ? Center(child: Text('Loading...'))
              : OldNewYorkMap(snapshot.data);
        },
      ),
    );
  }
}

class OldNewYorkMap extends StatefulWidget {
  OldNewYorkMap(this.photos);

  final Map<String, List<dynamic>> photos;

  @override
  State createState() => OldNewYorkMapState();
}

class OldNewYorkMapState extends State<OldNewYorkMap> {
  GoogleMapController _mapController;
  PersistentBottomSheetController _sheetController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Old New York'),
        leading: IconButton(
          icon: Icon(Icons.zoom_out_map),
          onPressed: () {
            _mapController?.animateCamera(CameraUpdate.zoomBy(-1));
            _sheetController?.close();
            _sheetController = null;
          },
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: center, zoom: 16),
        cameraTargetBounds:
            CameraTargetBounds(LatLngBounds(southwest: sw, northeast: ne)),
        minMaxZoomPreference: MinMaxZoomPreference(minZoom, maxZoom),
        trackCameraPosition: true,
        myLocationEnabled: true,
        mapType: MapType.hybrid,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    _mapController.onMarkerTapped.add((Marker marker) {
      if (_mapController.cameraPosition.zoom < maxZoom - 1) {
        _mapController.animateCamera(
            CameraUpdate.newLatLngZoom(marker.options.position, maxZoom));
      } else {
        _onIntersectionTapped(marker.options.position);
      }
    });

    _addMarkers();
  }

  void _addMarkers() {
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    print(devicePixelRatio);
    String src = 'assets/sepia_${devicePixelRatio <= 3 ? '64' : '128'}.png';
    widget.photos.forEach((String key, List<dynamic> photos) {
      var p = photos[0];
      _mapController.addMarker(
        MarkerOptions(
          alpha: 0.6,
          position: LatLng(p['location']['lat'], p['location']['lon']),
          icon: BitmapDescriptor.fromAsset(src),
        ),
      );
    });
  }

  void _onIntersectionTapped(LatLng pos) {
    String key = keyFromLatLng(pos);
    List<Image> oldImages = widget.photos[key].map(_oldImage).toList();
    List<Image> streetImages =
        [0, 90, 180, 270].map((heading) => _streetImage(pos, heading)).toList();
    var newCenter = LatLng(pos.latitude - 0.0005, pos.longitude);
    _mapController.animateCamera(CameraUpdate.newLatLng(newCenter));
    _sheetController =
        _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
      return Container(
        height: 400,
        child: Column(
          children: [
            _createImageListView(streetImages),
            _createImageListView(oldImages),
          ],
        ),
      );
    });
  }

  Image _oldImage(dynamic photo) => Image.network(photo['image_url']);

  Image _streetImage(LatLng pos, num heading) =>
      Image.network(_streetViewUrl(pos, heading));

  String _streetViewUrl(LatLng pos, num heading) {
    return 'https://maps.googleapis.com/maps/api/streetview' +
        '?size=400x400' +
        '&location=${keyFromLatLng(pos)}' +
        '&fov=90' +
        '&heading=$heading' +
        '&pitch=10' +
        '&key=$apiKey';
  }

  Widget _createImageListView(List<Image> children) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: children.toList(),
      ),
    );
  }
}
