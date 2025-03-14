import 'package:flutter/material.dart';

// from /client:
import 'package:makker_app/client/database_service_users.dart';

// from /widgets:
import 'package:makker_app/widgets/app_nav_bar.dart';

// from /screens:
import 'package:makker_app/screens/login.dart';


class RegisterUserForm extends StatefulWidget {
  const RegisterUserForm({super.key});

  @override
  _RegisterUserFormState createState() => _RegisterUserFormState();
  }

class _RegisterUserFormState extends State<RegisterUserForm> {
  // A key for managing the form:
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseServiceUsers _databaseService = DatabaseServiceUsers.instance;

  // Variables to store the entered data
  String _firstname = '';
  String _lastname = '';
  String _email = '';
  String _password = '';


  Future<void> _submitForm() async {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save the form data
      // You can perform actions with the form data here and extract the details
      // Check if the user is already in the database

       _usersList();
      if (await _databaseService.isUserInDatabase(_email) == false) {
        // Save data here
        _databaseService.addUser(_firstname, _lastname, _email, _password);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
'''
Bruker registrert:
    Navn: $_firstname $_lastname
    E-post: $_email
'''
              ),
              actions: <Widget>[
                  TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LogInForm()),
                    );
                  },
                  child: const Text('Logg inn'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Avbryt'),
                ),
              ],
            );
          },
        );
      } else {
        // Show an error message if the user is already in the database
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                content: const Text('Bruker med denne e-postadressen er allerede registrert.'),
                actions: <Widget>[
                  TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LogInForm()),
                    );
                  },
                  child: const Text('Logg inn'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Avbryt'),
                ),
                ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarNav(title: 'Registrer ny bruker', isLoggedIn: false),
      body: Form(
        key: _formKey, // Associate the form key with this Form widget
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, top: 25), // Add padding on left and right side
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Fornavn'), // Label for the name field
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
                decoration: const InputDecoration(labelText: 'Etternavn'), // Label for the name field
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
                decoration: const InputDecoration(labelText: 'E-post'), // Label for the email field
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
                decoration: const InputDecoration(labelText: 'Passord'), // Label for the password field
                obscureText: true, // Hide the password input
                validator: (value) {
                  // Validation function for the password field
                  if (value!.isEmpty) {
                  return 'Vennligst oppgi ett gyldig passord.'; // Return an error message if the password is empty
                  }
                  // You can add more complex validation logic here
                  return null; // Return null if the password is valid
                },
                onSaved: (value) {
                  _password = value!; // Save the entered password
                },
              ),

              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text('Opprett bruker'), // Text on the button
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

  // currently only used to check what data is stored in the database
  Widget _usersList() {
    return FutureBuilder(future: _databaseService.getUsers(), builder: (context, snapshot) {
      return Container();
    });
  }
}
