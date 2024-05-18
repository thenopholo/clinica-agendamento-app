import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/fp/either.dart';
import '../../../../core/providers/app_providers.dart';
import '../../../../model/clinica_model.dart';
import 'home_adm_state.dart';

part 'home_adm_vm.g.dart';

@riverpod
class HomeAdmVm extends _$HomeAdmVm {
  @override
  Future<HomeAdmState> build() async {
    final repository = ref.read(userRepositorieProvider);
    final ClinicaModel(id: clinicaId) =
        await ref.read(getMyClinicaProvider.future);
    final employeesResult = await repository.getEmployees(clinicaId);

    switch (employeesResult) {
      case Success(value: final employees):
        return HomeAdmState(
          status: HomeAdmStatus.loaded,
          employees: employees,
        );
      case Failure():
        return HomeAdmState(
          status: HomeAdmStatus.error,
          employees: [],
        );
    }
  }

  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();
}
