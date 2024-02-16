import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Localização atual',
                  labelText: 'Localização atual',
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
