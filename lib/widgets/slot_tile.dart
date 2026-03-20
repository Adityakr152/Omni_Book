import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class SlotTile extends StatelessWidget {
  final DateTime time;
  final bool available;
  final int spots;
  final bool isBooked;
  final VoidCallback? onTap;

  const SlotTile({
    required this.time,
    required this.available,
    required this.spots,
    required this.isBooked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        "${time.hour > 12 ? time.hour - 12 : time.hour}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? "PM" : "AM"}";

    Color bgColor;
    Color textColor = Colors.white;

    if (!available) {
      bgColor = Colors.grey.shade400; // unavailable
    } else if (isBooked) {
      bgColor = AppColors.lightPurple; // partially booked
    } else {
      bgColor = AppColors.primary; // available
    }

    return GestureDetector(
      onTap: available ? onTap : null,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formattedTime,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            if (available)
              Text(
                "$spots Spots Left",
                style: TextStyle(
                  color: textColor.withOpacity(0.9),
                  fontSize: 11,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
