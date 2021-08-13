import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownBlog extends StatelessWidget {
  final String? mdName;

  var _fileName;

  MarkdownBlog({this.mdName}) {
    _fileName = this.mdName == null ? 'home' : this.mdName;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 10,
                  decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.color,
                      color: Colors.black87,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                              'assets/images/scroll_bar_upside.png'))),
                  child: Container(),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height * 4 / 5,
                  decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.color,
                      color: Colors.black87,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/scroll_paper.png'))),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                    width: MediaQuery.of(context).size.width / 3,
                    child: ListView(
                      children: [
                        _menuItem("SSSSS", Icon(Icons.ac_unit)),
                        _menuItem("SSSSS", Icon(Icons.ac_unit)),
                        _menuItem("SSSSS", Icon(Icons.ac_unit)),
                        _menuItem("SSSSS", Icon(Icons.ac_unit)),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 10,
                  decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.color,
                      color: Colors.black87,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                              'assets/images/scroll_bar_downside.png'))),
                  child: Container(),
                ),
              ],
            )),
        Container(
            padding: EdgeInsets.all(50.0),
            width: MediaQuery.of(context).size.width / 3 * 2,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.color,
                color: Colors.black87,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image:
                        AssetImage('assets/images/parchment_background.jpg'))),
            child: FutureBuilder(
                future: rootBundle.loadString("md/" + _fileName + ".md"),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  // if (snapshot.hasData) {
                  //   return Markdown(data: snapshot.data ?? '');
                  // }
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.black87),
                    ),
                  );
                })),
      ],
    );
  }

  Widget _menuItem(String title, Icon icon) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(2.0),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(2.0),
                child: icon,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 10.0),
              ),
            ],
          )),
      onTap: () {
        print("onTap called.");
      },
    );
  }
}
