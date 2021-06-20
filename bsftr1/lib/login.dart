import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

/* Landing page
  - Authentication Check
 */

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class FirebaseSignInWidget extends StatelessWidget {
  FirebaseSignInWidget({required this.appBuilder});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'RIOT Sign In', home: _getLandingPage());
  }

  final AsyncWidgetBuilder<User?> appBuilder;

  Widget _getLandingPage() {
    return StreamBuilder<User?>(
      stream: firebaseAuth.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return appBuilder(context, snapshot);
        } else {
          return FbLoginPage();
        }
      },
    );
  }
}

IconButton loginButton(BuildContext context) => IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FbLoginPage()),
        );
      },
      icon: Icon(Icons.account_circle),
    );

/*
Firestore認証Widget
*/
class FbLoginPage extends StatefulWidget {
  @override
  _FbLoginPageState createState() => _FbLoginPageState();
}

class _FbLoginPageState extends State<FbLoginPage> {
  String loginUserEmail = "";
  String loginUserPassword = "";
  String debugMsg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 450,
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              Container(height: 32),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Login ID ", hintText: "Mail Address"),
                onChanged: (String value) =>
                    setState(() => loginUserEmail = value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                onChanged: (String value) =>
                    setState(() => loginUserPassword = value),
              ),
              Container(height: 32),
              Row(
                children: [
                  ElevatedButton(
                    child: Text("Sign in"),
                    onPressed: () =>
                        loginAsUser(loginUserEmail, loginUserPassword),
                    onLongPress: () =>
                        loginAsUser("kyoya.p4@gmail.com", "kyoyap4"),
                  ),
                ],
              ),
              Text(debugMsg),
            ],
          ),
        ),
      ),
    );
  }

  loginAsUser(String mailAddr, String password) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
          email: mailAddr, password: password);
/*      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => FirebaseSignInWidget(
            appBuilder: (context, snapshot) => RiotApp(snapshot.data),
          ),
        ),
      );
 */
    } catch (e) {
      setState(() {
        debugMsg = "Failed: $e\n login: $mailAddr";
        print(debugMsg);
      });
    }
  }
}
