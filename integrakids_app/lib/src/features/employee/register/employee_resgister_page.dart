import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/providers/app_providers.dart';
import '../../../core/ui/helpers/form_helper.dart';
import '../../../core/ui/helpers/messages.dart';
import '../../../core/ui/utils/app_colors.dart';
import '../../../core/ui/utils/app_font.dart';
import '../../../core/ui/widgets/avatar_widget.dart';
import '../../../core/ui/widgets/hours_panel.dart';
import '../../../core/ui/widgets/integrakids_loader.dart';
import '../../../core/ui/widgets/weekdays_panel.dart';
import '../../../model/clinica_model.dart';
import 'employee_register_state.dart';
import 'employee_register_vm.dart';

class EmployeeResgisterPage extends ConsumerStatefulWidget {
  const EmployeeResgisterPage({super.key});

  @override
  ConsumerState<EmployeeResgisterPage> createState() =>
      _EmployeeResgisterPageState();
}

class _EmployeeResgisterPageState extends ConsumerState<EmployeeResgisterPage> {
  var registerADM = false;
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeRegisterVm = ref.watch(employeeRegisterVmProvider.notifier);
    final clinicaAsyncValue = ref.watch(getMyClinicaProvider);

    ref.listen(employeeRegisterVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case EmployeeRegisterStateStatus.initial:
          break;
        case EmployeeRegisterStateStatus.success:
          Messages.showSuccess('Terapeuta cadastrado com sucesso', context);
          Navigator.of(context).pop();
        case EmployeeRegisterStateStatus.error:
          Messages.showError('Erro ao resgistrar terapeuta', context);
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar terapeuta'),
        ),
        body: clinicaAsyncValue.when(
          error: (error, stackTrace) {
            log('Erro ao carregar a página',
                error: error, stackTrace: stackTrace);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Erro ao carregar a página'),
                  ElevatedButton(
                    onPressed: () => ref.refresh(getMyClinicaProvider),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          },
          loading: () => const IntegrakidsLoader(),
          data: (clinicaModel) {
            final ClinicaModel(:openingDays, :openingHours) = clinicaModel;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      children: [
                        const AvatarWidget(),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            Checkbox.adaptive(
                                value: registerADM,
                                onChanged: (value) {
                                  setState(() {
                                    registerADM = !registerADM;
                                    employeeRegisterVm
                                        .setRegisterADM(registerADM);
                                  });
                                }),
                            const Expanded(
                              child: Text(
                                'Sou administrador e quero me cadastrar como terapeuta',
                                style: TextStyle(
                                  fontFamily: AppFont.primaryFont,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Offstage(
                          offstage: registerADM,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                onTapOutside: (_) => context.unFocus(),
                                controller: nameEC,
                                validator: registerADM
                                    ? null
                                    : Validatorless.required(
                                        'Nome obrigatório'),
                                decoration: const InputDecoration(
                                  labelText: 'Nome',
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                onTapOutside: (_) => context.unFocus(),
                                controller: emailEC,
                                validator: registerADM
                                    ? null
                                    : Validatorless.multiple([
                                        Validatorless.required(
                                            'Email obrigatório'),
                                        Validatorless.email('Email inválido'),
                                      ]),
                                decoration: const InputDecoration(
                                  labelText: 'E-mail',
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                onTapOutside: (_) => context.unFocus(),
                                controller: passwordEC,
                                validator: registerADM
                                    ? null
                                    : Validatorless.multiple([
                                        Validatorless.required(
                                            'Senha obrigatória'),
                                        Validatorless.min(6,
                                            'Senha deve ter no mínimo 6 caracteres'),
                                      ]),
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Senha',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        WeekdaysPanel(
                          enableDays: openingDays,
                          onDayPressed: employeeRegisterVm.addOrRemoveWorkDays,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        HoursPanel(
                          enableHours: openingHours,
                          startTime: 6,
                          endTime: 23,
                          onTimePressed:
                              employeeRegisterVm.addOrRemoveWorkHours,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            switch (formKey.currentState?.validate()) {
                              case false || null:
                                Messages.showError(
                                    'Existem campos inválidos', context);
                              case true:
                                final EmployeeRegisterState(
                                  workDays: List(isNotEmpty: hasWorkDays),
                                  workHours: List(isNotEmpty: hasWorkHours),
                                ) = ref.watch(employeeRegisterVmProvider);

                                if (!hasWorkDays || !hasWorkHours) {
                                  Messages.showError(
                                      'Selecione pelo menos um dia e um horário de trabalho',
                                      context);
                                  return;
                                }

                                final name = nameEC.text;
                                final email = emailEC.text;
                                final password = passwordEC.text;
                                employeeRegisterVm.register(
                                  name: name,
                                  email: email,
                                  password: password,
                                );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(56),
                            backgroundColor: AppColors.integraOrange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            shadowColor: Colors.black,
                          ),
                          child: const Text('Cadastrar terapeuta'),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
