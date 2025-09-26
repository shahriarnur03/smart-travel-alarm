import 'package:flutter/material.dart';
import 'package:smart_travel_alarm/constants/app_text_styles.dart';

class AlarmCard extends StatelessWidget {
  final String time;
  final String date;
  final bool isEnabled;
  final VoidCallback onToggle;

  const AlarmCard({
    super.key,
    required this.time,
    required this.date,
    required this.isEnabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF201A42),
        borderRadius: BorderRadius.circular(89),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              time,
              style: AppTextStyles.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            date,
            style: AppTextStyles.oxygen(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          SizedBox(width: 16),
          Switch(
            value: isEnabled,
            onChanged: (value) => onToggle(),
            activeColor: Colors.white,
            activeTrackColor: const Color(0xff5200FF),
            inactiveThumbColor: Colors.black,
            inactiveTrackColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
