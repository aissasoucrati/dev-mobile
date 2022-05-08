import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/http.dart';
import './view/tag.dart';
import '../api/class.dart';
import 'view/scrol1.dart';
import 'view/ajouter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  int curr=0;

  @override
  Widget build(BuildContext context) {

    final _tabs=<Widget>[
      home_posts(),
      searshLP(),
      new_post(),

    ];

    return MaterialApp(
        title: 'Dummy API',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(

          appBar:AppBar(
            automaticallyImplyLeading:false,
            shape:const RoundedRectangleBorder(

            ),
            leading: IconButton(
              onPressed: (){
                setState(() {
                  curr=0;
                });
              },
              icon: Icon(Icons.home,color: Colors.yellow.shade800,size: 27,),
            ),
            title:  Text('dummyapi',style: TextStyle(color: Colors.yellow.shade800,fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                  onPressed: (){
                    setState(() {
                      curr=1;
                    });
                  },
                  icon: Icon(Icons.search,color: Colors.yellow.shade800,size: 27,)
              ),
              IconButton(
                  onPressed: (){
                    setState(() {
                      curr=2;
                    });
                  },
                  icon: Icon(Icons.add_box_outlined,color: Colors.yellow.shade800,size: 27)
              ),
              const SizedBox(width: 15,)
            ],
          ),
          body:_tabs[curr],

        )
    );
  }

}

FutureBuilder<List<Post>> home_posts() {
  return FutureBuilder(
      future: getpost(http.Client(),0),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return  Center(
            child:Text('${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          return HomePage(posts: snapshot.data!);
        } else {
          return const Center(

            child: CircularProgressIndicator(),
          );
        }
      }
  );
}