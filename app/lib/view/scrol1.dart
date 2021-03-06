import 'package:flutter/material.dart';
import '../api/class.dart';
import '../api/http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:core';


class HomePage extends StatefulWidget {
  const HomePage({Key? key,required this.posts}) : super(key: key);
  final List<Post> posts;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int _page = 0;
  
  final bool _hasNextPage = true;

  
  bool _isFirstLoadRunning = false;

  
  bool _isLoadMoreRunning = false;
 
  List<Post> _posts = [];


  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
      _posts =  widget.posts;
      _isFirstLoadRunning = false;
    }
    );
    
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {

      setState(() {
        _isLoadMoreRunning = true; 
      });
      
      _page += 1;
      
      late Future<List<Post>> fetchedPosts;
      fetchedPosts =getpost(http.Client(),_page);
     
      List<Post> l = _posts;
      l.addAll(await fetchedPosts);
      setState(() {
          _posts=l;
      });

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller =  ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: _posts.length,
                    itemBuilder: (_, index) => GestureDetector(
                    onLongPress: (){
                      showDialog<String>(
                        context:context,
                        builder:(BuildContext context) => AlertDialog(
                          title:const Text('Delet'),
                          content: const Text('sur to delet this post?'),
                          actions: [
                            TextButton(onPressed: (){Navigator.pop(context);Fluttertoast.showToast(msg:'Cancel');}, child: const Text('Cancel')),
                            TextButton(
                              onPressed: (){
                               Navigator.pop(context);
                               deletePost(widget.posts[index].id);
                               },
                              child: const Text('Yes')),
                          ],

                        )
                      );
                      
                    },
                    child: Container(

                    margin:const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 25),
                    padding: const EdgeInsets.all(5),
                    
                    decoration: BoxDecoration(
                      color: Colors.white,
                      
                      border: Border.all(color: Colors.black,width: 2)
                    ),
                    child: Column(
                            children: [
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => Second(context,index,1),
                                    child: CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage:
                                        NetworkImage(widget.posts[index].owner.picture,),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                const SizedBox(width:7),
                                Row(
                                  children: [
                                    Column(
                                      children:[
                                        Text(widget.posts[index].owner.title+'.'+' '+widget.posts[index].owner.firstName+' '+widget.posts[index].owner.lastName,
                                          style:const TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        const SizedBox(height:3),
                                        Text(widget.posts[index].publishDate)
                                      ]
                                    )
                                  ],
                                )
                                ],
                              ),
                              const SizedBox(height: 15,),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => Second(context,index,2),
                                    child: Container(
                                    width: 180,
                                    child: Image.network(widget.posts[index].image,height: 250,fit: BoxFit.cover,) ,
                                  ),
                                  ),
                                const SizedBox(width: 5,),
                                Container(
                                  height: 180,
                                  width: 130,
                                  child: ListView(
                                    scrollDirection:Axis.vertical,
                                   
                                  children: [
                                   
                                    const SizedBox(height: 5,),
                                    Text(widget.posts[index].text,style:const TextStyle(
                                      fontSize: 15
                                    )),
                                    for(var i=0;i<widget.posts[index].tags.length;i++) Container(
                                      height: 40,
                                      width: 80,
                                      margin:const EdgeInsets.only(top: 10),
                                      decoration:BoxDecoration(
                                        color:Colors.amber,
                                        borderRadius: BorderRadius.circular(5)
                                         
                                      ),
                                      child:Center(child:Text(widget.posts[index].tags[i],style:const TextStyle(color: Colors.white)))
                                    )
                                  ],
                                ),
                                )
                                ],
                              )
                            ],
                    ),
                  ),
                  ),
                  ),
                ),

                
                if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.blueGrey,),
                    ),
                  ),

                
                if (_hasNextPage == false) 
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child:const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),
              ],
    );
  }



  void Second(BuildContext context,int index,int i){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => Scaffold(
        body:Container(
                    margin:const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 25),
                    padding: const EdgeInsets.all(5),
                    
                    decoration: BoxDecoration(
                      color: Colors.white,
                     
                      border: Border.all(color: Colors.black,width: 2,)
                    ),
                    child: Column(
                            children: [
                              const SizedBox(height: 200),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => Second(context,index,1),
                                    child: CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage:
                                        NetworkImage(widget.posts[index].owner.picture,),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                const SizedBox(width:7),
                                Row(
                                  children: [
                                    Column(
                                      children:[
                                        Text(widget.posts[index].owner.title+'.'+' '+widget.posts[index].owner.firstName+' '+widget.posts[index].owner.lastName,
                                          style:const TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        const SizedBox(height:3),
                                        Text(widget.posts[index].publishDate)
                                      ]
                                    )
                                  ],
                                )
                                ],
                              ),
                              const SizedBox(height: 15,),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => Second(context,index,2),
                                    child: Container(
                                    width: 180,
                                    child: Image.network(widget.posts[index].image,height: 250,fit: BoxFit.cover,) ,
                                  ),
                                  ),
                                const SizedBox(width: 5,),
                                Container(
                                  height: 180,
                                  width: 130,
                                  child: ListView(
                                    scrollDirection:Axis.vertical,
                                   
                                  children: [
                                   
                                    const SizedBox(height: 5,),
                                    Text(widget.posts[index].text,style:const TextStyle(
                                      fontSize: 15
                                    )),
                                    for(var i=0;i<widget.posts[index].tags.length;i++) Container(
                                      height: 35,
                                      width: 105,
                                      margin:const EdgeInsets.only(top: 10),
                                      decoration:BoxDecoration(
                                        color:Colors.amber,
                                        borderRadius: BorderRadius.circular(5)
                                         
                                      ),
                                      child:Center(child:Text(widget.posts[index].tags[i],style:const TextStyle(color: Colors.white)))
                                    )
                                  ],
                                ),
                                )
                                ],
                              )
                            ],
                    ),
                  ),
      ))
    );
  }
}