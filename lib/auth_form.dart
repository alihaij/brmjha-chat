import 'chat.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn);
  final void Function(
    String email,
    String password,
    String user,
    bool isLogin,
    BuildContext context,
  ) submitFn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String? _userEmail;
  String? _userName;
  String? _userPassword;
  void _trySubmit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail!.trim(),
        _userPassword!.trim(),
        _userName!.trim(),
        _isLogin,
        context,
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please Enter valid Email address.';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email address'),
                  onSaved: (value) {
                    _userEmail = value;
                  }, // InputDecoration
                ),
                if (!_isLogin)
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value.length < 3) {
                        return ' Please Enter User Name more than 2 character';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(labelText: 'Username'),
                    onSaved: (value) {
                      _userName = value;
                    },
                  ), // TextFormField
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 character long';
                    }
                  },
                  decoration: const InputDecoration(labelText: 'Password'),
                  onSaved: (value) {
                    _userPassword = value;
                  },
                  obscureText: true,
                ), // TextFormField
                const SizedBox(height: 12),
                ElevatedButton(
                  child: Text(_isLogin ? 'Login' : 'Signup'),
                  onPressed: () {
                    _trySubmit();
                  },
                ),
                TextButton(
                  child: Text(_isLogin
                      ? 'Create new account'
                      : 'I already have account'),
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                ), // TextFormField
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
