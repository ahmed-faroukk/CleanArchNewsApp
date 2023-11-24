import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/main.dart';

class SavedNews extends StatefulWidget{
  const SavedNews({super.key});

  @override
  State<SavedNews> createState() {
   return MyAppState() ;
  }

}

class MyAppState extends State<SavedNews>{
  int x = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: (){
                setState(() {
                  x++;

                });
                print(x);
              }, icon: const Icon(Icons.add)) ,
              Text("counter $x"),
              IconButton(onPressed: (){
                setState(() {
                  x--;

                });
                print(x);

              }, icon: const Icon(Icons.minimize))
            ],),
        ),
      ),
    );
  }


}