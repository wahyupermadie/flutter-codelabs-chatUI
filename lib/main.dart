import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class ChatScreen extends StatefulWidget{
  String title;
  ChatScreen({this.title});

  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen>{
  final TextEditingController _textController = new TextEditingController(); 

  void _handleSubmitted(String text) {
    print(text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildTextComposer(
        textController: _textController,
        handleSubmitted: (context) => _handleSubmitted(_textController.text ?? "")
      ),
    );
  }
}

Widget _buildTextComposer({TextEditingController textController, Function handleSubmitted}) {

  return IconTheme(
    data: IconThemeData(color: Colors.blueAccent),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: textController,
                onSubmitted: handleSubmitted,
                decoration: new InputDecoration.collapsed(
                  hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () {
                  handleSubmitted(textController.text);
                }),
            ),
        ],
      )
    )
  );
}