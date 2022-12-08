import 'package:flutter/material.dart';
import 'package:projectbebanpikiran/LoginRegisterPage/login_page.dart';
import 'package:projectbebanpikiran/helper/shared_preference.dart';
import 'package:projectbebanpikiran/list_menu.dart';
import 'package:projectbebanpikiran/view/homepage.dart';
import 'package:projectbebanpikiran/view/profile.dart';
import 'package:projectbebanpikiran/model_data/detail_drink.dart';


class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  final List Category = [
    "Ordinary Drink",
    "Cocktail",
    "Shake",
    "Cocoa",
    "Shot",
    "Beer",
    "Soft Drink",
    "Coffee / Tea",
    "Punch/Party Drink"
  ];
  final List kategori = [
    "Ordinary_Drink",
    "Cocktail",
    "Shake",
    "Cocoa",
    "Shot",
    "Beer",
    "Soft_Drink",
    "Coffee_/_Tea",
    "Punch/Party Drink"
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Center(child: FutureBuilder(
          future: SharedPreference().getUsername(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return Text("Hai, ${snapshot.data}", style: TextStyle(fontSize: 24),);
          },
        )),
        backgroundColor: Colors.deepOrange[300],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(30,50,30,30),
          child: Container(
              height:MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Text("What are you looking for?", style: TextStyle(fontSize: 24),),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        ),
                        shrinkWrap: true,
                        itemCount: kategori.length,
                        itemBuilder: (BuildContext context, index) {
                          return SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90)
                              ),
                              color: Colors.deepPurple[200],
                              elevation: 10,
                              shadowColor: Colors.deepPurple,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ListMenu(kategori: kategori[index])));
                                },
                                child:
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text (Category[index],
                                            style: const TextStyle(fontSize: 17),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                ],
              ),

          ),
        ),
      ),

    );
  }
}