import 'package:evently/core/extintions/extintion_date.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app_colors.dart';

class EventDate extends StatelessWidget {
  const EventDate({super.key, required this.date});
final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(date.day.toString(),style: Theme.of(context).textTheme.titleMedium),
            Text(date.getMonth,style: Theme.of(context).textTheme.titleSmall,)
          ],
        ),
      ),
    );
  }
}
