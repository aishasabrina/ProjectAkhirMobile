import 'package:flutter/material.dart';
import 'package:projectbebanpikiran/helper/shared_preference.dart';
import 'package:projectbebanpikiran/list_menu.dart';
import 'package:projectbebanpikiran/view/homepage.dart';
import 'base_network.dart';
import 'package:projectbebanpikiran/model_data/detail_drink.dart';
import 'package:projectbebanpikiran/view/beranda.dart';

class RandomPage extends StatefulWidget {

  const RandomPage({Key? key,}) : super(key: key);

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (isFavorite) ? Colors.deepPurple[100] : Colors.deepPurple[50],
      appBar: AppBar(
        title: Text("Random Drinks!"),
        backgroundColor: Colors.deepOrange[300],
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
            },
            icon: Icon(Icons.home),
            tooltip: 'Home',
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              FutureBuilder(
                future: BaseNetwork.get('random.php'),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    // debugPrint(snapshot.data);
                    return _buildErrorSection();
                  }
                  if (snapshot.hasData) {
                    final DetailDrink detail =
                    DetailDrink.fromJson(snapshot.data);
                    print(detail);
                    return _buildSuccessSection(detail);
                  }
                  return _buildLoadingSection();
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildSuccessSection(DetailDrink detail) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            // offset: Offset(0.0, 5.0),
                            blurRadius: 10.0,
                            spreadRadius: -6.0
                        ),
                      ],
                      image: DecorationImage(
                          // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.35), BlendMode.multiply),
                          image: NetworkImage("${detail.drinks?[0].strDrinkThumb}"),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Text(''),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Text(
            "${detail.drinks?[0].strDrink}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          // tags => Container, row --> alcohol + category
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _alcohol(detail),
                SizedBox(width: 5,),
                _category(detail),
              ],
            ),
          ),
          SizedBox(height: 10,),
          _instruction(detail),
        ],
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _alcohol(DetailDrink detail){
    return ElevatedButton(
        onPressed: (){},
        child: Text("${detail.drinks?[0].strAlcoholic}"),
        style: ElevatedButton.styleFrom(
          primary: Colors.deepOrangeAccent[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          padding: EdgeInsets.all(10)
        )
    );
  }

  Widget _category(DetailDrink detail){
    return ElevatedButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListMenu(
                      kategori: detail.drinks?[0].strCategory,
                  )));
        },
        child: Text("${detail.drinks?[0].strCategory}"),
        style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            padding: EdgeInsets.all(10)
        )
    );
  }

  Widget _glass(DetailDrink detail){
    return Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text("${detail.drinks?[0].strGlass}")
        ),
        color: Colors.deepPurple[50],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
    );
  }

  Widget _instruction(DetailDrink detail){
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(
            color: Colors.deepPurple,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Recipe",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20,),
                _glass(detail),
                SizedBox(height: 20,),
                const Text(
                  "Ingredients",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                ),
                Text(
                  "${detail.drinks?[0].strMeasure1} ${detail.drinks?[0].strIngredient1}",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${detail.drinks?[0].strMeasure2} ${detail.drinks?[0].strIngredient2}",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${detail.drinks?[0].strMeasure3} ${detail.drinks?[0].strIngredient3}",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${detail.drinks?[0].strMeasure4} ${detail.drinks?[0].strIngredient4}",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10,),
                const Text(
                  "Instruction",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                ),
                Text(
                  "${detail.drinks?[0].strInstructions}",
                  textAlign: TextAlign.center,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


