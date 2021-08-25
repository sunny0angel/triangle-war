import 'dart:math';
import 'dart:ui';

import 'package:triangle_war/game.dart';
import 'package:triangle_war/util/function/common_func.dart';
import 'package:triangle_war/util/particle/blob_sample.dart';
import 'package:triangle_war/util/widget/bgm_mute_button.dart';
import 'package:triangle_war/util/widget/full_screen_button.dart';
import 'package:flame/src/game/game_widget/game_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:triangle_war/menu.dart';

import '../menu.dart';
import '../util/widget/dialogs.dart';
import '../util/sounds.dart';

class MainGameWidget extends StatefulWidget {
  const MainGameWidget({Key? key}) : super(key: key);

  @override
  _MainGameWidgetState createState() => _MainGameWidgetState();
}

class _MainGameWidgetState extends State<MainGameWidget> with WidgetsBindingObserver {
  bool showGameOver = false;

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    print('changed size');
  }

  @override
  void initState() {
    if (BrowserType.safari == getBrowserType()) mute = true;
    // sound assets preload
    Sounds.bgmType = BgmType.game;
    Sounds.initialize();
    Sounds.playBackgroundSound();
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        Sounds.resumeBackgroundSound();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        Sounds.pauseBackgroundSound();
        break;
      case AppLifecycleState.detached:
        Sounds.stopBackgroundSound();
        break;
    }
  }

  @override
  void dispose() {
    Sounds.disposeBackgroundSound();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initHeight = MediaQuery.of(context).size.height;
    initWidth = MediaQuery.of(context).size.width;
    fullscreenDisabled = min(initHeight, initWidth) < 600;
    return Scaffold(
        backgroundColor: Colors.black87,
        body: Stack(children: [
          Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.blueAccent.shade700, width: 1.0),
              ),
              child: GameWidget(game: Game())),
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
        ]));
  }

  @override
  void changeCountLiveEnemies(int count) {
    if (count < 2) {
      // _addEnemyInWorld();
    }
  }

  // void _addEnemyInWorld() {
  //   _controller.addGameComponent();
  //
  //   _controller.addGameComponent();
  // }

  void _showDialogGameOver() {
    setState(() {
      showGameOver = true;
    });
    Dialogs.showGameOver(
      context,
      () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainGameWidget()),
            (Route<dynamic> route) => false);
      },
      () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Menu()),
            (Route<dynamic> route) => false);
      },
    );
  }

  void _showDialogPauseMenu() {
    Dialogs.showGamePauseMenu(
      context,
      () {
        // _controller.gameRef.resumeEngine();
        showGameOver = false;
        Navigator.pop(context);
      },
      () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Menu()),
            (Route<dynamic> route) => false);
      },
    );
  }

  @override
  void updateGame() {
    // if (_controller.player != null && _controller.player!.isDead) {
    //   if (!showGameOver) {
    //     showGameOver = true;
        _showDialogGameOver();
    //   }
    // }
    // if (_controller.player != null) {
    //   if ((_controller.player as Knight).showPauseMenu) {
    //     (_controller.player as Knight).setShowPauseMenu(false);
    //     _controller.gameRef.pauseEngine();
        _showDialogPauseMenu();
    //   } else if ((_controller.player as Knight).showPlayerState) {
    //     (_controller.player as Knight).setShowPlayerState(false);
    //     Dialogs.showPlayerState(context);
    //   } else if ((_controller.player as Knight).showItem) {
    //     (_controller.player as Knight).setShowItem(false);
    //     Dialogs.showItems(context);
    //   }
    // }
  }
}
