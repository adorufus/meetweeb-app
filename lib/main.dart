import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meetweeb_app/utils/api.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(backgroundColor: Color(0xffF39189)),
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isRegister = false;
  bool isLoading = false;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void doLogin() {
    isLoading = true;
    setState(() {});

    ApiUtils.login(username: username.text, password: password.text)
        .then((value) {
      print(value.body);
      isLoading = false;
      setState(() {});
    });
  }

  void doSignup() {
    isLoading = true;
    setState(() {});

    ApiUtils.signup(
      username: username.text,
      email: email.text,
      password: password.text,
    ).then((value) {
      isLoading = false;
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.white,
          child: Container(
            height: 100,
            width: 200,
            child: Center(
              child: Text(
                "Registration Successful",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black45),
              ),
            ),
          ),
        ),
      );
      setState(() {});
      Future.delayed(Duration(milliseconds: 2000), () {
        Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0),
        title: const Text("MeetWeeb"),
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg2.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  height: 500,
                  width: 900,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(30),
                          color: const Color(0xffCAB8FF).withOpacity(.9),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Find Weeb Community Circle Nearby",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(50),
                          color: Colors.white.withOpacity(.9),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Welcome",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Join with million of weeb online",
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                                SizedBox(
                                  height: 13,
                                ),
                                form(
                                  label: "Username",
                                  controller: username,
                                  hint: "E.g john doe",
                                ),
                                SizedBox(
                                  height: 13,
                                ),
                                isRegister
                                    ? form(
                                        label: "Email",
                                        controller: email,
                                        hint: "E.g johndoe@example.com")
                                    : Container(),
                                SizedBox(
                                  height: 13,
                                ),
                                form(
                                    label: "Password",
                                    hint: "",
                                    isPassword: true,
                                    controller: password),
                                ElevatedButton(
                                  onPressed: () {
                                    if (isRegister) {
                                      doSignup();
                                    } else {
                                      doLogin();
                                    }
                                  },
                                  child: Text(
                                    isRegister ? "REGISTER" : "LOGIN",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  style: ButtonStyle(
                                      fixedSize:
                                          MaterialStateProperty.resolveWith(
                                        (states) => Size(
                                          MediaQuery.of(context).size.width,
                                          50,
                                        ),
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) => Color(0xffCAB8FF))),
                                ),
                                SizedBox(
                                  height: 13,
                                ),
                                Text("OR"),
                                TextButton(
                                    onPressed: () {
                                      isRegister = !isRegister;
                                      setState(() {});
                                    },
                                    child: Text(isRegister
                                        ? "Login Instead"
                                        : "Signup Instead"))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          isLoading == false
              ? Container()
              : Center(
                  child: CircularProgressIndicator(),
                )
        ],
      ),
    );
  }

  Widget form(
      {bool isPassword = false,
      String? label,
      String? hint,
      TextEditingController? controller}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        filled: true,
        fillColor: Colors.grey[300],
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        labelText: label,
        helperText: hint,
      ),
    );
  }
}
