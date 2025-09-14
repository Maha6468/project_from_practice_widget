import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List users=[];

  bool isloading=false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 20),(){
      fatchUsers();
    });

  }

  Future<void> fatchUsers()async {
    setState(() {
      isloading=true;
    });
    final response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    setState(() {
      isloading=false;
    });
    log(response.body);
    //print(response.body);

    if(response.statusCode==200){
      users=jsonDecode(response.body);
    }else{
      throw Exception("Something worng");
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body:isloading?Center(
        child: CircularProgressIndicator(),
      ):
      ListView.builder(
        itemCount: users.length,
          itemBuilder: (context,index){
          final user=users[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.purpleAccent,
                child: Text(user["name"][0],style: TextStyle(color: Colors.white),),
              ),
              title: Text(user['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text("Username:${user["username"]}",style: TextStyle(color: Colors.grey),),
                  Text("Email:${user['email']}",style: TextStyle(color: Colors.grey),),
                  Text("Phone:${user["phone"]}",style: TextStyle(color: Colors.grey),),
                  Text("Website:${user["website"]}",style: TextStyle(color: Colors.grey),),
                  Text("Address:${user["address"]["street"]},${user["address"]["suite"]},",style: TextStyle(color: Colors.grey),),
                ],
              ),
            );
          })
    );
  }
}
