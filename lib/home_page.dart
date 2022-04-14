import 'dart:async';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  static int squares_in_row = 20;
  static int number_of_squares = squares_in_row * 37;
  bool game_started = false;
  bool button_clicked = false;
  int score = 0;

  // var snake = 14;
  List snake_positions = [45, 65, 85, 105, 125];
  var snake_direction = 'down';
  int food = 450;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 20,
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    if (details.delta.dy < 0) {
                      snake_direction = 'up';
                    } else if (details.delta.dy > 0) {
                      snake_direction = 'down';
                    }
                  },
                  onHorizontalDragUpdate: (details) {
                    if (details.delta.dx < 0) {
                      snake_direction = 'left';
                    } else if (details.delta.dx > 0) {
                      snake_direction = 'right';
                    }
                  },
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: number_of_squares,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: squares_in_row),
                      itemBuilder: (BuildContext context, int index) {
                        if (snake_positions.contains(index)) {
                          return Padding(
                            padding: EdgeInsets.all(1),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          );
                        }
                        if (food == index) {
                          return Padding(
                            padding: EdgeInsets.all(1),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.all(1),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          );
                        }
                      }),
                )),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          print('clicked39485793845938457!');
                          if (!button_clicked) {
                            start_game();
                          }
                        });
                      },
                      child: Text(
                        'PLAY',
                        style: TextStyle(
                            color: button_clicked ? Colors.grey : Colors.white,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                            fontSize: 30),
                      ),
                    ),
                    Text(
                      'score: $score',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        fontSize: 30,
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void snake_movement() {
    // snake_positions.first += squares_in_row;
    setState(() {
      if (snake_direction == 'right') {
        snake_positions.add(snake_positions.last + 1);
      } else if (snake_direction == 'left') {
        snake_positions.add(snake_positions.last - 1);
      } else if (snake_direction == 'up') {
        snake_positions.add(snake_positions.last - squares_in_row);
      } else if (snake_direction == 'down') {
        snake_positions.add(snake_positions.last + squares_in_row);
      }
      if (snake_positions.last > number_of_squares) {
        snake_positions.last = snake_positions.last - number_of_squares;
      }
      if (snake_positions.last < 0) {
        snake_positions.last = number_of_squares - (snake_positions.last * -1);
      }

      if (snake_positions.last == food) {
        score++;
        create_new_food();
      } else {
        snake_positions.removeAt(0);
      }
    });

    for (var part in snake_positions) {
      if (part == part) {
        print('object');
      }
    }
    // snake_positions.add
    // if (snake_direction == 'left') {

    // }
    // if (snake_direction == 'up') {

    // }
    // if (snake_direction == 'down') {

    // }
  }

  void start_game() {
    button_clicked = true;
    Timer.periodic(Duration(milliseconds: 300), (timer) {
      snake_movement();
    });
  }

  void create_new_food() {
    print(snake_positions);
    setState(() {
      food = Random().nextInt(number_of_squares);
    });
  }
}
