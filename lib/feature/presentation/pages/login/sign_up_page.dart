import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_grid/simple_grid.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final namesController = TextEditingController();
  final surnamesController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SpGrid(
        children: [
          SpGridItem(
            xs: 0,
            sm: 6,
            md: 6,
            lg: 8,
            child: SizedBox(
              height: size.height,
              child: Image.asset(
                "assets/images/signup-image.jpg",
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
            child: SizedBox(
              height: size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset("assets/icons/logo-icon.png",
                        height: 180, width: 180),
                    SizedBox(height: size.height * 0.01),
                    const Text("Create Account",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500)),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        InkWell(
                            onTap: () => Get.back(),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ))
                      ],
                    ),
                    SizedBox(height: size.height * 0.05),
                    _buildTextField("Username", usernameController, size),
                    const SizedBox(height: 15),
                    _buildTextField("Names", namesController, size),
                    const SizedBox(height: 15),
                    _buildTextField("Surnames", surnamesController, size),
                    const SizedBox(height: 15),
                    _buildTextField("Password", passwordController, size),
                    SizedBox(height: size.height * 0.05),
                    Container(
                      height: 50,
                      width: 250,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color(0xff1A1D20),
                          borderRadius: BorderRadius.circular(50)),
                      child: Text("Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(
      String hintText, TextEditingController controller, Size size) {
    return SizedBox(
        width: size.height * 0.4,
        child: TextField(
            controller: controller,
            style: const TextStyle(fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintText: hintText)));
  }
}
