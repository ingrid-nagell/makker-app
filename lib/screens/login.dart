import 'package:flutter/material.dart';

// from /widgets:
import 'package:makker_app/widgets/app_nav_bar.dart';
import 'package:makker_app/screens/my_page.dart';

// from /client:
import 'package:makker_app/client/database_service_users.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // A key for managing the form
  final DatabaseServiceUsers _databaseService = DatabaseServiceUsers.instance;

  String _email = ''; // Variable to store the entered name
  String _password = ''; // Variable to store the entered email

  Future<void> _submitForm() async {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save the form data

      // You can perform actions with the form data here and extract the details
      print('Email: $_email'); // Print the email
      print('PWD: $_password'); // Print the password


      if (await _databaseService.isUserInDatabase(_email) == true) {

        var user = await _databaseService.getUser(_email);

        if (user.password != _password) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text('Feil passord. Vennligst prøv igjen.'),
              );
            },
          );
          return;
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyPage(title: 'Min side', user: user)),
          );
        }
      } else {
        // Show an error message if the user is not in the database
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Bruker med denne e-postadressen er ikke registrert.'),
            );
          },
        );
      }
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

              // Email field
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Email'), // Label for the name field
                validator: (value) {
                // Validation function for the name field
                if (value!.isEmpty) {
                  return 'Skriv inn din e-postadresse.'; // Return an error message if the name is empty
                }
                return null; // Return null if the name is valid
                },
                onSaved: (value) {
                _email = value!; // Save the entered name
                },
              ),
              ),

              // Email field
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Passord'), // Label for the email field
                validator: (value) {
                // Validation function for the email field
                if (value!.isEmpty) {
                  return 'Skriv inn ditt passord.'; // Return an error message if the email is empty
                }
                // You can add more complex validation logic here
                return null; // Return null if the email is valid
                },
                onSaved: (value) {
                _password = value!; // Save the entered email
                },
              ),
              ),

              const SizedBox(height: 20.0),

              // Submit button
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
