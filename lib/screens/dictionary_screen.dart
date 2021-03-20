import 'package:flutter/material.dart';
import 'package:flutter_dictionary_sql/sqlite_modal/sqlite_modal.dart';
import 'package:flutter_dictionary_sql/sqlite_modal/word.dart';

class DictionaryScreen extends StatefulWidget {
  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  Future<List<Word>> allWord() async {
    print("start");
    var words = await SqlModal.allWord();
    return await words;
  }

  var controllerEng = TextEditingController();
  var controllerTr = TextEditingController();
  Future<List<Widget>> addInput() async {
    var widget = <Widget>[];

    widget.add(
      Column(
        children: [],
      ),
    );
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              floating: true,
              expandedHeight: 300.0,
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )),
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: FutureBuilder<List<Word>>(
                    future: allWord(),
                    builder: (context, data) {
                      if (data.hasData) {
                        var word = data.data;
                        return ListView.builder(
                          itemCount: word.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5.0),
                                  width: 100.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.black,
                                  ),
                                  child: Text(
                                    word[index].word_eng,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                                Text("="),
                                Container(
                                  margin: EdgeInsets.all(5.0),
                                  width: 100.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.black,
                                  ),
                                  child: Text(
                                    word[index].word_tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      } else {
                        return Text("loading");
                      }
                    },
                  ),
                ),
                centerTitle: true,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextField(
                        controller: index == 0 ? controllerEng : controllerTr,
                        decoration: InputDecoration(
                          hintText: index == 0 ? "English" : "Turkish",
                        ),
                      ),
                    ),
                  ],
                ),
                childCount: 2,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => MaterialButton(
                        onPressed: () async {
                          await SqlModal.addWord(
                              controllerEng.text, controllerTr.text);
                          setState(() {});
                        },
                        child: Text("Add"),
                        color: Colors.red,
                        textColor: Colors.white,
                      ),
                  childCount: 1),
            ),
          ],
        ),
      ),
    );
  }
}
