import 'dart:developer';


import 'package:chat_package/chat_package.dart';
import 'package:chat_package/models/chat_message.dart';
import 'package:chat_package/models/media/chat_media.dart';
import 'package:chat_package/models/media/media_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class chatvoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chat',
      home: Scaffold(
        appBar: AppBar(title: const Text('chat'),leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ), centerTitle: true),
        body: Chatvocal(),
      ),
    );
  }
}

class Chatvocal extends StatefulWidget {
  Chatvocal({Key? key}) : super(key: key);

  @override
  _ChatvocalState createState() => _ChatvocalState();
}

class _ChatvocalState extends State<Chatvocal> {
//form of the messages
  List<ChatMessage> messages = [
    ChatMessage(
      isSender: false,
      chatMedia: ChatMedia(
        url: 'https://www.shutterstock.com/image-photo/clothes-on-wooden-hangers-gardrobe-260nw-1557627734.jpg',
        mediaType: MediaType.imageMediaType(),
      ),
    ),
 
  ];
  final scrollController = ScrollController();//for scroll
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatScreen(
        scrollController: scrollController,
        messages: messages,
        onSlideToCancelRecord: () {
          log('not sent');
        },
        onTextSubmit: (textMessage) {
          setState(() {
            messages.add(textMessage);

            scrollController
                .jumpTo(scrollController.position.maxScrollExtent + 50);
          });
        },
        //record audio
        handleRecord: (audioMessage, canceled) {
          if (!canceled) {
            setState(() {
              messages.add(audioMessage!);
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent + 190);
            });
          }
        },
        //select image from galery
        handleImageSelect: (imageMessage) async {
          if (imageMessage != null) {
            setState(() {
              messages.add(
                imageMessage,
              );
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent + 300);
            });
          }
        },
      ),
    );
  }
}
