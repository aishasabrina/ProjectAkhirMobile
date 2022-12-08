import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectbebanpikiran/helper/hive_database_user.dart';
import 'package:projectbebanpikiran/model/data_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final HiveDatabase _hive = HiveDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text("Register Page"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange[300],
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _uname(),
            _pass(),
            _buildRegisterButton()
          ],
        ),
      ),
    );
  }
  Widget _uname(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: _usernameController,
        decoration: const InputDecoration(
            hintText: "Username",
            label: Text('Username'),
            contentPadding: EdgeInsets.all(8.0),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                borderSide: BorderSide(color: Colors.deepPurple, width: 2)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                borderSide: BorderSide(color: Colors.deepOrangeAccent,)
            )
        ),
        validator: (String? value) {
          if (value!.trim().isEmpty) {
            return 'Username is required';
          }
        },
      ),
    );
  }
  Widget _pass(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: _passwordController,
        decoration: const InputDecoration(
            hintText: "Password",
            label: Text('Password'),
            contentPadding: EdgeInsets.all(8.0),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                borderSide: BorderSide(color: Colors.deepPurple, width: 2)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                borderSide: BorderSide(color: Colors.deepOrangeAccent,)
            )
        ),
        obscureText: true,
          validator: (String? value) {
            if (value!.trim().isEmpty) {
              return 'Password is required';
            }
          },
        enabled: true,
      ),
    );
  }
  Widget _commonSubmitButton({
    required String labelButton,
    required Function(String) submitCallback,
  }){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: 200,
      child: ElevatedButton(
        child: Text(labelButton, style: TextStyle(fontSize: 15),),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15),
          primary: Colors.deepPurple[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
        onPressed: () {
          submitCallback(labelButton);
        },
      ),
    );
  }

  Widget _buildRegisterButton() {
    return _commonSubmitButton(
      labelButton: "Register",
      submitCallback: (value) {
        if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
          _hive.addData(
              DataModel(
                  username: _usernameController.text,
                  password: _passwordController.text
              )
          );
          _usernameController.clear();
          _passwordController.clear();
          setState(() {});

          Navigator.pop(context);
        }
      },
    );
  }
}