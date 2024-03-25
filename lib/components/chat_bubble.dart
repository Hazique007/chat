import 'package:chatting/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final bool isCurrentUser;
  final String message;

  const ChatBubble(
      {required this.message, required this.isCurrentUser, super.key});

  @override
  Widget build(BuildContext context) {
    //light vs dark mode for correct bubble colors

    bool isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDark;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isCurrentUser
              ? (isDarkMode ? Colors.green.shade600 : Colors.green.shade500)
              : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200)),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Text(
        message,
        style: GoogleFonts.montserrat(
            color: isCurrentUser? Colors.white : (isDarkMode ? Colors.white : Colors.black), fontWeight: FontWeight.w500),
      ),
    );
  }
}
