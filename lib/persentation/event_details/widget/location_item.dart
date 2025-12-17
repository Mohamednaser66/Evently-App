import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationItem extends StatefulWidget {
  const LocationItem({super.key, required this.late,required this.lng});

  final double late,lng;

  @override
  State<LocationItem> createState() => _LocationItemState();
}

class _LocationItemState extends State<LocationItem> {
  @override
  void initState() {
    convertLocationToAddress();


    super.initState();
  }

  String address = "picked your address";

  Future<void> convertLocationToAddress() async {
    try {
      GeoCode geoCode = GeoCode();
      Address response = await geoCode.reverseGeocoding(
        latitude: widget.late,
        longitude: widget.lng,
      );

      setState(() {
        address = '${response.city ?? 'Unknown City'}, ${response.streetAddress ?? 'Unknown Street'}';
      });
    } catch (e) {
      print('Error occurred while converting location: $e');
      setState(() {
        address = 'Failed to get address';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: Theme
            .of(context)
            .primaryColor),

      ),
      child: Row(
        children: [
          Icon(Icons.gps_fixed, color: Theme
              .of(context)
              .primaryColor, size: 40,),
          SizedBox(width: 8.w,),
          Expanded(
            child: Text(address,style: Theme.of(context).textTheme.titleMedium,
            maxLines: 2,),
          )

        ],
      ),
    );
  }
}
