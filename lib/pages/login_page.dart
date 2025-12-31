import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  bool _isLogin = true;
  String _errorMessage = '';

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      dynamic result;
      if (_isLogin) {
        result = await _auth.signIn(_email.trim(), _password.trim());
      } else {
        result = await _auth.signUp(
          _name.trim(),
          _email.trim(),
          _password.trim(),
        );
      }

      if (result == null) {
        setState(() {
          _errorMessage = _isLogin
              ? 'Credenciais inválidas. Tente novamente.'
              : 'Ocorreu um erro. Verifique seus dados.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira seu nome';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value!;
                    },
                    decoration: const InputDecoration(labelText: 'Nome'),
                  ),
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Por favor, insira um email válido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  key: const ValueKey('password'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ElevatedButton(
                  onPressed: _trySubmit,
                  child: Text(_isLogin ? 'Login' : 'Criar Conta'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                      _errorMessage = '';
                    });
                  },
                  child: Text(
                    _isLogin
                        ? 'Criar uma nova conta'
                        : 'Eu já tenho uma conta',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
