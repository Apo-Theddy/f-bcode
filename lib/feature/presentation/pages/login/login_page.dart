import 'package:bcode/feature/presentation/pages/login/sign_up_page.dart';
import 'package:flutter/material.dart';
import "package:flutter_linkify/flutter_linkify.dart";
import "package:get/get.dart";
import "package:simple_grid/simple_grid.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:linkify/linkify.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordObscure = true;
  bool rememberPassword = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SpGrid(width: size.width, children: [
        SpGridItem(
          xs: 0,
          sm: 6,
          md: 6,
          lg: 8,
          child: SizedBox(
            height: size.height,
            child: SvgPicture.asset(
              "assets/images/login-image.svg",
              fit: BoxFit.fill,
            ),
          ),
        ),
        SpGridItem(
          xs: 12,
          sm: 6,
          md: 6,
          lg: 4,
          order: const SpOrder(xs: 1),
          child: Container(
            height: size.height,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset("assets/icons/logo-icon.png",
                      height: 180, width: 180),
                  SizedBox(height: size.height * 0.01),
                  const Text("Welcome back!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                  SizedBox(height: size.height * 0.02),
                  const Text("Please enter your details"),
                  SizedBox(height: size.height * 0.05),
                  Container(
                    width: size.height * 0.4,
                    child: const TextField(
                        style: TextStyle(fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: "Email")),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                      width: size.height * 0.4,
                      child: TextField(
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: "Password",
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPasswordObscure = !isPasswordObscure;
                                  });
                                },
                                child:
                                    const Icon(Icons.remove_red_eye_outlined))),
                        obscureText: isPasswordObscure,
                      )),
                  SizedBox(height: size.height * 0.02),
                  SizedBox(
                    width: size.height * 0.4,
                    child: Row(
                      children: [
                        Checkbox(
                            activeColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(color: Colors.black)),
                            value: rememberPassword,
                            onChanged: (value) {
                              setState(() {
                                rememberPassword = !rememberPassword;
                              });
                            }),
                        const Text("Remember for 30 days")
                      ],
                    ),
                  ),
                  SizedBox(height: 60),
                  Container(
                    height: 50,
                    width: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xff1A1D20),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text("Log in",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: size.height / 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      InkWell(
                          onTap: () {
                            Get.to(() => const SignUpPage(),
                                transition: Transition.cupertino);
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
