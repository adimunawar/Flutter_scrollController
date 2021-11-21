import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ScrollController & ScrollNotification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String message = '';
  ScrollController? scrollController;
  bool? isReachBottom = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.offset >=
              scrollController!.position.maxScrollExtent &&
          !scrollController!.position.outOfRange) {
        setState(() {
          message = "reach the bottom";
          isReachBottom = true;
        });
      }

      if (scrollController!.offset <=
              scrollController!.position.minScrollExtent &&
          !scrollController!.position.outOfRange) {
        setState(() {
          message = "reach the top";
          isReachBottom = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ScrollController"),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body: Column(
        children: [
          Container(
            height: 50,
            color: Colors.green,
            child: Center(
              child: Text("message => $message"),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Container(
                        color: (index == 2) ? Colors.pink : Colors.white,
                        height: (index == 2) ? 200 : 40,
                        child: Text(
                          "index : $index",
                          style: TextStyle(
                              color: (index == 2) ? Colors.blue : Colors.black),
                        ),
                      ),
                    );
                  })),
          (isReachBottom == true)
              ? ElevatedButton(
                  onPressed: () {
                    scrollController!.animateTo(2.0,
                        curve: Curves.linear,
                        duration: const Duration(milliseconds: 500));
                  },
                  child: const Text('Jump'))
              : const SizedBox()
        ],
      ),
    );
  }
}
