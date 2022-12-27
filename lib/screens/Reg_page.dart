import 'package:chat_app/main.dart';
import 'package:chat_app/screens/dash_Board.dart';
import 'package:chat_app/utils/Validator.dart';
import 'package:chat_app/utils/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class reg_page extends StatefulWidget {


  @override
  Reg_page createState() => Reg_page();
}

class Reg_page extends State<reg_page> {
  final regFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  bool _isProcessing = false;



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.end,
              //mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Column(
                  children: [
                    SizedBox(height: 50),
                    const Text(
                      'Sign Up Page',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 100),
                    Container(
                      width: 250,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Form(
                              key: regFormKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _nameTextController,
                                    validator: (value) =>
                                        validators.validateName(name: value),
                                    decoration: InputDecoration(
                                        hintText: 'Name',
                                        labelText: 'Name*',
                                        errorBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                            ))),
                                  ),
                                  TextFormField(
                                    controller: _emailTextController,
                                    validator: (value) =>
                                        validators.validateEmail(email: value),
                                    decoration: InputDecoration(
                                        labelText: 'Email',
                                        hintText: 'Email*',
                                        errorBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                            ))),
                                  ),
                                  TextFormField(
                                    controller: _phoneTextController,
                                    validator: (value) =>
                                        validators.validatePhone(phone: value),
                                    decoration: InputDecoration(
                                        hintText: 'Phone',
                                        labelText: 'Phone*',
                                        errorBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                            ))),
                                  ),
                                  TextFormField(
                                    controller: _passwordTextController,
                                    validator: (value) => validators
                                        .validatePassword(password: value),
                                    decoration: InputDecoration(
                                        hintText: 'password',
                                        labelText: 'Password *',
                                        errorBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                            ))),
                                  ),
                                  const SizedBox(height: 20),
                                  if (_isProcessing)
                                    const CircularProgressIndicator()
                                  else
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              if(regFormKey.currentState!.validate()){
                                                setState(() {
                                                  _isProcessing = true;
                                                });
                                                User? user = await FireAuth.registerUsingEmailPassword(
                                                    name: _nameTextController.text,
                                                    email: _emailTextController.text,
                                                    password: _passwordTextController.text,
                                                    phone: _phoneTextController.text
                                                );
                                                setState(() {
                                                  _isProcessing=false;
                                                });



                                                if(user!=null){
                                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                      builder:(context)=>reg_page()));

                                                }
                                                showDialog<String>(
                                                  context: context,
                                                  builder: (BuildContext context) => AlertDialog(
                                                    title: const Text('Success!!!'),
                                                    content: const Text('User Created Kid'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () => Navigator.pop(context, 'Cancel'),
                                                        child: const Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () => Navigator.pop(context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }

                                            },
                                            child: const Text('register')),
                                      ],
                                    )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
