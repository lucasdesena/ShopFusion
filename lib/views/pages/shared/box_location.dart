import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxLocation extends StatelessWidget {
  const BoxLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/store-1.svg',
            width: 25,
          ),
          const SizedBox(width: 15),
          Image.asset(
            'assets/icons/pickicon.png',
            width: 20,
          ),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            child: SizedBox(
              width: 300,
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Localização atual',
                  labelText: 'Localização atual',
                  labelStyle: GoogleFonts.lato(
                    fontSize: 16,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
