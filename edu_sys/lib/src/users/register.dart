import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    const List<String> userType = <String>['Center', 'Teacher', 'Normal User'];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Register Page ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
              height: 10,
            ),
          const TextField(
            decoration:
                InputDecoration(hintText: "Username", icon: Icon(Icons.person)),
          ),
          const SizedBox(
              height: 10,
            ),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Password",
                icon: Icon(
                  Icons.lock,
                  color: Colors.black,
                )),
          ),
          const SizedBox(
              height: 10,
            ),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Confrim Password",
                icon: Icon(
                  Icons.lock,
                  color: Colors.black,
                )),
          ),
          const SizedBox(
              height: 10,
            ),
          const TextField(
            decoration: InputDecoration(
                hintText: "FullName",
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                )),
          ),
          const SizedBox(
              height: 10,
            ),
          const TextField(
            decoration:  InputDecoration(
                hintText: "Address",
                icon: Icon(
                  Icons.add_location_outlined,
                  color: Colors.black,
                )),
          ),
          const SizedBox(
              height: 10,
            ),
          DropdownMenu<String>(
            width: size.width- 60,
            initialSelection: userType.first,
            onSelected: (String? value) {
              // This is called when the user selects an item.
              setState(() {
              });
            },
            dropdownMenuEntries:
                userType.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          )
        ],
      ),
    );
  }
}
