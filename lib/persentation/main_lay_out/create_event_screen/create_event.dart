import 'package:evently/DM/category_dm.dart';
import 'package:evently/DM/event_data.dart';
import 'package:evently/DM/firebas_services/firebase_service.dart';
import 'package:evently/DM/user_dm.dart';
import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/authentication/widgets/custom_text_button.dart';
import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/core/app_colors.dart';
import 'package:evently/core/constant_manager.dart';
import 'package:evently/core/extintions/extintion_date.dart';
import 'package:evently/core/routes_manager.dart';
import 'package:evently/persentation/main_lay_out/tabs/home/widget/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateEvent extends StatefulWidget {
   CreateEvent({super.key,this.event});
  EventData? event;

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
late  TextEditingController titleController;
 late TextEditingController descriptionController;
  DateTime selectedDate =DateTime.now();
  TimeOfDay time =TimeOfDay.now();
  GlobalKey<FormState> key= GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    titleController=TextEditingController();
    descriptionController =TextEditingController();
    initEdit();

  }
  initEdit(){
    if(widget.event!=null){
      titleController.text=widget.event!.tittle;
      descriptionController.text=widget.event!.description;
      selectedCategory=widget.event!.category;
      selectedDate=widget.event!.date;
      location=LatLng(widget.event!.lte!,widget.event!.lng!);
      time=TimeOfDay(hour: widget.event!.date.hour, minute: widget.event!.date.minute);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }
LatLng? location;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
          title: Text(widget.event==null?AppLocalizations.of(context)!.create_event:'Edit Event')),
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(selectedCategory.imagePath?? 'assets/images/birthday.png'),
                ),
                SizedBox(height: 16.h,),
                CustomTabBar(
                  initialIndex: ConstantManager.categories.indexOf(selectedCategory),
                  onCategoryItemClicked:  _onCategoryClicked,
                  categories: ConstantManager.categories,
                  selectedTabBgColor: AppColors.blue,
                  unSelectedTabBgColor: Colors.transparent,
                  selectedContentColor: AppColors.light,
                  unSelectedContentColor: AppColors.blue,
                ),
                SizedBox(height: 16.h,),
                Text(AppLocalizations.of(context)!.title, style: Theme
                    .of(context)
                    .textTheme
                    .labelSmall,),
                SizedBox(height: 8.h,),
                CustomTextFormField(
                  validator: (inPut) {
                    if(inPut==null||inPut.isEmpty){
                      return 'Please Enter Event Title';
                    }if(inPut.length<6){
                      return 'Sorry, Title Should Be At Least 6 characters';
                    }return null;
                  },
                  controller: titleController,
                    hint: AppLocalizations.of(context)!.event_title,
                    prefixIcon: Icons.mode_edit_rounded), SizedBox(height: 16.h,),
                Text(AppLocalizations.of(context)!.description, style: Theme
                    .of(context)
                    .textTheme
                    .labelSmall,),
                SizedBox(height: 8.h,),
                CustomTextFormField(
                  validator: (inPut) {
                    if(inPut==null||inPut.isEmpty){
                      return 'Please Enter Event Description';
                    }if(inPut.length<6){
                      return 'Sorry, Description Should Be At Least 6 characters';
                    }return null;
                  },
                  controller: descriptionController,
                  hint: AppLocalizations.of(context)!.event_description,
                  lines: 4,),
                SizedBox(height: 16.h,),
                Row(
                  children: [Icon(Icons.date_range,),
                    SizedBox(width: 8.w,),
                    Text(selectedDate.toFormatDate,
                      style: Theme
                        .of(context)
                        .textTheme
                        .labelSmall,),
                    Spacer(),
                    CustomTextButton(
                        tittle: AppLocalizations.of(context)!.choose_date,
                        onClick: _selectEventDate)
                  ],
                ),
                SizedBox(height: 12.h,),
                Row(
                  children: [Icon(Icons.access_time_outlined,),
                    SizedBox(width: 8.w,),
                    Text(selectedDate.copyWith(hour: time.hour,minute: time.minute).toFormatTime, style: Theme
                        .of(context)
                        .textTheme
                        .labelSmall,),
                    Spacer(),
                    CustomTextButton(
                        tittle: AppLocalizations.of(context)!.choose_time,
                        onClick: _selectEventTime)
                  ],

                ),
                CustomElevatedButton(
                    tittle: location==null ?"Select Location ": "${location!.latitude},${location!.longitude}",
                    onClick: (){
                      Navigator.pushNamed(context, RoutesManager.selectedLocation).then((value) {
                        if(value !=null){
                          location=value as LatLng;
                          setState(() {

                          });
                        }
                      },);
                    }),
                SizedBox(height: 16,),
                CustomElevatedButton(
                    tittle: AppLocalizations.of(context)!.add_event,
                    onClick: createEvent),
                SizedBox(height: 24.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectEventDate()async {
   selectedDate= await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))) ?? selectedDate;
   setState(() {

   });
  }

  void _selectEventTime()async {
    time=await showTimePicker(context: context, initialTime: TimeOfDay.now()) ??time;
    setState(() {

    });
  }
  updateEvent(){
    if(key.currentState?.validate() == false) return;
    EventData event = EventData(
      id:widget.event!.id ,
      lte: location?.latitude,
      lng: location?.longitude,
      uId: UserDM.currentUser!.id,
      tittle: titleController.text,
      category: selectedCategory,
      description: descriptionController.text,
      date: selectedDate.copyWith(hour:time.hour,minute: time.minute ),
    );
    FirebaseService.updateEvent(event).then((value) {Navigator.pop(context);},);

  }

  void createEvent() {
    if(key.currentState?.validate() == false) return;
    EventData event = EventData(
      lte: location?.latitude,
      lng: location?.longitude,
      uId: UserDM.currentUser!.id,
      tittle: titleController.text,
        category: selectedCategory,
        description: descriptionController.text,
        date: selectedDate.copyWith(hour:time.hour,minute: time.minute ),
        );
     FirebaseService.addEventToFireStore(event).then((_){
       Navigator.pop(context);
     },);
    
  }
CategoryDM selectedCategory =ConstantManager.categories[0];
  void _onCategoryClicked(CategoryDM category) {
    print(category.name);
    selectedCategory  =category;
    setState(() {

    });
  }
}
