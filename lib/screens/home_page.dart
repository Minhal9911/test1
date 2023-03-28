import 'package:demo_userlist/screens/user_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<Map<String, String>> users = [];

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String selectedSource = "Select Source";

  final List<String> source = [
    "Facebook",
    "Instagram",
    "Organic",
    "Friend",
    "Google"
  ];

  void _addUser() {
    users.add({
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'source': selectedSource,
    });
    nameController.clear();
    emailController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            nameTextField(),
            const SizedBox(height: 10),
            emailTextField(),
            const SizedBox(height: 10),
            buildDropdownButton(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addUser();
                buildSnackBar();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                minimumSize: const Size(150, 40),
              ),
              child: const Text(
                "Submit",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserList(
                users: users,
              ),
            ),
          );
        },
        child: const Icon(Icons.list),
      ),
    );
  }

  DropdownButtonHideUnderline buildDropdownButton() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: Text(
          selectedSource,
        ),
        alignment: AlignmentDirectional.centerStart,
        borderRadius: BorderRadius.circular(10.0),
        style: const TextStyle(color: Colors.black, fontSize: 20),
        iconEnabledColor: Colors.blue,
        iconSize: 32,
        isExpanded: true,
        itemHeight: 60.0,
        // iconDisabledColor: Colors.grey,
        // focusColor: Colors.brown,
        // autofocus: false,
        // value: selectedSource,
        icon: const Icon(Icons.arrow_drop_down),
        items: source.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedSource = newValue!;
          });
        },
      ),
    );
  }

  void buildSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Success',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,fontSize: 18),
        ),
        duration: const Duration(seconds: 2),
        elevation: 5,
        width: 200.0,
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(style: BorderStyle.none),
        ),
      ),
    );
  }

  TextField nameTextField() {
    return TextField(
      controller: nameController,
      enableSuggestions: true,
      autocorrect: true,
      autofocus: false,
      cursorColor: Colors.blue,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.person_outline,
          color: Colors.blue,
        ),
        labelText: "Name",
        labelStyle: TextStyle(color: Colors.blue.withOpacity(0.9)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.solid),
        ),
      ),
      keyboardType: TextInputType.name,
    );
  }

  TextField emailTextField() {
    return TextField(
      controller: emailController,
      enableSuggestions: true,
      autocorrect: true,
      autofocus: false,
      cursorColor: Colors.blue,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.person_outline,
          color: Colors.blue,
        ),
        labelText: "Email Address",
        labelStyle: TextStyle(color: Colors.blue.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.solid),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
