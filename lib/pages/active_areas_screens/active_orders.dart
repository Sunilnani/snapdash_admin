import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapdash_admin/base_home_page.dart';
import 'package:snapdash_admin/common/custom_circular_progress_indicator.dart';
import 'package:snapdash_admin/common/location_service.dart';
class ActiveAreas extends StatefulWidget {
  const ActiveAreas({Key? key}) : super(key: key);

  @override
  State<ActiveAreas> createState() => _ActiveAreasState();
}

class _ActiveAreasState extends State<ActiveAreas> {
  GoogleMapController? mapController;
  late BitmapDescriptor pinLocationIcon;
  Marker? centerMapMarker;
  LatLng _center = const LatLng(45.521563, -122.677433);
  List<Marker> markersList = [];

  Future<void> setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5,),
        'assets/images/rider_pin.png');
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    fetchLocation();
  }

  double longtitude1=0.0;

  Future<void> fetchLocation() async {
    final locationData = await locationService.getLocation();
    if (locationData != null) {
      _center = LatLng(locationData.latitude!, locationData.longitude!);

      await mapController?.moveCamera(CameraUpdate.newLatLng(_center));
      print("hbdhegvhcegvceg ----------${_center.latitude}");

      longtitude1=_center.longitude;
      print(longtitude1);


      setState(() {
        centerMapMarker = Marker(
          icon: pinLocationIcon,
          markerId: const MarkerId("center"),
          position: _center,
        );

      });
    } else {
      setState(() {
        _center = const LatLng(-1.286389, 36.817223);
        centerMapMarker = Marker(
          icon: pinLocationIcon,
          markerId: const MarkerId("center"),
          position: _center,
        );
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMapPin();
    fetchLocation();
  }


  @override
  Widget build(BuildContext context) {
    return BaseHomePage(
      activeIndex: 5,
        child: Container(
          child: Column(
            children: [
              if (centerMapMarker == null)
                const Center(
                  child: CustomCircularProgressIndicator(),
                )
              else
                Container(
                  height:MediaQuery.of(context).size.height*0.4,
                  child: GoogleMap(
                    zoomControlsEnabled: false,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(-1.286389, 36.817223),
                      zoom: 15,
                    ),
                    onCameraMoveStarted: () {
                      print("started");
                    },
                    myLocationEnabled: true,
                    onCameraIdle: () {
                      print("idle");

                    },
                    onCameraMove: (position) {
                      setState(() {
                        _center = position.target;
                        centerMapMarker = centerMapMarker!.copyWith(
                          positionParam: position.target,
                        );
                      });
                    },
                    markers: {centerMapMarker!, ...markersList},
                  ),
                ),


              SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
