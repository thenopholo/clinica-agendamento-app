import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';
import '../../core/restClient/rest_client.dart';
import '../../model/schedule_model.dart';
import './schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final RestClient restClient;
  ScheduleRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, Nil>> schedulePatient(
      ({
        int clinicaId,
        DateTime date,
        String patientName,
        int time,
        int userId
      }) scheduleData) async {
    try {
      await restClient.auth.post('/schedules', data: {
        'clinica_id': scheduleData.clinicaId,
        'user_id': scheduleData.userId,
        'patient_name': scheduleData.patientName,
        'date': scheduleData.date.toIso8601String(),
        'time': scheduleData.time,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar agendamento', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao agendar consulta'));
    }
  }

  @override
  Future<Either<RepositoryException, List<ScheduleModel>>> findScheduleByDate(
      ({
        DateTime date,
        int userId,
      }) filter) async {
    try {
      final Response(:List data) =
          await restClient.auth.get('/schedules', queryParameters: {
        'user_id': filter.userId,
        'date': filter.date.toIso8601String(),
      });
      final schedules = data.map((s) => ScheduleModel.fromMap(s)).toList();
      return Success(schedules);
    } on DioException catch (e, s) {
      log('Erro ao buscar agendamentos de uma data', error: e, stackTrace: s);
      return Failure(
        RepositoryException(message: 'Erro ao buscar agendamentos de uma data'),
      );
    } on ArgumentError catch (e, s) {
      log('Erro ao converter json para ScheduleModel', error: e, stackTrace: s);
      return Failure(
        RepositoryException(
            message: 'Erro ao converter json para ScheduleModel'),
      );
    }
  }
}
