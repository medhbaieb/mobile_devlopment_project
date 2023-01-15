import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              'About Us',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255)), //<-- SEE HERE
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),

      /**we use the align widget to align the menu icon */
      body: Column(
        children: [
          SizedBox(
            width: 40,
            height: 100,
          ),
          Container(
            height: 280,
            width: 300,
            padding: EdgeInsets.all(18),
            child: Stack(
              children: [
                Image.asset(
                  'assets/high.png',
                  height: 350,
                  width: 350,
                  scale: 2,
                  alignment: Alignment.topCenter,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: Text(
              "This application aims to help blind people accomplish their daily tasks.\nFor any suggestion or any further questions do not hesitate to contact us via e-mail :\n\n youssef.chtourou@Supcom.tn   ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
