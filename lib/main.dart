import 'package:flutter/material.dart';
import 'package:flutter_stack_overflow_api/repository.dart';
import 'package:flutter_stack_overflow_api/user.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Repository repository = Repository();

    return new MaterialApp(
      title: 'Stackoverflow',
      theme: new ThemeData(
        primarySwatch: Colors.amber,
      ),
      home:
          new MyHomePage(title: 'Stackoverflow Users', repository: repository),
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
        centerTitle: true,
        title: Text(
          "Stackoverflow Buddies",
          style: TextStyle(color: Colors.white),
        ),
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
      child: ExpansionTile(
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(user.profilePicUrl),
        ),
        title: ListTile(
            title: Text(user.name),
            subtitle: Row(children: <Widget>[
              Icon(Icons.location_on),
              Expanded(
                child: Text(
                  user.location ?? "",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ])),
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/gold.png'),
                        ),
                        Text("${user.gold}")
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/silver.png'),
                        ),
                        Text("${user.silver}")
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/bronze.png'),
                        ),
                        Text("${user.bronze}")
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: new InkWell(
                  child: new Text(
                    "For more details about ${user.name}, Tap here",
                    style: new TextStyle(color: Colors.blue),
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => launch(user.link),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
