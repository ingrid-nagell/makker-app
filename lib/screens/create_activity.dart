import 'package:flutter/material.dart';
import 'package:makker_app/client/database_service_activities.dart';

// from widgets:
import 'package:makker_app/widgets/app_nav_bar.dart';

class CreateActivityForm extends StatefulWidget {
  const CreateActivityForm({super.key});

  @override
  _CreateActivityFormState createState() => _CreateActivityFormState();
}
class _CreateActivityFormState extends State<CreateActivityForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseServiceActivities _databaseService = DatabaseServiceActivities.instance;

  String _createdBy = 'DEVBRUKER';
  String _date = '';
  String _category = '';
  String _location = '';
  String _address = '';
  String _description = '';
  bool _active = true;

  void _newActivity() {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _databaseService.addActivity(_createdBy, _date, _category, _location, _address, _description, _active);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              'Bruker registrert:\nAv: $_createdBy\nType aktivitet:$_category\nHvor: $_location, $_address'
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarNav(title: 'Registrer ny aktivitet'),
      body: Form(
        key: _formKey, // Associate the form key with this Form widget
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Dato'), // Label for the email field
                validator: (value) {
                  // Validation function for the email field
                  if (value!.isEmpty) {
                    return 'Vennligst oppgi ett gyldig dato.'; // Return an error message if the email is empty
                  }
                  // You can add more complex validation logic here
                  return null; // Return null if the email is valid
                },
                onSaved: (value) {
                  _date = value!; // Save the entered email
                },
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Kategori'),
                // TODO: Change to .map function
                items: const [
                  DropdownMenuItem(value: 'Innendørsklatring',          child: Text('🧗Innendørsklatring')),
                  DropdownMenuItem(value: 'Innendørsklatring: Led',     child: Text('🧗Innendørsklatring: Led')),
                  DropdownMenuItem(value: 'Innendørsklatring: Topptau', child: Text('🧗Innendørsklatring: Topptau')),
                  DropdownMenuItem(value: 'Innendørsklatring: Buldring',child: Text('🧗Innendørsklatring: Buldring')),
                  DropdownMenuItem(value: 'Kano/kajakk',                child: Text('🛶Kano/kajakk/båt')),
                  DropdownMenuItem(value: 'Lagsport: Fotball',          child: Text('⚽Lagsport: Fotball')),
                  DropdownMenuItem(value: 'Lagsport: Basketball',       child: Text('🏀Lagsport: Basketball')),
                  DropdownMenuItem(value: 'Lagsport: Volleyball',       child: Text('🏐Lagsport: Volleyball')),
                  DropdownMenuItem(value: 'Lagsport: Håndball',         child: Text('🤾‍♂️Lagsport: Håndball')),
                  DropdownMenuItem(value: 'Løping',                     child: Text('🏃‍♀️Løping')),
                  DropdownMenuItem(value: 'Ski: Langrenn',              child: Text('⛷️Ski: Langrenn')),
                  DropdownMenuItem(value: 'Ski: Topptur',               child: Text('⛷️Ski: Topptur')),
                  DropdownMenuItem(value: 'Ski: Alpint',                child: Text('⛷️Ski: Alpint')),
                  DropdownMenuItem(value: 'Svømming',                   child: Text('🏊‍♀️Svømming')),
                  DropdownMenuItem(value: 'Sykkel: Landeveg',           child: Text('🚲Sykkel: Landeveg')),
                  DropdownMenuItem(value: 'Sykkel: Terreng',            child: Text('🚲Sykkel: Terreng')),
                  DropdownMenuItem(value: 'Treningsøkt',                child: Text('🏋️Treningsøkt')),
                  DropdownMenuItem(value: 'Båltur',                     child: Text('🔥Til fots: Båltur')),
                  DropdownMenuItem(value: 'Fjelltur',                   child: Text('⛰️Til fots: Fjelltur')),
                  DropdownMenuItem(value: 'Tur',                        child: Text('🚶‍♀️Til fots: Gå tur')),
                  DropdownMenuItem(value: 'Telttur',                    child: Text('🏕️Til fots: Telttur')),
                  DropdownMenuItem(value: 'Utendørsklatring',           child: Text('🧗‍♀️Utendørsklatring')),
                  DropdownMenuItem(value: 'Utendørsklatring: Sport',    child: Text('🧗‍♀️Utendørsklatring: Sport')),
                  DropdownMenuItem(value: 'Utendørsklatring: Trad',     child: Text('🧗‍♀️Utendørsklatring: Trad')),
                  DropdownMenuItem(value: 'Utendørsklatring: Buldring', child: Text('🧗‍♀️Utendørsklatring: Buldring')),
                ],
                onChanged: (value) {
                  _category = value!; // Save the entered name
                },
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Deltagelsesform'),
                items: const [
                  DropdownMenuItem(value: 'Lukket', child: Text('Lukket')),
                  DropdownMenuItem(value: 'Fellestur', child: Text('Fellestur')),
                ],
                validator: (value) {
                  if (value == null) {
                  return 'Vennligst velg en deltagelsesform.';
                  }
                  return null;
                },
                onChanged: (value) {
                  _category = value!; // Save the entered name
                },
                ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Sted'), // Label for the name field
                validator: (value) {
                  // Validation function for the name field
                  if (value!.isEmpty) {
                    return 'Vennligst oppgi ditt etternavn'; // Return an error message if the name is empty
                  }
                  return null; // Return null if the name is valid
                },
                onSaved: (value) {
                  _location = value!; // Save the entered name
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Oppmøteadresse'), // Label for the email field
                validator: (value) {
                  // Validation function for the email field
                  if (value!.isEmpty) {
                    return 'Vennligst oppgi en gyldig adresse.'; // Return an error message if the email is empty
                  }
                  // You can add more complex validation logic here
                  return null; // Return null if the email is valid
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Beskrivelse'), // Label for the email field
                validator: (value) {
                  // Validation function for the email field
                  if (value!.isEmpty) {
                    return 'Vennligst beskriv aktiviteten.'; // Return an error message if the email is empty
                  }
                  // You can add more complex validation logic here
                  return null; // Return null if the email is valid
                },
                onSaved: (value) {
                  _description = value!; // Save the entered email
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text('Opprett aktivitet'), // Text on the button
                onPressed: () {
                  _newActivity();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
