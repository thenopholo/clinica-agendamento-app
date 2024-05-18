import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_font.dart';

class HoursPanel extends StatelessWidget {
  final int startTime;
  final int endTime;
  final ValueChanged<int> onTimePressed;

  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onTimePressed,
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
  final String time;
  final int value;
  final ValueChanged<int> onTimePressed;
  const TimeButton({
    super.key,
    required this.time,
    required this.value,
    required this.onTimePressed,
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
    return InkWell(
      onTap: () {
        setState(() {
          widget.onTimePressed(widget.value);
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
            widget.time,
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
