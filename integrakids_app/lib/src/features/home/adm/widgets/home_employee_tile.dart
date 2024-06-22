import 'package:flutter/material.dart';

import '../../../../core/ui/utils/app_colors.dart';
import '../../../../core/ui/utils/app_font.dart';
import '../../../../core/ui/utils/app_images.dart';
import '../../../../core/ui/widgets/integrakids_icons.dart';
import '../../../../model/user_model.dart';

class HomeEmployeeTile extends StatelessWidget {
  final UserModel employee;
  const HomeEmployeeTile({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 105,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.integraOrange),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(5, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: switch (employee.avatar) {
                  final avatar? => NetworkImage(avatar),
                  _ => const AssetImage(AppImages.avatar),
                } as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                    color: AppColors.integraOrange,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFont.primaryFont,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/schedule', arguments: employee);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.integraOrange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black,
                      ),
                      child: const Text(
                        'Agendar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppFont.primaryFont,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/employee/schedule',
                            arguments: employee);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.white,
                        side: const BorderSide(
                          color: AppColors.integraOrange,
                          width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black,
                      ),
                      child: const Text(
                        'Ver Agenda',
                        style: TextStyle(
                          color: AppColors.integraOrange,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppFont.primaryFont,
                        ),
                      ),
                    ),
                    const Icon(
                      IntegrakidsIcons.penEdit,
                      size: 16,
                      color: AppColors.integraOrange,
                    ),
                    const Icon(
                      IntegrakidsIcons.trash,
                      size: 16,
                      color: Colors.red,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
