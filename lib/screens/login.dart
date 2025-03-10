import 'package:flutter/material.dart';

// from /widgets:
import 'package:makker_app/widgets/app_nav_bar.dart';


class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // A key for managing the form
  String _name = ''; // Variable to store the entered name
  String _email = ''; // Variable to store the entered email

  void _submitForm() {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save the form data
      // You can perform actions with the form data here and extract the details
      // print('Name: $_name'); // Print the name
      // print('Email: $_email'); // Print the email
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarNav(title: 'Logg inn'),
      body: Form(
        key: _formKey, // Associate the form key with this Form widget
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
            child: Column(
            children: <Widget>[
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Name'), // Label for the name field
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
              ),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Email'), // Label for the email field
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
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
              onPressed: _submitForm, // Call the _submitForm function when the button is pressed
              child: const Text('Submit'), // Text on the button
              ),
            ],
            ),
          ),
        ),
      );
  }
}
