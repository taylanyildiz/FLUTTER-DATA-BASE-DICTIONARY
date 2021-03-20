import 'package:flutter/material.dart';
import 'package:flutter_dictionary_sql/provider/provider_user.dart';
import 'screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  Future<bool> isLog() async {
    var sp = await SharedPreferences.getInstance();
    bool check = sp.getBool("page");
    return check;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<bool>(
          future: isLog(),
          builder: (context, data) {
            if (data.hasData) {
              if (data.data == true) {
                return DictionaryScreen();
              } else {
                return HomeScreen();
              }
            } else {
              return Container(
                color: Colors.red,
              );
            }
          },
        ),
      ),
    );
  }
}
