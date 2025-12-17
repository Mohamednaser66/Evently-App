import 'package:evently/core/app_colors.dart';
import 'package:evently/persentation/main_lay_out/create_event_screen/selected_location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SelectedLocation extends StatelessWidget {
  const SelectedLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => SelectedLocationProvider(),
   child:  Consumer<SelectedLocationProvider>(builder: (context, provider, child) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: GoogleMap(markers: provider.markers,
              initialCameraPosition: provider.cameraPosition,
              onMapCreated: (controller) => provider.controller =controller,
              onTap: (LatLng latLing){
                provider.changeSelectedLocation(latLing);
                Navigator.pop(context, latLing);
              },
              )
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(16),
            child: Text('Tap On Location To Select',style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.light),),
          )
        ],
      ),
    );},),);
  }
}
