import 'package:flutter/material.dart';
import 'package:flutter_stack_overflow_api/repository.dart';
import 'package:flutter_stack_overflow_api/user.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Stackoverflow',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Stackoverflow Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> userList = [];

  @override
  void initState() {
    super.initState();
    Repository.getStackOverflowUsers().then((users) {
      setState(() {
        userList= users;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> userWidgets = [];
    for (int i = 0; i < userList.length; i++) {
      userWidgets.add(_buildUserWidget(userList[i]));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Stackoverflow Users"),
      ),
      body: ListView(children: userWidgets),
    );
  }

  Widget _buildUserWidget(User user) {
    return Container(
      child: ListTile(
        title: Text(user.name),
        subtitle: Text("${user.reputation}"),
      ),
    );
  }
}
