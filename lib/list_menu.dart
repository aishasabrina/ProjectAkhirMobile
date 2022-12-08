import 'package:flutter/foundation.dart';
import 'package:projectbebanpikiran/LoginRegisterPage/login_page.dart';
import 'package:projectbebanpikiran/base_network.dart';
import 'package:projectbebanpikiran/model_data/category_drink.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectbebanpikiran/view/beranda.dart';
import 'package:projectbebanpikiran/view/homepage.dart';
import 'detail_page.dart';
import 'helper/shared_preference.dart';

class ListMenu extends StatefulWidget {
  final String? kategori;
  const ListMenu({Key? key, required this.kategori}) : super(key: key);
  @override
  _ListMenuState createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Text("${widget.kategori}"),
        centerTitle: true,
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
      body: _buildDetailDessertBody(),
    );

  }

  Widget _buildDetailDessertBody() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: BaseNetwork.get('filter.php?c=${widget.kategori}'),
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.hasError) {
            print(snapshot);
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
           CategoryDrink drinks =
            CategoryDrink.fromJson(snapshot.data);
            print(drinks);
            return _buildSuccessSection(drinks);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildEmptySection() {
    return Text("Empty");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }


  Widget _buildSuccessSection(CategoryDrink detail) {
    return GridView.builder(
      itemCount: detail.drinks?.length,
      itemBuilder: (BuildContext context, int index) {
        final Drinks? drinks = detail.drinks?[index];
        return Card(
          color: Colors.deepPurple[50],
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(
                          idDrink: drinks?.idDrink,
                          strDrink: drinks?.strDrink
                      )));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  width: 175,
                  height: 175,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: Offset(0.0, 5.0),
                            blurRadius: 10.0,
                            spreadRadius: -6.0
                        ),
                      ],
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.multiply),
                          image: NetworkImage("${detail.drinks?[index].strDrinkThumb}"),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 70,
                              width: 120,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(

                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${detail.drinks?[index].strDrink}", style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],),

                      )
                    ],
                  ),
                )],
              ),
        )
        );}, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
    ),
    );
  }
}
