import 'package:edu_sys/src/api/firebase_service.dart';
import 'package:edu_sys/src/users/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final EduService service = EduService();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final userTypeController = TextEditingController();
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const List<String> userType = <String>['Center', 'Teacher', 'Normal User'];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: 400,
          height: 550,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 221, 240, 248),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Register Page ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Color.fromARGB(255, 5, 133, 237)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: fullNameController,
                decoration: const InputDecoration(
                    hintText: "Fullname", icon: Icon(Icons.person)),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                    hintText: "Address",
                    icon: Icon(
                      Icons.add_location_outlined,
                      color: Colors.black,
                    )),
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
                height: 10,
              ),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: "Confrim Password",
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  DropdownMenu<String>(
                    controller: userTypeController,
                    width: 320,
                    initialSelection: userType.first,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {});
                    },
                    dropdownMenuEntries:
                        userType.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () => {signUp(context)},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(size.width - 50, 55),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                child: const Text(
                  "Register",
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
                          builder: (context) => const LoginScreen()))
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 254),
                  minimumSize: Size(size.width - 50, 55),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signUp(BuildContext context) async {
    RegisterUserRequest registerUserRequest = RegisterUserRequest(
        fullName: fullNameController.text,
        phoneNumber: phoneNumberController.text,
        address: addressController.text,
        password: passwordController.text,
        userType: userTypeController.text);
    try {
      await service.register(registerUserRequest);

      showTopSnackBar(
        // ignore: use_build_context_synchronously
        Overlay.of(context),
        const CustomSnackBar.info(
          message: "Register successfull",
        ),
        dismissType: DismissType.onSwipe,
        dismissDirection: [DismissDirection.endToStart],
      );
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
