
import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';

class StoreInformationItem extends StatelessWidget {
  const StoreInformationItem({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: AlpacaColor.primary80),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xff7d8489),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: AlpacaColor.darkNavyColor,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
