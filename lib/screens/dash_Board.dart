import 'package:chat_app/main.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/screens/Reg_page.dart';
import 'package:chat_app/screens/newDashBoard.dart';
import 'package:chat_app/services/api_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dash_Board extends StatefulWidget {
  final User user;

  const dash_Board({required this.user});

  @override
  Dash_Board createState() => Dash_Board();
}

class Dash_Board extends State<dash_Board> {


//List <Data> result =[];
  List<Result> result = [];
late User _currentUser;
  bool _isSigningOut = false;

@override
void initState() {
  _currentUser = widget.user;
  super.initState();
  getData();
}


void getData() async {
  Data _data = (await ApiServices.getApi())!;
 // print('data: ${data}');
  result =_data.result;
  print('result: ${result}');
  Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  "Company Info",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
            ListTile(
              title: RichText(
                text: const TextSpan(
                  text: 'Company :',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Geeksynergy Technologies Pvt Ltd',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: RichText(
                text: const TextSpan(
                  text: 'Address :',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Sanjayanagar, Bengaluru-56',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: RichText(
                text: const TextSpan(
                  text: 'Phone:',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'XXXXXXXXX09',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: RichText(
                text: const TextSpan(
                  text: 'E-Mail:',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'XXXXXX@gmail.com',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Movies'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
              onPressed: () async {
                setState(() {
                  _isSigningOut = true;
                });
                await FirebaseAuth.instance.signOut();
                setState(() {
                  _isSigningOut = false;
                });
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => reg_page(),
                  ),
                );
              })
        ],
      ),
      body: result == null || result!.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Scrollbar(
        isAlwaysShown: true,
        child: ListView.builder(
          itemCount: result!.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 140,
                        width: 70,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(5),
                          child: Column(
                            children: [
                              const Icon(Icons.arrow_drop_up, size: 50),
                              Text(result![index].voting.toString()),
                              const Icon(Icons.arrow_drop_down, size: 45),
                              const Text("Votes"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 140,
                        width: 80,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 5,
                          margin: const EdgeInsets.all(5),
                          child: Image.network(
                              result[index].poster.toString(),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(result![index].title.toString(),
                                  style: const TextStyle(fontSize: 25)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  'Genre:${result![index].genre.toString()}'),
                              Text(
                                  'Director:${result![index].director.first.toString()}'),
                              Text(
                                  'Writter :${result![index].writers.first.toString()}'),
                              Row(
                                children: [
                                  Text(result![index].runTime.toString()),
                                  const Text("|"),
                                  Text(result![index].language.toString()),
                                  const Text("|"),
                                  Text(result[index]
                                      .releasedDate
                                      .toString()),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                      '${result![index].pageViews.toString()} Views'),
                                  const Text("||"),
                                  Text(
                                      'Voted By ${result[index].voting}people'),
                                ],
                              ),
                            ],
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [


                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                            height: 35,
                            width: 330,
                            child: ElevatedButton(
                              onPressed: () {

                              },
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.blue,
                                // minimumSize: const Size.fromHeight(20),// Background Color
                              ),
                              child: const Text("Watch Trailor",
                                  style: TextStyle(fontSize: 15)),
                            )),
                      ),

                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
