import 'package:finance_app/common_widget/secondary_boutton.dart';
import 'package:finance_app/view/login/social_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/color_extension.dart';
import '../../common_widget/primary_button.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeView();
}

class _WelcomeView extends State<WelcomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            'assets/img/welcome_screen.png',
            width: media.width,
            height: media.height,
            fit: BoxFit.cover,
          ),
          // ...
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adicione esta linha
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/img/app_logo.png',
                      width: media.width * 0.5, fit: BoxFit.contain),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Centraliza os widgets verticalmente
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Begin your financial journey here",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: TColor.white, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 45,
                      ),

                      PrimaryButton(
                        title: 'Get started',
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context)  => const SocialLoginView()
                            ),
                          );
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      SecondaryButton(
                        title: 'I have an account',
                        onPressed: (){},
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                  Text(
                    "Developed by Daniel Girotto.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: TColor.white, fontSize: 11),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
