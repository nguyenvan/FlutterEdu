import 'package:edu_sys/src/api/firebase_service.dart';
import 'package:edu_sys/src/users/register.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
       Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Align(
      alignment: Alignment.center,
      child: Container(
        width: 400,
        height: 400,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 214, 214, 7),
        ),
        child: Column(children: [
          const Text(
            "Login",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Color.fromARGB(255, 5, 133, 237)),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: phoneNumberController,
            obscureText: true,
            decoration: const InputDecoration(
                hintText: "Phone",
                icon: Icon(
                  Icons.phone,
                  color: Colors.black,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
                hintText: "Password",
                icon: Icon(
                  Icons.lock,
                  color: Colors.black,
                )),
          ),
           const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () => {signIn(context)},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(size.width - 50, 55),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()))
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 254),
                  minimumSize: Size(size.width - 50, 55),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 20),
                ),
              ),
        ]),
      ),
    ));
  }
   final EduService service = EduService();
  signIn(BuildContext context) async {
   
    try {
    bool isLogin=  await service.login(phoneNumberController.text, passwordController.text);
if(isLogin){
showTopSnackBar(
        // ignore: use_build_context_synchronously
        Overlay.of(context),
        const CustomSnackBar.info(
          message: "Login successfull",
        ),
        dismissType: DismissType.onSwipe,
        dismissDirection: [DismissDirection.endToStart],
      );
}else{
showTopSnackBar(
        // ignore: use_build_context_synchronously
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Login fail",
        ),
        dismissType: DismissType.onSwipe,
        dismissDirection: [DismissDirection.endToStart],
      );
}
      
    } catch (e) {
      showTopSnackBar(
        // ignore: use_build_context_synchronously
        Overlay.of(context),
        CustomSnackBar.error(
          // ignore: unnecessary_null_comparison
          message: e.toString(),
        ),
        dismissType: DismissType.onSwipe,
        dismissDirection: [DismissDirection.endToStart],
      );
    }
  }
}
