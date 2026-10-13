import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String phone;
  final String email;
  const Contact(this.name, this.phone, this.email);
}

const contacts = [
  Contact('Alice Johnson', '+998 90 111 22 33', 'alice@example.com'),
  Contact('Bob Smith', '+998 91 222 33 44', 'bob@example.com'),
  Contact('Carol White', '+998 93 333 44 55', 'carol@example.com'),
  Contact('David Brown', '+998 94 444 55 66', 'david@example.com'),
  Contact('Eve Davis', '+998 95 555 66 77', 'eve@example.com'),
];

void main() => runApp(const MaterialApp(home: ContactListScreen()));

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: ListView(
        children: [
          for (final c in contacts)
            ListTile(
              leading: CircleAvatar(child: Text(c.name[0])),
              title: Text(c.name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactScreen(contact: c),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  final Contact contact;
  const ContactScreen({super.key, required this.contact});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(contact.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(contact.name),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(contact.phone),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: Text(contact.email),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}