import 'package:evently/DM/event_data.dart';
import 'package:evently/authentication/sign_in/sign_in.dart';
import 'package:evently/authentication/sign_up/sign_up.dart';
import 'package:evently/persentation/event_details/event_details.dart';
import 'package:evently/persentation/main_lay_out/create_event_screen/create_event.dart';
import 'package:evently/persentation/main_lay_out/main_lay_out.dart';
import 'package:evently/persentation/main_lay_out/create_event_screen/selected_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoutesManager{
  static const String signIn ='/signIn';
  static const String signUp ='/signUp';
  static const String mainLayOut ='/mainLayOut';
  static const String createEvent ='/CreateEvent';
  static const String selectedLocation ='/selectedLocation';
  static const String eventDetails ='/eventDetails';

  static Route? router (RouteSettings settings){
    switch(settings.name){
      case signIn:
        return CupertinoPageRoute(builder: (context) => SignIn(),);
      case signUp:
        return CupertinoPageRoute(builder: (context) => SignUp(),);
        case mainLayOut:
        return CupertinoPageRoute(builder: (context) => MainLayOut(),);
      case createEvent:
        return CupertinoPageRoute(
          settings: settings,
          builder: (context) => CreateEvent(event: settings.arguments as EventData?,),);
      case selectedLocation:
        return CupertinoPageRoute(builder: (context) => SelectedLocation(),);
        case eventDetails:
        return CupertinoPageRoute(
          settings: settings,
          builder: (context) => EventDetails(eventData: settings.arguments as EventData,),);



    }
    }
  }

