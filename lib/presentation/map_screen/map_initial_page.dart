import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/app_export.dart';

class MapInitialPage extends StatefulWidget {
  const MapInitialPage({Key? key})
      : super(
          key: key,
        );

  @override
  MapInitialPageState createState() => MapInitialPageState();
}

// ignore_for_file: must_be_immutable
class MapInitialPageState extends State<MapInitialPage> {
  Completer<GoogleMapController> googleMapController = Completer();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(
          left: 8.h,
          top: 12.h,
          right: 8.h,
        ),
        child: Column(
          children: [
            CustomImageView(
              imagePath: ImageConstant.img5935976241859510486,
              height: 56.h,
              width: 116.h,
              alignment: Alignment.centerRight,
            ),
            SizedBox(height: 12.h),
            Container(
              height: 656.h,
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 22.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildMapMakerSaudi(context),
                  CustomImageView(
                    imagePath: ImageConstant.imgIconOnprimarycontainer,
                    height: 36.h,
                    width: 38.h,
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(
                      right: 14.h,
                      bottom: 20.h,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 24.h)
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMapMakerSaudi(BuildContext context) {
    return SizedBox(
      height: 656.h,
      width: 330.h,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            37.43296265331129,
            -122.08832357078792,
          ),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          googleMapController.complete(controller);
        },
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
      ),
    );
  }
}
