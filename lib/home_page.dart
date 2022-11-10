import 'package:flutter/material.dart';
import 'package:tic_tac_toe/custom_dialogue.dart';

import 'game_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<GameButton> buttonList;
  var playerOne;
  var playerTwo;
  var activePlayer;

  @override
  void initState() {
    super.initState();
    buttonList = doInit();
  }

  List<GameButton> doInit() {
    playerOne = [];
    playerTwo = [];

    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = 'X';
        gb.bg = Colors.blue;
        activePlayer = 2;
        playerOne.add(gb.id);
      } else {
        gb.text = 'O';
        gb.bg = Colors.redAccent;
        activePlayer = 1;
        playerTwo.add(gb.id);
      }
      gb.enabled = false;
      var winner = checkWinner();

      if (winner == -1) {
        if (buttonList.every((p) => p.text != '')) {
          showDialog(
            context: context,
            builder: (_) => CustomDialogue(
              'Game Tied',
              'Please press the reset button to start',
              resetGame,
            ),
          );
        }
      }
    });
  }

  int checkWinner() {
    var winner = -1;
    // Row 1
    if (playerOne.contains(1) &&
        playerOne.contains(2) &&
        playerOne.contains(3)) {
      winner = 1;
    }
    if (playerTwo.contains(1) &&
        playerTwo.contains(2) &&
        playerTwo.contains(3)) {
      winner = 2;
    }
    // Row 2

    if (playerOne.contains(4) &&
        playerOne.contains(5) &&
        playerOne.contains(6)) {
      winner = 1;
    }
    if (playerTwo.contains(4) &&
        playerTwo.contains(5) &&
        playerTwo.contains(6)) {
      winner = 2;
    }
    // Row 3
    if (playerOne.contains(7) &&
        playerOne.contains(8) &&
        playerOne.contains(9)) {
      winner = 1;
    }
    if (playerTwo.contains(7) &&
        playerTwo.contains(8) &&
        playerTwo.contains(9)) {
      winner = 2;
    }
    // Col 1
    if (playerOne.contains(1) &&
        playerOne.contains(4) &&
        playerOne.contains(7)) {
      winner = 1;
    }
    if (playerTwo.contains(1) &&
        playerTwo.contains(4) &&
        playerTwo.contains(7)) {
      winner = 2;
    }
    // Col 2
    if (playerOne.contains(2) &&
        playerOne.contains(5) &&
        playerOne.contains(8)) {
      winner = 1;
    }
    if (playerTwo.contains(2) &&
        playerTwo.contains(5) &&
        playerTwo.contains(8)) {
      winner = 2;
    }
    // Col 3
    if (playerOne.contains(3) &&
        playerOne.contains(6) &&
        playerOne.contains(9)) {
      winner = 1;
    }
    if (playerTwo.contains(2) &&
        playerTwo.contains(5) &&
        playerTwo.contains(9)) {
      winner = 2;
    }
    // Dia 1
    if (playerOne.contains(1) &&
        playerOne.contains(5) &&
        playerOne.contains(9)) {
      winner = 1;
    }
    if (playerTwo.contains(1) &&
        playerTwo.contains(5) &&
        playerTwo.contains(9)) {
      winner = 2;
    }
    // Dia 2
    if (playerOne.contains(3) &&
        playerOne.contains(5) &&
        playerOne.contains(7)) {
      winner = 1;
    }
    if (playerTwo.contains(3) &&
        playerTwo.contains(5) &&
        playerTwo.contains(7)) {
      winner = 2;
    }
    if (winner != -1) {
      if (winner == 1) {
        showDialog(
          context: context,
          builder: (_) => CustomDialogue(
            'Player one wins',
            'Please press the reset button to start',
            resetGame,
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => CustomDialogue(
            'Player two wins',
            'Please press the reset button to start',
            resetGame,
          ),
        );
      }
    }
    return winner;
  }

  void resetGame() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(),
      ),
    );
    setState(() {
      buttonList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Tic Tac Toe',
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: 400,
              height: 360,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 9.0),
                itemCount: buttonList.length,
                itemBuilder: (context, index) => SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      onPressed: buttonList[index].enabled
                          ? () => playGame(buttonList[index])
                          : null,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: buttonList[index].bg,
                          disabledBackgroundColor: buttonList[index].bg),
                      child: Text(
                        buttonList[index].text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              onPressed: resetGame,
              child: Text('Reset'),
            ),
          ),
        ],
      ),
    );
  }
}
