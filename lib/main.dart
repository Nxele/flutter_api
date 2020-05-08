import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'CRUID API Test'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _result;

  void _displayResult(String result) {
    setState(() {
      _result = result;
    });
  }

  _getUsers() async {
      try{
        // make GET request
        String url = 'http://127.0.0.1:3000/api/users';
        Response response = await get(url);
        // sample info available in response
        int statusCode = response.statusCode;
        Map<String, String> headers = response.headers;
        String contentType = headers['content-type'];
        String json = response.body;
        // TODO convert json to object...
        print(json.toString());
        _displayResult(json.toString());
      }
      catch(ex){
      }
  }
  void _addUser() async{
    try{
      // set up POST request arguments
      String url = 'http://127.0.0.1:3000/api/users';
      Map<String, String> headers = {"Content-type": "application/json"};
      String json = '{"name": "Minenhle", "surname": "nxele", "occupation":"melusi","age":37,"address":"6610 nxamalala area"}';
      // make POST request
      Response response = await post(url, headers: headers, body: json);
      // check the status code for the result
      int statusCode = response.statusCode;
      // this API passes back the id of the new item added to the body
      String body = response.body;

      _displayResult(body.toString());
    }
    catch(ex){
    }
  }
  void _deleteUser() async{
    try{
      String url = 'http://127.0.0.1:3000/api/users/Minenhle';
      // make DELETE request
      Response response = await delete(url);
      // check the status code for the result
      int statusCode = response.statusCode;
      String body = response.body;
      _displayResult(body.toString());
    }
    catch(ex){
    }
  }

  void _updateUser() async{
    try{
      // set up PUT request arguments
      String url = 'http://127.0.0.1:3000/api/users/Minenhle';
      Map<String, String> headers = {"Content-type": "application/json"};
      String json = '{"address": "6610 Msinga Nxamalala area"}';
      // make PUT request
      Response response = await put(url, headers: headers, body: json);
      // check the status code for the result
      int statusCode = response.statusCode;
      // this API passes back the updated item with the id added
      String body = response.body;
      _displayResult(body.toString());
    }
    catch(ex){
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_result',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateUser,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
