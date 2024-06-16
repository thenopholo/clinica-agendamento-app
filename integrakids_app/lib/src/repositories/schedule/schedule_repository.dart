import '../../core/exceptions/repository_exception.dart';
import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';

abstract interface class ScheduleRepository {
  Future<Either<RepositoryException, Nil>> schedulePatient(
      ({
        int clinicaId,
        int userId,
        String patientName,
        DateTime date,
        int time,
      }) scheduleData);
}
