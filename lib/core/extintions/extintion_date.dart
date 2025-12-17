import 'package:intl/intl.dart';

extension formatDate on DateTime{
  String get  getMonth {
    DateFormat formattedDate =DateFormat('MMMM');
    return formattedDate.format(this);




  }
  String get  toFormatDate {
    DateFormat formattedDate = DateFormat('dd / MM / yyyy');
    return formattedDate.format(this);
  }
  String get  toFormatTime {
    DateFormat formattedDate = DateFormat('hh:mm a');
    return formattedDate.format(this);
  }
  }