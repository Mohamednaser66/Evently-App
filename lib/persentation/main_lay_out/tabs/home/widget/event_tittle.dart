import 'package:evently/DM/firebas_services/firebase_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/app_colors.dart';

class EventTitle extends StatefulWidget {
  const EventTitle({super.key, required this.title,required this.eventId,required this.isFav});
  final String title;
  final String eventId;
  final bool isFav;


  @override
  State<EventTitle> createState() => _EventTitleState();
}

class _EventTitleState extends State<EventTitle> {
  late bool isFav =widget.isFav;
  @override
  Widget build(BuildContext context) {
    return  Card(

      child: Padding(
        padding:  REdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title,style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
           IconButton(onPressed: (){
             addEventToFav();
           },
               icon:isFav? Icon(Icons.favorite):Icon(Icons.favorite_outline) )
          ],
        ),
      ),
    );
  }

  void addEventToFav()async {

   isFav = !isFav;

   if(isFav){
     await  FirebaseService.addEventToFav(widget.eventId);
   }else{
     FirebaseService.removeEventFromFav(widget.eventId);
   }
   setState(() {

   });
  }
}
