import 'package:flutter/material.dart';
import '../api/http.dart';
import 'package:http/http.dart' as http;
import '../api/class.dart';
import 'scrol2.dart';

import 'package:fluttertoast/fluttertoast.dart';
class searshLP extends StatefulWidget {
  searshLP({Key? key}) : super(key: key);

  @override
  State<searshLP> createState() => _searshLPState();
}

class _searshLPState extends State<searshLP> {

  final input4 = TextEditingController();
  int s=0;
 
  String tag='';

  @override
  Widget build(BuildContext context) {
   
    return ListView(
      
      scrollDirection: Axis.vertical,
      
      children: [
      
      const SizedBox(height: 15,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: (){
              setState(() {
                          s=(s+1)%2;                       
                        });
            },
           icon:const Icon(Icons.search,size:33),
           ),
          const SizedBox(width:30),
          Center(
            child: Container(
            height: 50,
            width: 250,
            decoration:const BoxDecoration(
              color: Colors.white,
              
            ),
            child:TextFormField(
              controller: input4,
              
              decoration:const InputDecoration(
                //icon: Icon(Icons.search),
                labelText: 'donner une tag',
                
              ),
            ),
          ),
          ),
          
        ],
      ),
      const SizedBox(height: 15,),
      Container(
        height: 480,
        child:s==0? const Center(child: Text(
        '',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey
        ),
      ),
      ):FutureBuilder<List<Post>>(
       
                        future: searchList(http.Client(),0,input4.text.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child:Text('${snapshot.error}'),
                            );
                          } else if (snapshot.hasData) {
                            
                            return HomePage(posts: snapshot.data!,tag: input4.text.toString());
                          } else {
                            
                            return const Center(
                              
                              child: CircularProgressIndicator(),
                            );
                         }
                        
                        }
                        )
      
      )
    ],);
  }
  
}