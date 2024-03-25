import 'package:chatting/auth/auth_service.dart';
import 'package:chatting/components/chat_bubble.dart';
import 'package:chatting/components/message_text_field.dart';
import 'package:chatting/components/mytext_field.dart';
import 'package:chatting/services/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  final String recieveremail;
  final String recieverid;
  ChatPage({required this.recieverid, required this.recieveremail, super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat @ auth services
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  //for textfield focus

  FocusNode myFOcusNode = FocusNode();

  @override
  void initState() {

    super.initState();

    // add listener to focus

    myFOcusNode.addListener(() {
      if(myFOcusNode.hasFocus){
        Future.delayed(Duration(milliseconds: 500),()=> scrollDown());
      }

    });
    Future.delayed(Duration(milliseconds: 500),
        ()=> scrollDown()

    );
  }



  @override
  void dispose() {
    myFOcusNode.dispose();
    _messageController.dispose();

    super.dispose();
  }
  //scroll controller

  final ScrollController _scrollController = ScrollController();
  void scrollDown(){
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }
  


  // send messages
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      //send
      await _chatService.sendMessage(widget.recieverid, _messageController.text);
      _messageController.clear();

    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        title: Text(
          widget.recieveremail,
          style:
              GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w700,color: Colors.grey),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //display all message
          Expanded(child: _buildMessageList()),

          //userinput
          _buildUserInput()
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUsr()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.recieverid, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
// current useer
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUsr()!.uid;

    // align message to right
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(alignment: alignment,

        child: Column(
          crossAxisAlignment:isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
           ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
          ],
        ));
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
              child: MyMessageTextField(
                focusNode: myFOcusNode,
                  hintText: "Send Message",
                  obsecure: false,
                  controller: _messageController)),
          Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              shape: BoxShape.circle,
            ),
              margin: EdgeInsets.only(right: 12),
              child: IconButton(
                  onPressed: sendMessage, icon: Icon(Icons.arrow_forward_ios,color: Colors.white,)))
        ],
      ),
    );
  }
}
