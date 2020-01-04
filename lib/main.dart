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
  final List<MessageWidget> _messages = <MessageWidget>[]; 

  void _handleSubmitted(String text) {
    _textController.clear();
    MessageWidget message = new MessageWidget(                         //new
      text: text,                                                  //new
    );                                                             //new
    setState(() {                                                  //new
      _messages.insert(0, message);                                //new
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: new ListView.builder(                            //new 
                padding: new EdgeInsets.all(8.0),                     //new
                reverse: true,                                        //new
                itemBuilder: (_, int index) => _messages[index],      //new
                itemCount: _messages.length,                          //new
              ),   
            ),
            Divider(height: 1.0),  
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor),
              child:  _buildTextComposer(
                        textController: _textController,
                        handleSubmitted: (context) => _handleSubmitted(_textController.text ?? "")
                      ),
            )
          ],
        ),
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

class MessageWidget extends StatelessWidget{
  final String text;
  MessageWidget({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              child: Text("Wahyu Permadi"),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text("Wahyu Permadi", style: Theme.of(context).textTheme.subhead),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(text),
              ),
            ]
          )
        ],
      ),
    );
  }
}