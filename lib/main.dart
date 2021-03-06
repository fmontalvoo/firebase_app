import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nombres',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nombres')),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Añadir'),
        icon: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddScreen()));
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('nombres').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = data.data;

    return Padding(
      // key: ValueKey(record['name']),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record['nombre']),
          trailing: Text(record['votos'].toString()),
          onTap: () =>
              data.reference.updateData({'votos': FieldValue.increment(1)}),
        ),
      ),
    );
  }
}
