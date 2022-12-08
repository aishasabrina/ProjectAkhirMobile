import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectbebanpikiran/helper/hive_database_user.dart';
import 'package:projectbebanpikiran/helper/shared_preference.dart';
import 'package:projectbebanpikiran/model/data_model.dart';
import 'package:projectbebanpikiran/list_menu.dart';
import 'package:projectbebanpikiran/view/beranda.dart';
import 'package:projectbebanpikiran/LoginRegisterPage/register_page.dart';
import 'package:projectbebanpikiran/view/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if(form != null){
      if (form.validate()) {
        print('Form is valid');
      } else {
        print('Form is invalid');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange[100],
      body: SafeArea(
        child: Stack(
          key: _formKey,
          children: [

            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Logo
                  Container(
                    child: Image(image: AssetImage("assets/DrinkTale.png")), width: 350, height: 350,
                  ),

                  _uname(),
                  _pass(),
                  _buildLoginButton(),
                  SizedBox(height: 10,),
                  Text('Belum Punya Akun?'),
                  _buildRegisterButton(),
                ],
              ),
            ),
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
        validator: (value) => value!.isEmpty ? 'Username tidak boleh kosong':null,
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
        validator: (value) => value!.isEmpty ? 'Password tidak boleh kosong' : null,

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
      // MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        child: Text(labelButton, style: TextStyle(fontSize: 15),),
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurple[300],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
            padding: EdgeInsets.all(15),
        ),
        onPressed: () {
          submitCallback(labelButton);
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return _commonSubmitButton(
      labelButton: "Login",
      submitCallback: (value) {
        validateAndSave();
        String currentUsername = _usernameController.value.text;
        String currentPassword = _passwordController.value.text;

        _processLogin(currentUsername, currentPassword);
      },
    );
  }

  void _processLogin(String username, String password) async {
    final HiveDatabase _hive = HiveDatabase();
    bool found = false;
    String teks = "";
    found = _hive.checkLogin(username, password);

    if(!found) {
      print("Login Failed");
      teks = "Login Gagal";
    }
    else{
      teks = "Login Sukses";
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
    SnackBar snackBar = SnackBar(content: Text(teks));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildRegisterButton() {
    return _commonSubmitButton(
      labelButton: "Register",
      submitCallback: (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RegisterPage(),
          ),
        );
      },
    );
  }
}