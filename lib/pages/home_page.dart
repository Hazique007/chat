
import 'package:chatting/auth/auth_service.dart';
import 'package:chatting/components/my_drawer.dart';
import 'package:chatting/services/chat.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {

  final ChatService _chatService= ChatService();
  final AuthService _authService= AuthService();



   HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        title: Text('Home',style: GoogleFonts.montserrat(fontSize: 20.0,fontWeight: FontWeight.bold),),
        centerTitle: true,

      ),
      drawer: MyWidget(),
      body: _builduserList(),
    );
  }
  
  //build a list of user accept for the curent loggin in user

Widget _builduserList(){
    return StreamBuilder(
        stream:_chatService.getUSersStream(),
      builder: (context,snapshot){
          if(snapshot.hasError){
            return Text('Error');
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Text('Loading...');
          }

          return ListView(
            children:
              snapshot.data!.map<Widget>((userData) => _builduserListItem(userData,context)).toList(),

              );






      },

    );




}
Widget _builduserListItem(
    Map<String, dynamic> userData, BuildContext context){
    if(userData['email']!= _authService.getCurrentUsr()!.email){
      return UserTile(
        text: userData['email'],
        onTap: (){
        //tapped on a user - go to chat page
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(
            recieveremail: userData['email'],
            recieverid: userData["uid"],

          )));

        },


      );

    }else{
      return Container();
    }

}

  
}




