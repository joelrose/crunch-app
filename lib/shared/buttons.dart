import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget getSocialButton(
  String buttonText,
  String assetPath,
  double width, {
  bool backgroundWhite = true,
}) {
  return CupertinoButton(
    onPressed: () => {},
    padding: EdgeInsets.zero,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        color: backgroundWhite ? Colors.white : Colors.black,
      ),
      child: Row(
        children: <Widget>[
          Container(width: width * 0.18),
          Container(
            width: 40,
            height: 25,
            padding: const EdgeInsets.only(right: 15),
            child: SvgPicture.asset(assetPath),
          ),
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: backgroundWhite
                  ? const Color.fromRGBO(43, 45, 66, 1)
                  : Colors.white,
              fontSize: 16,
              letterSpacing: 0,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
        ],
      ),
    ),
  );
}
