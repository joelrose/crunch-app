import 'package:alpaca/shared/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xff6400FF),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              color: const Color(0xff6400FF),
              child: Column(
                children: [
                  Container(
                    width: 339,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width * 0.18),
                        Container(
                          width: 40,
                          height: 25,
                          padding: const EdgeInsets.only(right: 15),
                          child: SvgPicture.asset('assets/google-logo.svg'),
                        ),
                        Text(
                          'Sign up with Google',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: const Color.fromRGBO(43, 45, 66, 1),
                            // fontFamily: 'Inter',
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            CupertinoButton(
              onPressed: () => {},
              padding: EdgeInsets.zero,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Row(
                  children: <Widget>[
                    Container(width: MediaQuery.of(context).size.width * 0.18),
                    Container(
                      width: 40,
                      height: 25,
                      padding: const EdgeInsets.only(right: 15),
                      child: SvgPicture.asset('assets/google-logo.svg'),
                    ),
                    Text(
                      'Sign up with Google',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: const Color.fromRGBO(43, 45, 66, 1),
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            getSocialButton(
              'Sign up with Google',
              'assets/google-logo.svg',
              MediaQuery.of(context).size.width,
            ),
            getSocialButton(
              'Sign up with Apple',
              'assets/apple-logo.svg',
              MediaQuery.of(context).size.width,
              backgroundWhite: false,
            ),
          ],
        ),
      ),
    );
  }
}
