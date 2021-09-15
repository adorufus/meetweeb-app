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

  void doSignup() {
    isLoading = true;
    setState(() {});

    ApiUtils.signup(
      username: username.text,
      email: email.text,
      password: password.text,
    ).then((value) {
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0),
        title: const Text("MeetWeeb"),
        centerTitle: true,
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
                                  "Find Your Nearby Weeb Friend",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
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
                                    }
                                  },
                                  child: Text("LOGIN"),
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
