import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    final _passwordFocusNode = FocusNode();
    final _form = GlobalKey<FormState>();
    String _userId;
    String _password;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _form,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'id'),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please provide a value.';
                }
                if (value.length <= 4) {
                  return 'id must be longer than 4 characters.';
                }
                if (16 < value.length) {
                  return 'id must be less than 16 characters.';
                }
                if (int.tryParse(value) == null) {
                  return 'no';
                }
                return null;
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              onSaved: (value) {
                _userId = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'password'),
              obscureText: true,
              focusNode: _passwordFocusNode,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a password.';
                }
                return null;
              },
              onSaved: (value) {
                _password = value;
              },
            ),
            FlatButton(
              child: Text('Save'),
              color: Colors.grey,
              onPressed: () {
                if (!_form.currentState.validate()) {
                  return;
                }
                _form.currentState.save();
              },
            ),
          ],
        ),
      ),
    );
  }
}
