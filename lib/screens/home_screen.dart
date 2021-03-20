import 'package:flutter/material.dart';
import 'package:flutter_dictionary_sql/provider/provider_user.dart';
import 'package:flutter_dictionary_sql/screens/dictionary_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controllerPass;
  var controllerName;
  var visibilityPass = true;

  Future<void> logSp() async {
    var sp = await SharedPreferences.getInstance();
    sp.setString("name", "Taylan");
    sp.setString("pass", "123");
    print(sp.getString("name"));
  }

  Future<void> registerSp() async {
    var sp = await SharedPreferences.getInstance();
    if (controllerPass.text.isEmpty || controllerName.text.isEmpty) {
      print("Please fill in the fields");
    } else {
      String name = sp.getString("name") ?? "empty";
      String pass = sp.getString("pass") ?? "empty";
      if (name == controllerName.text.trim() &&
          pass == controllerPass.text.trim()) {
        sp.setBool("page", true);
        print("Login successful");
        Future.delayed(
            Duration(seconds: 1),
            () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DictionaryScreen())));
      } else {
        print("error!! please try again");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controllerName = TextEditingController();
    controllerPass = TextEditingController();
    logSp();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: Colors.white,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * .9,
                        child: TextField(
                          controller: controllerName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "Name",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 20,
                      ),
                      SizedBox(
                        width: width * .9,
                        child: TextField(
                          obscureText: context.watch<UserProvider>().Visibility,
                          controller: controllerPass,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Password",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  visibilityPass = !visibilityPass;
                                  context
                                      .read<UserProvider>()
                                      .setVisibility(visibilityPass);
                                },
                                icon: Icon(
                                  Icons.visibility,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * .6,
                  child: MaterialButton(
                    onPressed: registerSp,
                    child: Text("Contiune"),
                    color: Colors.blue,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
