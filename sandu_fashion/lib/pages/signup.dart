import 'package:flutter/material.dart';
import 'package:sandu_fashion/pages/login.dart';
import 'package:sandu_fashion/widget/support_widget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
              top: 40.0, left: 20.0, right: 20.0, bottom: 40.0),
          child: Form(
            // key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("images/hero2.png", width: 400.0),
                Center(
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: AppWidget.semiboldTextFeildStyle(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    "Please enter the details below to\n                      continue.",
                    style: AppWidget.lightTextFeildStyle(),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Text(
                  "Name",
                  style: AppWidget.semiboldTextFeildStyle(),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 226, 238),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    //  controller: emailcontroller,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Enter Your Name"),
                  ),
                ),
                Text(
                  "Email",
                  style: AppWidget.semiboldTextFeildStyle(),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 226, 238),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    //  controller: emailcontroller,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Enter Your Email"),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Password",
                  style: AppWidget.semiboldTextFeildStyle(),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 226, 238),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    //controller: passwordcontroller,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Your Password"),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const SizedBox(
                  height: 50.0,
                ),
                GestureDetector(
                  /*onTap: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        email = emailcontroller.text;
                        password = passwordcontroller.text;
                      });
                    }
                    userLogin();
                  },*/
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text("SIGNUP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: AppWidget.lightTextFeildStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );

    /*const Scaffold(
      body: SingleChildScrollView(
          /* child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("images/logo.jpg", width: 1000),
                Center(
                  child: Text(
                    "Sign Up",
                    style: AppWidget.semiBoldTextFeildStyle(),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Text(
                    "Please enter the details below to\n                      continue.",
                    style: AppWidget.LightTextFeildStyle(),
                  ),
                ),
                const SizedBox(height: 40.0),
                Text("Name", style: AppWidget.semiBoldTextFeildStyle()),
                const SizedBox(height: 20.0),
                _buildTextField("Name", namecontroller),
                const SizedBox(height: 20.0),
                Text("Email", style: AppWidget.semiBoldTextFeildStyle()),
                const SizedBox(height: 20.0),
                _buildTextField("Email", emailcontroller),
                const SizedBox(height: 20.0),
                Text("Password", style: AppWidget.semiBoldTextFeildStyle()),
                const SizedBox(height: 20.0),
                _buildTextField("Password", passwordcontroller,
                    obscureText: true),
                const SizedBox(height: 50.0),
                _buildSignUpButton(),
                const SizedBox(height: 20.0),
                _buildSignInLink(),
              ],
            ),
          ),
        ), */
          ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller,
      {bool obscureText = false}) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color(0xfff4f5f9),
          borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $hintText';
          }
          return null;
        },
        decoration:
            InputDecoration(border: InputBorder.none, hintText: hintText),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return GestureDetector(
      onTap: () {
        /*if (_formkey.currentState!.validate()) {
          setState(() {
            name = namecontroller.text;
            email = emailcontroller.text;
            password = passwordcontroller.text;
          });
          registration();
        }*/
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(10)),
          child: const Center(
              child: Text("SIGN UP",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold))),
        ),
      ),
    );
  }

  Widget _buildSignInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account? ",
            style: AppWidget.lightTextFeildStyle()),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
          child: const Text("Sign In",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );    */
  }
}
