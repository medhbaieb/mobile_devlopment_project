import 'package:flutter/material.dart';
import 'chatvoice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:convert';

class notification extends StatefulWidget {
  const notification({super.key});

  static const String _title = 'Notifications';

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: notification._title,
      home: Scaffold(
        appBar:
            AppBar(title: const Text(notification._title),leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ), centerTitle: true),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final CollectionReference _notification =
      FirebaseFirestore.instance.collection('notification');
 
  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          //upated data in real time
          stream: _notification.snapshots(), //build connection
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              //if we have data

              return Row(
                children: <Widget>[
                  SizedBox(
                    width: 400,
                      child: Container(
                    padding: const EdgeInsets.fromLTRB(3, 10, 0, 10),
                    child: Scrollbar(
                      
                      thumbVisibility: true,
                      controller: _firstController,
                      child: ListView.builder(
                          controller: _firstController,
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];
                            return Center(
                              child: Column(children: [
                                Card(
                                    color: Color.fromARGB(255, 123, 123, 248)
                                        .withAlpha(30),
                                    margin: EdgeInsets.only(top: 30.0),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.0, bottom: 0.0),
                                        ),
                                        Container(
                                          child: SizedBox(
                                            width: 330,
                                            height: 40,
                                            child: Text(
                                              documentSnapshot['iduser'] +//iduser or user name
                                                  " need your help",
                                              style: TextStyle(fontSize: 25),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            debugPrint('Card tapped.');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        chatvoice()));
                                          },
                                          child: Image.asset(
                                            'assets/camera-icon-21.png',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    )),
                              ]),
                            );
                          }),
                    ),
                  )),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
