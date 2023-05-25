import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  GoogleMapController? _controller;
  double sliderValue = 1.0;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          _controller?.animateCamera(CameraUpdate.zoomIn());
                        },
                        icon: const Icon(Icons.zoom_in),
                      ),
                      IconButton(
                        onPressed: () {
                          _controller?.animateCamera(CameraUpdate.zoomOut());
                        },
                        icon: const Icon(Icons.zoom_out),
                      ),
                      IconButton(
                        onPressed: () {
                          _controller?.animateCamera(
                            CameraUpdate.scrollBy(-100, 0),
                          );
                        },
                        icon: const Icon(Icons.west),
                      ),
                      IconButton(
                        onPressed: () {
                          _controller?.animateCamera(
                            CameraUpdate.scrollBy(100, 0),
                          );
                        },
                        icon: const Icon(Icons.east),
                      ),
                      IconButton(
                        onPressed: () {
                          _controller?.animateCamera(
                            CameraUpdate.scrollBy(0, -100),
                          );
                        },
                        icon: const Icon(Icons.north),
                      ),
                      IconButton(
                        onPressed: () {
                          _controller?.animateCamera(
                            CameraUpdate.scrollBy(0, 100),
                          );
                        },
                        icon: const Icon(Icons.south),
                      ),
                      IconButton(
                        onPressed: () {
                          _controller?.animateCamera(
                            CameraUpdate.newCameraPosition(_kGooglePlex),
                          );
                        },
                        icon: const Icon(Icons.center_focus_strong),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                color: Colors.white.withOpacity(0.8),
                width: 200,
                height: 40,
                child: Slider(
                  max: 30,
                  min: 1,
                  value: sliderValue,
                  onChanged: (value) {
                    setState(() {
                      sliderValue = value;
                    });
                    _controller?.animateCamera(CameraUpdate.zoomTo(value));
                  },
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

// class MapSample extends StatefulWidget {
//   const MapSample({super.key});

//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      // body: GoogleMap(
      //   mapType: MapType.hybrid,
      //   initialCameraPosition: _kGooglePlex,
      //   onMapCreated: (GoogleMapController controller) {
      //     _controller.complete(controller);
      //   },
      // ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: const Text('To the lake!'),
//         icon: const Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }
