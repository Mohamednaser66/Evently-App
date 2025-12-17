import 'package:evently/DM/category_dm.dart';
import 'package:evently/persentation/main_lay_out/tabs/map/widget/event_location_item.dart';
import 'package:evently/providers/config_%20provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../DM/event_data.dart';
import '../../../../DM/firebas_services/firebase_service.dart';


class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();

}


class _MapsState extends State<Maps> {
  late ConfigProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    provider= Provider.of<ConfigProvider>(context,listen: false);
    //provider.getLocation();
  }
  @override
  Widget build(BuildContext context) {
    provider =Provider.of<ConfigProvider>(context);
    return Consumer<ConfigProvider>(builder: (context, value, child) {
      return Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => provider.controller=controller,
            markers: provider.markers,
              mapType:  MapType.normal,
              initialCameraPosition: provider.cameraPosition
          ),
          Positioned(
            bottom: 70.h,
            right: 0,
            left: 0,
            child:   SizedBox(height: 120.h,
              child: StreamBuilder(
                stream: FirebaseService.getEventsRealTime(CategoryDM(id: '1', name: 'home', iconPath: Icons.home)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                   List<EventData> events = snapshot.data  ?? [];

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder:
                        (context, index) =>
                       InkWell(onTap: () {
                         provider.goToLocation(LatLng(events[index].lte!, events[index].lng!));
                       },
                           child: EventLocationItem(eventData: events[index])),
                    itemCount: events.length,
                  );
                },
              ),
            ),
          )
        ],
      );
    },) ;
  }
}
