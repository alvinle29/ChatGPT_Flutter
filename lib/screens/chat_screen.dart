import 'package:chat_gpt_application/services/assets_manager.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.openaiLogo),
          ),
          title: const Text('ChatGPT'),
        ),
        body: SafeArea(
          child: Column(children: [
            Flexible(
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index){
                return Text("This isasd");
              }),
            ),
          ],
          
      ),
        )
    );
  }
}