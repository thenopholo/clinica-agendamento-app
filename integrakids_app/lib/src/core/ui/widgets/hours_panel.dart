import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_font.dart';

class HoursPanel extends StatelessWidget {
  final List<int>? enableHours;
  final int startTime;
  final int endTime;
  final ValueChanged<int> onTimePressed;

  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onTimePressed,
    this.enableHours,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecione os horários de atendimento',
            style: TextStyle(
              fontFamily: AppFont.primaryFont,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.integraBrown,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Wrap(
            spacing: 26,
            runSpacing: 12,
            children: [
              for (int i = startTime; i <= endTime; i++)
                TimeButton(
                  enableHours: enableHours,
                  time: '${i.toString().padLeft(2, '0')}:00',
                  onTimePressed: onTimePressed,
                  value: i,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimeButton extends StatefulWidget {
  final List<int>? enableHours;
  final String time;
  final int value;
  final ValueChanged<int> onTimePressed;
  const TimeButton({
    super.key,
    required this.time,
    required this.value,
    required this.onTimePressed,
    this.enableHours,
  });

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  var selected = false;
  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : AppColors.integraBrown;
    var btnColor = selected ? AppColors.integraBrown : Colors.white;

    final TimeButton(:value, :time, :enableHours, :onTimePressed) = widget;

    final disableHours = enableHours != null && !enableHours.contains(value);
    if (disableHours) {
      btnColor = Colors.grey[400]!;
    }

    return InkWell(
      onTap: disableHours
          ? null
          : () {
              setState(() {
                onTimePressed(value);
                selected = !selected;
              });
            },
      child: Container(
        width: 64,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: btnColor,
          border: Border.all(
            color: AppColors.integraBrown,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(5, 6),
            ),
          ],
        ),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
              fontFamily: AppFont.primaryFont,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
