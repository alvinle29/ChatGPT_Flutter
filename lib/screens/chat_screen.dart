import 'dart:developer';

import 'package:chat_gpt_application/constants/constants.dart';
import 'package:chat_gpt_application/services/api_services.dart';
import 'package:chat_gpt_application/services/assets_manager.dart';
import 'package:chat_gpt_application/services/services.dart';
import 'package:chat_gpt_application/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/chat_model.dart';
import '../providers/models_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;

  late TextEditingController textEditingController;

  List<ChatModel> chatList = [];

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelsProvider>(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.openaiLogo),
          ),
          title: const Text('ChatGPT'),
          actions: [
            IconButton(
                onPressed: () async {
                  await Services.showModalSheet(context: context);
                },
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                ))
          ],
        ),
        body: SafeArea(
          child: Column(children: [
            Flexible(
              child: ListView.builder(
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: chatList[index].msg,
                      chatIndex: chatList[index].chatIndex,
                    );
                  }),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              )
            ],
            const SizedBox(height: 15),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: textEditingController,
                      onSubmitted: (value) {},
                      decoration: const InputDecoration.collapsed(
                          hintText: "How can I help you?",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          )),
                    )),
                    IconButton(
                        onPressed: () async {
                          try {
                            setState(() {
                              _isTyping = true;
                              chatList.add(ChatModel(
                                  msg: textEditingController.text,
                                  chatIndex: 0));
                            });
                            chatList.addAll(await ApiService.sendMessage(
                                message: textEditingController.text,
                                modelId: modelProvider.getCurrentModel)
                            );
                            setState(() {});
                          } catch (error) {
                            log("error $error");
                          } finally {
                            setState(() {
                              _isTyping = false;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
