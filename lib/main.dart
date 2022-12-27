import 'package:chat_app/screens/Reg_page.dart';
import 'package:chat_app/screens/dash_Board.dart';
import 'package:chat_app/utils/Validator.dart';
import 'package:chat_app/utils/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chat app',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Chat application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final loginFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isProcessing = false;

  Future<FirebaseApp> _intializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => dash_Board(
                user: user,
              )));
    }
    return firebaseApp;
  }

  @override
 void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text('Chat app'),
        ),
        body: FutureBuilder(
            future: _intializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: Center(
                    // Center is a layout widget. It takes a single child and positions it
                    // in the middle of the parent.
                    child: Column(
                      // Column is also a layout widget. It takes a list of children and
                      // arranges them vertically. By default, it sizes itself to fit its
                      // children horizontally, and tries to be as tall as its parent.
                      //
                      // Invoke "debug painting" (press "p" in the console, choose the
                      // "Toggle Debug Paint" action from the Flutter Inspector in Android
                      // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                      // to see the wireframe for each widget.
                      //
                      // Column has various properties to control how it sizes itself and
                      // how it positions its children. Here we use mainAxisAlignment to
                      // center the children vertically; the main axis here is the vertical
                      // axis because Columns are vertical (the cross axis would be
                      // horizontal).
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Form(
                            key: loginFormKey,
                            child: Column(
                              children: [
                                Container(
                                  height: 500,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Column(
                                    children: [
                                      Column(
                                        children: const [
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              'Login Pge',
                                              style: TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      SizedBox(
                                        width: 300,
                                        child: Card(
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextFormField(
                                                  validator: (value) =>
                                                      validators.validateEmail(
                                                          email: value),
                                                  controller: _emailController,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText: 'E-Mail',
                                                          hintText: 'E-mail*'),
                                                ),
                                                const SizedBox(height: 10),
                                                TextFormField(
                                                  validator: (value) =>
                                                      validators
                                                          .validatePassword(
                                                              password: value),
                                                  controller:
                                                      _passwordController,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText:
                                                              'password'),
                                                ),
                                                TextButton(
                                                    onPressed: () {},
                                                    child: const Text(
                                                        'forgot password ??')),
                                                const SizedBox(height: 10),
                                                if (_isProcessing)
                                                  const CircularProgressIndicator()
                                                else
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context).push(MaterialPageRoute(
                                                              builder:(context) =>reg_page()));
                                                        },
                                                        child: const Text(
                                                            'Register')),
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          if (loginFormKey
                                                              .currentState!
                                                              .validate()) {
                                                            setState(() {
                                                              _isProcessing = true;
                                                            });
                                                            User? user = await FireAuth
                                                                .signInUsingEmailPassword(
                                                                    email:
                                                                        _emailController
                                                                            .text,
                                                                    password:
                                                                        _passwordController
                                                                            .text);
                                                            setState(() {
                                                              _isProcessing = false;
                                                            });
                                                            if (user != null) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacement(
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              dash_Board(user: user)));
                                                            }
                                                          } else {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (builder) =>
                                                                        AlertDialog(
                                                                          title:
                                                                              const Text("not users Kid"),
                                                                          actions: [
                                                                            TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Text("Ok"))
                                                                          ],
                                                                        ));
                                                          }
                                                        },
                                                        child: const Text(
                                                            'Sign In ')),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            })
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
