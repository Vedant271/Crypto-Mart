import 'package:crypto_mart/net/flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:crypto_mart/net/flutterfire.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xff2b2b2b),
                Color(0xffc66901),
                Color(0xffdea01c),
              ],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white38),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
                  SizedBox(height: 30,),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person,color: Colors.white70,),
                        //hintText: "Enter e-mail",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        label: Text(
                          "E - mail",
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white70),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _passwordcontroller,
                      obscureText: isHiddenPassword,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock,color: Colors.white70,),
                          //hintText: "Enter password",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Password",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white70),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          suffixIcon: InkWell(
                            onTap: _togglepswdfield,
                            child: Icon(
                              isHiddenPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: 45,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Color(0xff2b2b2b),
                      elevation: 20,
                      onPressed: () async {
                        bool shouldnavigate = await SignInUser(
                            _emailcontroller.text, _passwordcontroller.text);
                        if (shouldnavigate) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
  void _togglepswdfield() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}


/*class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xff2b2b2b),
                Color(0xffc66901),
                Color(0xffdea01c),
              ],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white38),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Login"),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person,color: Colors.white70,),
                        //hintText: "Enter e-mail",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        label: Text(
                          "E - mail",
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white70),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _passwordcontroller,
                      obscureText: isHiddenPassword,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock,color: Colors.white70,),
                          //hintText: "Enter password",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Password",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white70),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          suffixIcon: InkWell(
                            onTap: _togglepswdfield,
                            child: Icon(
                              isHiddenPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: 45,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Color(0xff2b2b2b),
                      elevation: 20,
                      onPressed: () async {
                        bool shouldnavigate = await SignInUser(
                            _emailcontroller.text, _passwordcontroller.text);
                        if (shouldnavigate) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  void _togglepswdfield() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}*/
