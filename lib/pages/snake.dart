//susi was here
//
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class SnakeGame extends StatefulWidget{
  const SnakeGame({Key key}) : super(key: key);

  @override
  SnakeState createState()=> SnakeState();

}

class SnakeState extends State<SnakeGame>{
  final int row=20;
  final int coll=40;
  final randomGen=Random();
  var snake = [[0,1],[0,0]];
  var food = [0,2];
  var direction = "up";
  var playing = false;



  void startGame(){

    const duration = Duration(milliseconds: 300);

    snake =[
      [(row/2).floor(),(coll/2).floor()]
    ];

    snake.add([snake.first[0],snake.first[1]-1]);
    createFood();
    playing = true;
    Timer.periodic(duration, (Timer timer){
      moveSnake();
      if(checkGameOver()){
        timer.cancel();
        endGame();
      }
    });

  }

  void moveSnake(){
    setState(() {
      switch(direction){
        case 'up':
          snake.insert(0, [snake.first[0],snake.first[1]-1]);
          break;
        case 'down':
          snake.insert(0, [snake.first[0],snake.first[1]+1]);
          break;
        case 'left':
          snake.insert(0, [snake.first[0]-1,snake.first[1]]);
          break;
        case 'right':
          snake.insert(0, [snake.first[0]+1,snake.first[1]]);
          break;
      }

      if(snake.first[0]!=food[0]|| snake.first[1]!=food[1]){
        snake.removeLast();
      }else{

        createFood();
      }
    });


  }

  void createFood(){
    food =[
      randomGen.nextInt(row),
      randomGen.nextInt(coll)
    ];
  }

  bool checkGameOver(){
    if(!playing
        ||snake.first[1]<0
        ||snake.first[1]>=coll
        ||snake.first[0]<0
        ||snake.first[0]> row){
      return true;

    }

    for(var i=1;i<snake.length;i++){
      if(snake[i][0]==snake.first[0] && snake[i][1] == snake.first[1]){
        return true;
      }
    }

    return false;
  }

  void endGame(){
    playing=false;
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Game Over'),
        content: Text('Score: ${snake.length-2}',style:const TextStyle(fontWeight: FontWeight.bold,color: Colors.black)
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget> [
          Row(
            children: const [
              Text("Test"),
            ],
          ),
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details){
                if(direction !='up' && details.delta.dy>0){
                  direction = 'down';
                }else if(direction !='down' && details.delta.dy <0){
                  direction ='up';
                }
              },
              onHorizontalDragUpdate: (detials){

                if(direction != 'left'&& detials.delta.dx>0){
                  direction ='right';
                } else if(direction !='right' && detials.delta.dx <0){
                  direction ='left';
                }
              },

              child: AspectRatio(
                aspectRatio:row/(coll+2),
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: row),
                    itemCount: row*coll,
                    itemBuilder: (BuildContext context,int index){
                      var color;
                      var x = index% row;
                      var y = (index/row).floor();

                      bool isSnakeBody = false;
                      for(var pos in snake){
                        if(pos[0]==x && pos[1]==y){
                          isSnakeBody=true;
                          break;
                        }
                      }

                      if(snake.first[0] == x && snake.first[1]==y){
                        color=Colors.green;
                      }else if(isSnakeBody){
                        color = Colors.green[200];
                      }else if (food[0] == x && food[1]== y){
                        color=Colors.red;
                      }else{
                        color=Colors.grey;
                      }

                      return Container(
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            color: color
                        ),
                      );
                    }

                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FilledButton(
                  style: TextButton.styleFrom(backgroundColor: playing ? Colors.white : Theme.of(context).primaryColor,),
                  child: Text(
                    playing ? "End" : "Start",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: (){
                    if(playing){
                      playing = false;
                    }else{
                      startGame();
                    }
                  }
              ),
              Text(

                'Score: ${snake.length-2}',
                style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ],

          ),
        ],
      ),


    );
  }


}