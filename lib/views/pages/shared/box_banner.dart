import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BoxBanner extends StatefulWidget {
  const BoxBanner({super.key});

  @override
  State<BoxBanner> createState() => _BoxBannerState();
}

class _BoxBannerState extends State<BoxBanner> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _cartazes = [];

  Future<void> getCartazes() async {
    await _firestore
        .collection('cartazes')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _cartazes.add(doc['imagem']);
        });
      }
    });
  }

  @override
  void initState() {
    getCartazes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: _cartazes.map((e) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Builder(
              builder: (context) {
                return Image.network(
                  e,
                  fit: BoxFit.cover,
                );
              },
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: 200,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ));
  }
}
