import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_fusion/config/pages_routes.dart';
import 'package:shop_fusion/controllers/perfil_controller.dart';
import 'package:shop_fusion/models/tipo_mensagem.dart';
import 'package:shop_fusion/services/utils_services.dart';
import 'package:shop_fusion/services/validators.dart';
import 'package:shop_fusion/views/pages/shared/box_elevated_button_style.dart';
import 'package:shop_fusion/views/pages/shared/box_text_field.dart';

class EditarPerfilPage extends StatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  final _perfilController = Get.find<PerfilController>();
  final UtilsServices utils = UtilsServices();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String emailAtual = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await preencherEmail();
      await preencherNome();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Perfil',
          style: GoogleFonts.lato(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Edite seus dados',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              BoxTextField(
                controller: emailController,
                icon: Icons.email,
                label: 'Email',
                hintText: 'Insira o seu Email',
                validator: emailValidator,
              ),
              BoxTextField(
                controller: nomeController,
                icon: Icons.person,
                label: 'Nome',
                hintText: 'Insira o seu Nome',
                validator: nameValidator,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async => await atualizarPerfil(),
                  style: BoxElevatedButtonStyle.style(
                    const EdgeInsets.all(14),
                  ),
                  child: Text(
                    'SALVAR',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> preencherNome() async {
    await _perfilController.obterNome().then((resposta) {
      String nome = resposta.nome;
      String mensagem = resposta.mensagemErro;

      if (nome.isNotEmpty) {
        setState(() {
          nomeController.text = nome;
        });
      } else {
        utils.showToast(
          message: mensagem,
          tipo: TipoMensagem.erro,
        );
      }
    });
  }

  Future<void> preencherEmail() async {
    await _perfilController.obterEmail().then((resposta) {
      String email = resposta.email;
      String mensagem = resposta.mensagemErro;

      if (email.isNotEmpty) {
        emailAtual = email;
        setState(() {
          emailController.text = email;
        });
      } else {
        utils.showToast(
          message: mensagem,
          tipo: TipoMensagem.erro,
        );
      }
    });
  }

  Future<void> atualizarPerfil() async {
    bool isEmailDif = false;
    if (emailAtual != emailController.text) {
      isEmailDif = true;
    }

    await _perfilController
        .atualizarPerfil(
      emailController.text,
      nomeController.text,
      isEmailDif,
    )
        .then((resposta) {
      String mensagemSucesso = resposta.mensagemSucesso;
      String mensagemErro = resposta.mensagemErro;

      if (mensagemSucesso.isNotEmpty) {
        if (isEmailDif) {
          Get.offAllNamed(Routes.boasVindasLoginRoute);
        }
        utils.showToast(
          message: mensagemSucesso,
          tipo: TipoMensagem.sucesso,
        );
      } else {
        utils.showToast(
          message: mensagemErro,
          tipo: TipoMensagem.erro,
        );
      }
    });
  }
}
