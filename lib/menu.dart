import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:triangle_war/util/function/common_func.dart';
import 'package:triangle_war/util/localization/strings_location.dart';
import 'package:triangle_war/util/sounds.dart';
import 'package:triangle_war/util/widget/animated_background.dart';
import 'package:triangle_war/util/widget/bgm_mute_button.dart';
import 'package:triangle_war/util/widget/dialogs.dart';
import 'package:triangle_war/util/widget/full_screen_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'game_widget.dart';

late double initHeight;
late double initWidth;
late double scalingRate = 1;
late bool fullscreenDisabled;

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    // 1440 x 3120
    if (max(window.physicalSize.width, window.physicalSize.height) <= 3120 ||
        min(window.physicalSize.width, window.physicalSize.height) <= 1440) {
      scalingRate = 0.7;
    } else {
      scalingRate = 1;
    }
    if (BrowserType.safari == getBrowserType()) mute = true;
    if (BrowserType.safari == getBrowserType() && Platform.isIOS)
      fullscreenDisabled = true;
    Sounds.bgmType = BgmType.menu;
    Sounds.initialize();
    Sounds.playBackgroundSound();
    super.initState();
  }

  @override
  void dispose() {
    Sounds.disposeBackgroundSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initHeight = MediaQuery.of(context).size.height;
    initWidth = MediaQuery.of(context).size.width;
    fullscreenDisabled = min(initHeight, initWidth) < 600;
    return Scaffold(
        backgroundColor: Colors.black,
        body: OverflowBox(
          maxHeight: 470 * scalingRate,
          child: Stack(children: [
            AnimatedBackground('images/galaxy.jpg'),
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        getString("game_name"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 70.0 * scalingRate,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 70.0 * scalingRate,
                      ),
                      SizedBox(
                        width: 150 * scalingRate,
                        child: TextButton(
                          child: Text(
                            getString('play_cap'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0 * scalingRate,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainGameWidget()),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0 * scalingRate,
                      ),
                      SizedBox(
                        width: 150 * scalingRate,
                        child: TextButton(
                          child: Text(
                            getString('blog'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0 * scalingRate,
                            ),
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => MarkdownBlog()),
                            // );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0 * scalingRate,
                      ),
                      SizedBox(
                        width: 150 * scalingRate,
                        child: TextButton(
                          child: Text(
                            getString('contact_me'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0 * scalingRate,
                            ),
                          ),
                          onPressed: () {
                            Dialogs.showContactMe(context, () {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: initHeight / 6,
              child: kIsWeb
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BgmMuteButton(),
                        if (!fullscreenDisabled) FullscreenButton(),
                      ],
                    )
                  : SizedBox.shrink(),
            ),
          ]),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 20 * scalingRate,
            margin: EdgeInsets.all(15.0 * scalingRate),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "using: ",
                        style: TextStyle(
                            color: Colors.white, fontSize: 15.0 * scalingRate),
                      ),
                      InkWell(
                        onTap: () {
                          _launchURL('https://github.com/flame-engine/flame');
                        },
                        child: Text(
                          'Flame',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            fontFamily: 'Normal',
                            fontSize: 12.0 * scalingRate,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
