class ScheduleModel {
  final int id;
  final int clinicaId;
  final int userId;
  final String patientName;
  final DateTime date;
  final int hour;

  ScheduleModel({
    required this.id,
    required this.clinicaId,
    required this.userId,
    required this.patientName,
    required this.date,
    required this.hour,
  });

  factory ScheduleModel.fromMap(Map<String, dynamic> json) {
    switch (json) {
      case {
          'id': int id,
          'clinica_id': int clinicaId,
          'user_id': int userId,
          'patient_name': String patientName,
          'date': String scheduleDate,
          'time': int hour,
        }:
        return ScheduleModel(
          id: id,
          clinicaId: clinicaId,
          userId: userId,
          patientName: patientName,
          date: DateTime.parse(scheduleDate),
          hour: hour,
        );
      case _:
        throw ArgumentError('Ivalid Json');
    }
  }
}
