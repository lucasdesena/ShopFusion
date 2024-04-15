import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_fusion/config/pages_routes.dart';
import 'package:shop_fusion/controllers/auth_controller.dart';
import 'package:shop_fusion/models/tipo_mensagem.dart';
import 'package:shop_fusion/services/utils_services.dart';
import 'package:shop_fusion/views/pages/shared/box_elevated_button_style.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final UtilsServices utils = UtilsServices();
  final _authController = Get.find<AuthController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 14.4746,
  );

  late Position localizacaoAtual;
  late GoogleMapController mapController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await pegarLocalizacaoAtual();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            padding: const EdgeInsets.only(bottom: 200),
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);

              mapController = controller;

              await pegarLocalizacaoAtual();
            },
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: ElevatedButton(
                      style: BoxElevatedButtonStyle.style(
                        const EdgeInsets.only(top: 12, bottom: 12),
                      ),
                      onPressed: () {
                        Get.offAllNamed(Routes.mainRoute);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'COMPRE AGORA',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 4,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> logout() async {
    await _authController.logoutUsuario().then((mensagem) {
      if (mensagem.isNotEmpty) {
        utils.showToast(
          message: mensagem,
          tipo: TipoMensagem.erro,
        );
      } else {
        Get.offAllNamed(Routes.boasVindasLoginRoute);
      }
    });
  }

  Future<void> pegarLocalizacaoAtual() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled) {
      await logout();
      utils.showToast(
        message: 'O serviço de localização está desabilitado.',
        tipo: TipoMensagem.erro,
      );
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        await logout();
        utils.showToast(
          message: 'A permissão para localização foi negada.',
          tipo: TipoMensagem.erro,
        );
        return;
      }
    }

    Position posicao = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      forceAndroidLocationManager: true,
    );

    localizacaoAtual = posicao;

    LatLng pos = LatLng(posicao.latitude, posicao.longitude);

    CameraPosition cameraPosition = CameraPosition(target: pos, zoom: 16);
    await mapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
