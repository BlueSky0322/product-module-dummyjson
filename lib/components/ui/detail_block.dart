import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailBlock extends StatelessWidget {
  final String labelText;
  final String valueText;

  const DetailBlock({
    required this.labelText,
    required this.valueText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              labelText,
              style: GoogleFonts.outfit(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.end,
              children: [
                Text(
                  valueText,
                  textAlign: TextAlign.right,
                  maxLines: 10,
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
