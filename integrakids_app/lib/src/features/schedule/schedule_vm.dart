import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/fp/either.dart';
import '../../core/providers/app_providers.dart';
import '../../model/clinica_model.dart';
import '../../model/user_model.dart';
import '../../repositories/schedule/schedule_repository.dart';
import 'schedule_state.dart';

part 'schedule_vm.g.dart';

@riverpod
class ScheduleVm extends _$ScheduleVm {
  @override
  ScheduleState build() => ScheduleState.initial();

  void hourSelect(int hour) {
    if (hour == state.scheduleHour) {
      state = state.copyWith(scheduleHour: null);
    } else {
      state = state.copyWith(scheduleHour: () => hour);
    }
  }

  void dateSelect(DateTime date) {
    state = state.copyWith(scheduleDate: () => date);
  }

  Future<void> resgister(
      {required UserModel userModel, required String patientName}) async {
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final ScheduleState(:scheduleDate, :scheduleHour) = state;
    final scheduleRepository = ref.read(scheduleRepositoryProvider);
    final ClinicaModel(id: clinicaId) =
        await ref.watch(getMyClinicaProvider.future);

    final dto = (
      clinicaId: clinicaId,
      userId: userModel.id,
      patientName: patientName,
      date: scheduleDate!,
      time: scheduleHour!,
    );

    final schduleResult = await scheduleRepository.schedulePatient(dto);

    switch (schduleResult) {
      case Success():
        state = state.copyWith(status: ScheduleStateStatus.success);
      case Failure():
        state = state.copyWith(status: ScheduleStateStatus.error);
    }

    asyncLoaderHandler.close();
  }
}
