import 'package:flutter/material.dart';
import 'package:makker_app/client/database_service_activities.dart';
import 'package:makker_app/client/user_provider.dart';

// from widgets:
import 'package:makker_app/widgets/app_nav_bar.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class CreateActivityForm extends StatefulWidget {
  const CreateActivityForm({super.key});

  @override
  _CreateActivityFormState createState() => _CreateActivityFormState();
}
class _CreateActivityFormState extends State<CreateActivityForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseServiceActivities _databaseService = DatabaseServiceActivities.instance;

  String _date = '';
  String _category = '';
  String _type = '';
  String _location = '';
  String _rendezvous = '';
  String _title = '';
  String _description = '';
  int _userId = 0;

  @override
  void initState() {
    super.initState();

    final currentUser = Provider.of<UserProvider>(this.context, listen: false).user;
    setState(() {
      _userId = currentUser?.id ?? 0;
    });
  }

  void _newActivity() {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _databaseService.addActivity(
        _userId,
        _date,
        _category,
        _type,
        _location,
        _rendezvous,
        _title,
        _description
      );
      showDialog(
        context: this.context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              """Aktivitet registrert:\n
              Av: $_userId,
              Dato: $_date,
              Type aktivitet:$_category,
              Åpen for: $_type,
              Tittel: $_title,
              Hvor: $_location,
              Oppmøtested: $_rendezvous,
              Beskrivelse: $_description
              """
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[

              // Date
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

              // Category
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Type aktivitet'),
                // TODO: Change to .map function
                items: const [
                  DropdownMenuItem(value: 'Innendørsklatring',          child: Text('🧗Innendørsklatring')),
                  DropdownMenuItem(value: 'Innendørsklatring: Buldring',child: Text('🧗Innendørsklatring: Buldring')),
                  DropdownMenuItem(value: 'Innendørsklatring: Led',     child: Text('🧗Innendørsklatring: Led')),
                  DropdownMenuItem(value: 'Innendørsklatring: Topptau', child: Text('🧗Innendørsklatring: Topptau')),
                  DropdownMenuItem(value: 'Kano/kajakk',                child: Text('🛶Kano/kajakk')),
                  DropdownMenuItem(value: 'Lagsport: Basketball',       child: Text('🏀Lagsport: Basketball')),
                  DropdownMenuItem(value: 'Lagsport: Fotball',          child: Text('⚽Lagsport: Fotball')),
                  DropdownMenuItem(value: 'Lagsport: Håndball',         child: Text('🤾‍♂️Lagsport: Håndball')),
                  DropdownMenuItem(value: 'Lagsport: Volleyball',       child: Text('🏐Lagsport: Volleyball')),
                  DropdownMenuItem(value: 'Løping',                     child: Text('🏃‍♀️Løping')),
                  DropdownMenuItem(value: 'Ski: Alpint',                child: Text('⛷️Ski: Alpint')),
                  DropdownMenuItem(value: 'Ski: Langrenn',              child: Text('⛷️Ski: Langrenn')),
                  DropdownMenuItem(value: 'Ski: Topptur',               child: Text('⛷️Ski: Topptur')),
                  DropdownMenuItem(value: 'Seiling',                    child: Text('⛵Seiling')),
                  DropdownMenuItem(value: 'Svømming',                   child: Text('🏊‍♀️Svømming')),
                  DropdownMenuItem(value: 'Sykkel: Landeveg',           child: Text('🚲Sykkel: Landeveg')),
                  DropdownMenuItem(value: 'Sykkel: Terreng',            child: Text('🚲Sykkel: Terreng')),
                  DropdownMenuItem(value: 'Treningsøkt',                child: Text('🏋️Treningsøkt')),
                  DropdownMenuItem(value: 'Til fots: Båltur',           child: Text('🔥Til fots: Båltur')),
                  DropdownMenuItem(value: 'Til fots: Fjelltur',         child: Text('⛰️Til fots: Fjelltur')),
                  DropdownMenuItem(value: 'Til fots: Gå tur',           child: Text('🚶‍♀️Til fots: Gå tur')),
                  DropdownMenuItem(value: 'Telttur',                    child: Text('🏕️Til fots: Telttur')),
                  DropdownMenuItem(value: 'Utendørsklatring',           child: Text('🧗‍♀️Utendørsklatring')),
                  DropdownMenuItem(value: 'Utendørsklatring: Buldring', child: Text('🧗‍♀️Utendørsklatring: Buldring')),
                  DropdownMenuItem(value: 'Utendørsklatring: Isklatring',child: Text('🧗‍♀️Isklatring')),
                  DropdownMenuItem(value: 'Utendørsklatring: Sport',    child: Text('🧗‍♀️Utendørsklatring: Sport')),
                  DropdownMenuItem(value: 'Utendørsklatring: Trad',     child: Text('🧗‍♀️Utendørsklatring: Trad')),
                  DropdownMenuItem(value: 'Annet',                      child: Text('Annet')),
                ],
                onChanged: (value) {
                  _category = value!; // Save the entered name
                },
              ),

              // Deltagelsesform
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
                  _type = value!; // Save the entered name
                },
              ),

              // Title
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tittel'), // Label for the name field
                validator: (value) {
                  // Validation function for the name field
                  if (value!.isEmpty) {
                    return 'Vennligst oppgi en tittel for arrangementet.'; // Return an error message if the name is empty
                  }
                  return null; // Return null if the name is valid
                },
                onSaved: (value) {
                  _title = value!; // Save the entered name
                },
              ),

              // Location
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

              // Oppmøte
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
                  _rendezvous = value!;
                },
              ),

              // Desc.
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
