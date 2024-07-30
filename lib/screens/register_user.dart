import 'package:flutter/material.dart';
import 'package:makker_app/client/database_service.dart';

import '../widgets/app_nav_bar.dart';


class RegisterUserForm extends StatefulWidget {
  @override
  _RegisterUserFormState createState() => _RegisterUserFormState();
}

class _RegisterUserFormState extends State<RegisterUserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // A key for managing the form
  final DatabaseService _databaseService = DatabaseService.instance;

  String _name = ''; // Variable to store the entered name
  String _email = ''; // Variable to store the entered email


  void _submitForm() {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save the form data
      // You can perform actions with the form data here and extract the details
      //save data here:
      _databaseService.addUser(_name);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
            content: Text('The following account has been registerd:\nName: $_name\nEmail: $_email'),
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
                decoration: InputDecoration(labelText: 'Name'), // Label for the name field
                validator: (value) {
                  // Validation function for the name field
                  if (value!.isEmpty) {
                    return 'Please enter your name.'; // Return an error message if the name is empty
                  }
                  return null; // Return null if the name is valid
                },
                onSaved: (value) {
                  _name = value!; // Save the entered name
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'), // Label for the email field
                validator: (value) {
                  // Validation function for the email field
                  if (value!.isEmpty) {
                    return 'Please enter your email.'; // Return an error message if the email is empty
                  }
                  // You can add more complex validation logic here
                  return null; // Return null if the email is valid
                },
                onSaved: (value) {
                  _email = value!; // Save the entered email
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text('Submit'), // Text on the button
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