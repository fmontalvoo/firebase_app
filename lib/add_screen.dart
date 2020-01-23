import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  String nombre;
  String votos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _form(),
    );
  }

  Widget _form() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                style: TextStyle(
                    // backgroundColor: Colors.amber,
                    fontStyle: FontStyle.italic,
                    fontSize: 20),
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu nombre',
                ),
                validator: (value) {
                  this.nombre = value;
                  if (value.isEmpty) {
                    return 'Porfavor ingresa tu nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: TextStyle(
                    // backgroundColor: Colors.amber,
                    fontStyle: FontStyle.italic,
                    fontSize: 20),
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu votos',
                ),
                validator: (value) {
                  this.votos = value;
                  if (value.isEmpty) {
                    return 'Porfavor ingresa tu votos';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: RaisedButton(
                  // color: Color.fromRGBO(0, 0, 255, 0.25),
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState.validate()) {
                      Firestore.instance
                          .collection('nombres')
                          .add({'nombre': this.nombre, 'votos': this.votos});
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ));
  }
}
