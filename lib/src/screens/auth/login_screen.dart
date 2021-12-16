import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/api/services/auth_services.dart';
import 'package:whatsapp_group_links/static/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key, this.toggleScreen}) : super(key: key);

  static final String id = "LOGIN";

  final Function toggleScreen;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String _email, _passwod;
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);

    _submit() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        await loginProvider.signIn(
          context,
          _email.trim(),
          _passwod.trim(),
        );

        // logging in the user w/ Api
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Billabong',
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Sign in with your email and password  \nor continue with social media.",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40), 
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 10.0,
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => _email = input,
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email),
                              hintText: "Enter your email",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: (input) => !input.contains('@')
                                ? 'Please enter avalid email'
                                : null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              labelText: 'Password',
                              hintText: "Enter your Password",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: (input) => input.length < 4
                                ? 'Must be least 4 characters'
                                : null,
                            onSaved: (input) => _passwod = input,
                            obscureText: true,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              primary: Colors.white,
                              backgroundColor: kPrimaryColor,
                            ),
                            onPressed: _submit,
                            child: loginProvider.isLoading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  )
                                : Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Billabong',
                                      fontSize: 20.0,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account ?"),
                            TextButton(
                              onPressed: () => widget.toggleScreen(),
                              child: Text("Rgister"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (loginProvider.errorMessage != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            margin: EdgeInsets.all(5),
                            color: Colors.amberAccent,
                            child: ListTile(
                              title: Text(loginProvider.errorMessage),
                              leading: Icon(Icons.error),
                              trailing: IconButton(
                                  onPressed: () =>
                                      loginProvider.setErrorMessage(null),
                                  icon: Icon(Icons.close)),
                            ),
                          )
                      ],
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
