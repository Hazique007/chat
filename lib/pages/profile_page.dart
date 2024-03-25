import 'package:chatting/components/profile_textbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
//user

  final currentUser = FirebaseAuth.instance.currentUser!;
  final usercollection = FirebaseFirestore.instance.collection("Users");

//edit field
  Future<void> editField(String field) async {
    String newvalue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Edit $field',
                style: GoogleFonts.montserrat(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              content: TextField(
                autofocus: true,
                style: GoogleFonts.montserrat(color: Colors.grey),
                decoration: InputDecoration(
                  hintText: "Enter new $field",
                  hintStyle: GoogleFonts.montserrat(color: Colors.grey)
                ),
                onChanged: (value){
                  newvalue=value;

                },
              ),
          actions: [
            //cancel button
            TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Cancel')),
            //save button
            TextButton(onPressed: ()=>Navigator.of(context).pop(newvalue), child: Text('Save')),
          ],
            ));
    if(newvalue.trim().length>0){
      await usercollection.doc(currentUser.email).update({field:newvalue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: Text(
          'Profile',
          style: GoogleFonts.montserrat(fontSize: 20),
        ),
      ),
      body:
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(currentUser.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('=== data ===: ${snapshot.data}');
                final userdata = snapshot.data!.data() as Map<String, dynamic>;
                return
                  ListView(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      //profile pic
                      Icon(
                        Icons.person,
                        size: 72,
                      ),

                      //user email
                      Text(
                        currentUser.email!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            color: Colors.grey.shade700),
                      ),
                      SizedBox(
                        height: 50,
                      ),

                      //user details
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                          'My Details',
                          style: GoogleFonts.montserrat(
                              color: Colors.grey.shade600),
                        ),
                      ),

                      //username
                      ProfileTextBox(
                        text: userdata['username'],
                        sectionname: 'Username',
                        onPressed: () => editField('username'),
                      ),
                      ProfileTextBox(
                        text: userdata['bio'],
                        sectionname: 'bio',
                        onPressed: () => editField('bio'),
                      ),

                      //bio
                    ],
                  );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error${snapshot.error}'));
              } else
                return Center(child: CircularProgressIndicator());
            }
            )

    );
    }
  }

