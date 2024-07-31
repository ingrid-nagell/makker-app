import 'package:flutter/material.dart';
import 'package:makker_app/client/database_service.dart';

import '../widgets/app_nav_bar.dart';


class RegisterUserForm extends StatefulWidget {
  @override
  _RegisterUserFormState createState() => _RegisterUserFormState();
}

class _RegisterUserFormState extends State<RegisterUserForm> {
  // A key for managing the form:
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService.instance;

  // Variables to store the entered data
  String _firstname = '';
  String _lastname = '';
  String _email = '';
  String _password = '';


  void _submitForm() {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save the form data
      // You can perform actions with the form data here and extract the details
      //save data here:
      _databaseService.addUser(_firstname, _lastname, _email, _password);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              'Bruker registrert:\nNavn: $_firstname $_lastname\nE-post: $_email\nPassord: $_password'
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNav(title: 'Registrer ny bruker'),
      body: Form(
        key: _formKey, // Associate the form key with this Form widget
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Fornavn'), // Label for the name field
                validator: (value) {
                  // Validation function for the name field
                  if (value!.isEmpty) {
                    return 'Vennligst oppgi ditt fornavn.'; // Return an error message if the name is empty
                  }
                  return null; // Return null if the name is valid
                },
                onSaved: (value) {
                  _firstname = value!; // Save the entered name
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Etternavn'), // Label for the name field
                validator: (value) {
                  // Validation function for the name field
                  if (value!.isEmpty) {
                    return 'Vennligst oppgi ditt etternavn'; // Return an error message if the name is empty
                  }
                  return null; // Return null if the name is valid
                },
                onSaved: (value) {
                  _lastname = value!; // Save the entered name
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-post'), // Label for the email field
                validator: (value) {
                  // Validation function for the email field
                  if (value!.isEmpty) {
                    return 'Vennligst oppgi en gyldig epostadresse.'; // Return an error message if the email is empty
                  }
                  // You can add more complex validation logic here
                  return null; // Return null if the email is valid
                },
                onSaved: (value) {
                  _email = value!; // Save the entered email
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Passord'), // Label for the email field
                validator: (value) {
                  // Validation function for the email field
                  if (value!.isEmpty) {
                    return 'Vennligst oppgi ett gyldig passord.'; // Return an error message if the email is empty
                  }
                  // You can add more complex validation logic here
                  return null; // Return null if the email is valid
                },
                onSaved: (value) {
                  _password = value!; // Save the entered email
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text('Opprett bruker'), // Text on the button
                onPressed: () {
                  _submitForm();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
