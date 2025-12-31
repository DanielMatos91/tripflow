import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/driver_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _auth = AuthService();
  final DriverService _driverService = DriverService();
  final User? _user = FirebaseAuth.instance.currentUser;

  bool _gpsEnabled = false;
  String _theme = 'auto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SEU PERFIL')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<DocumentSnapshot>(
            stream: _driverService.getDriverProfile(_user!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Ocorreu um erro');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              var driverData = snapshot.data!.data() as Map<String, dynamic>;

              return Column(
                children: <Widget>[
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    driverData['name'] ?? 'Motorista',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(driverData['email'] ?? ''),
                  const SizedBox(height: 30),
                  _buildProfileButton('Mudar a palavra-passe', () {
                    _auth.sendPasswordResetEmail(driverData['email']);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Email de redefinição enviado!'),
                      ),
                    );
                  }),
                  _buildProfileButton('Termos e Condições', () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Em breve')));
                  }),
                  _buildProfileButton('Terminar a sessão', () {
                    _auth.signOut();
                  }),
                  _buildProfileButton(
                    'Enviar um e-mail para o suporte técnico',
                    () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('Em breve')));
                    },
                  ),
                  _buildProfileButton('Chat com OPS', () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Em breve')));
                  }),
                  const SizedBox(height: 30),
                  const Text(
                    'Definições',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SwitchListTile(
                    title: const Text(
                      'Ações automatizadas com base na posição do GPS',
                    ),
                    value: _gpsEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _gpsEnabled = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ChoiceChip(
                        label: const Text('Claro'),
                        selected: _theme == 'light',
                        onSelected: (bool selected) {
                          setState(() {
                            _theme = 'light';
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Escuro'),
                        selected: _theme == 'dark',
                        onSelected: (bool selected) {
                          setState(() {
                            _theme = 'dark';
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Auto'),
                        selected: _theme == 'auto',
                        onSelected: (bool selected) {
                          setState(() {
                            _theme = 'auto';
                          });
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(color: Colors.blue)),
      ),
    );
  }
}
