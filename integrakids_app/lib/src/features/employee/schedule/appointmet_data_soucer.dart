import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../core/ui/utils/app_colors.dart';
import '../../../model/schedule_model.dart';

class AppointmetDataSoucer extends CalendarDataSource {
  final List<ScheduleModel> schedules;

  AppointmetDataSoucer({
    required this.schedules,
  });

  @override
  List<dynamic>? get appointments {
    return schedules.map((e) {
      final ScheduleModel(
        date: DateTime(:year, :month, :day),
        :hour,
        :patientName,
      ) = e;
      final startTime = DateTime(year, month, day, hour, 0, 0);
      final endTime = DateTime(year, month, day, hour + 1, 0, 0);

      return Appointment(
        color: AppColors.integraBrown,
        startTime: startTime,
        endTime: endTime,
        subject: patientName,
      );
    }).toList();
  }
}
