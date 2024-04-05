import 'package:finance_app/login/sign_up_view.dart';
import 'package:finance_app/widgets/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/color_extension.dart';
import '../../common_widget/secondary_boutton.dart';
import '../controllers/user_controller.dart';

class SocialLoginView extends StatefulWidget {
  const SocialLoginView({super.key});

  @override
  State<SocialLoginView> createState() => _SocialLoginViewState();
}

class ConnectivityErrorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.deepPurple, // Cor de ícone de falha de conexão
          ),
          SizedBox(width: 10),
          Text(
            'Connection error',
            style: TextStyle(color: Colors.deepPurple), // Cor do título
          ),
        ],
      ),
      content: const Text(
        'We were unable to establish an internet connection. Please check your connection and try again.',
        style: TextStyle(color: Colors.black87), // Cor do texto
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.deepPurple), // Cor do botão
          ),
        ),
      ],
    );
  }
}

class _SocialLoginViewState extends State<SocialLoginView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
     backgroundColor: TColor.gray,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/img/app_logo.png",
                  width: media.width * 0.5, fit: BoxFit.contain),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/img/apple_btn.png"),
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/apple.png",
                        width: 15,
                        height: 15,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Sign up with Apple",
                        style: TextStyle(
                            color: TColor.white,
                              fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  try {
                    final user = await UserController.loginWithGoogle();
                    if (user != null && mounted) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Bottom(),
                      ));
                    }
                  } on PlatformException catch (error) { // Alterado para PlatformException
                    print(error.message);
                    if (error.code == 'network_error') { // Verifica se o código do erro é network_error
                      showDialog(
                        context: context,
                        builder: (context) => ConnectivityErrorDialog(),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          error.message ?? "Something went wrong",
                        ),
                      ));
                    }
                  } catch (error) {
                    print(error);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        error.toString(),
                      ),
                    ));
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/img/google_btn.png"),
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4))
                      ]),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/google.png",
                        width: 15,
                        height: 15,
                        color: TColor.gray,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Sign up with Google",
                        style: TextStyle(
                            color: TColor.gray,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/img/fb_btn.png"),
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue.withOpacity(0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 4))
                      ]),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/fb.png",
                        width: 15,
                        height: 15,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Sign up with Facebook",
                        style: TextStyle(
                            color: TColor.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "or",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.white, fontSize: 14),
              ),
              const SizedBox(
                height: 25,
              ),
              SecondaryButton(
                title: "Sign up with E-mail",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpView()));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "By registering, you agree to our Terms of Use. Learn how we collect, use and share your data.",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
