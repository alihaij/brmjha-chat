import 'package:flutter/material.dart';
import 'chat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String nickName = '';
    DatabaseReference dbRef = FirebaseDatabase.instance.ref();

    return Scaffold(
      appBar: AppBar(
        title: Text('login Screen'),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(30),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      nickName = value.toString();
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (value.length <= 3) {
                        return 'Please Enter Nick Name more than 3 Character';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Enter Your Nick Name'),
                  ),
                  Container(
                    width: 180,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: (BorderRadius.circular(10))),
                    child: ElevatedButton(
                      onPressed: () {
                        final isValidForm = formKey.currentState!.validate();
                        if (isValidForm) {
                          dbRef
                              .child('nick Name')
                              .push()
                              .set(nickName)
                              .then((value) => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return ChatScreen(nickName);
                                      }),
                                    )
                                  });
                        }
                      },
                      child: const Text(
                        'Start Chat',
                        style: TextStyle(color: Colors.black54, fontSize: 25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
