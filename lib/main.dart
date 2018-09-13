import 'package:flutter/material.dart';
import 'package:flutter_stack_overflow_api/repository.dart';
import 'package:flutter_stack_overflow_api/user.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Repository repository = Repository();

    return new MaterialApp(
      title: 'Stackoverflow',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Stackoverflow Users', repository: repository),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.repository}) : super(key: key);

  Repository repository;

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stackoverflow Users"),
      ),
      body: FutureBuilder<List<User>>(
        future: widget.repository.getStackOverflowUsers(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            List<User> users = snapShot.data;
            return ListView(
              children: users.map(_buildUserWidget).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
        //child: ListView(children: userWidgets),
      ),
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
