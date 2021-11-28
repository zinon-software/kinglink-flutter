import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_group_links/src/api/auth_services.dart';
import 'package:whatsapp_group_links/src/utility/widget_handler.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key, this.toggleScreen}) : super(key: key);

  static final String id = "SINGNUP";
  final Function toggleScreen;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String _username, _email, _password;

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<AuthServices>(context);

    _submit() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        await signupProvider.signUp(
          context,
          _username.trim(),
          _email.trim(),
          _password.trim(),
        );
        // sign up in the user w/ API
      }
    }

    

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  WidgetHandler.nameApp,
                  style: TextStyle(
                    fontFamily: "Billabong",
                    fontSize: 50.0,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Username",
                          ),
                          validator: (input) => input.trim().isEmpty
                              ? 'Please enter avalid Username'
                              : null,
                          onSaved: (input) => _username = input,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Email"),
                          validator: (input) => !input.contains('@')
                              ? 'Please enter avalid email'
                              : null,
                          onSaved: (input) => _email = input,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Password",
                          ),
                          validator: (input) => input.length < 6
                              ? 'Must be least 6 characters'
                              : null,
                          onSaved: (input) => _password = input,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        width: 250.0,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: _submit,
                          color: Colors.blue,
                          padding: EdgeInsets.all(10.0),
                          minWidth:
                              signupProvider.isLoading ? null : double.infinity,
                          child: signupProvider.isLoading
                              ? CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Billabong",
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
                          Text("Do have an account ?"),
                          TextButton(
                            onPressed: () => widget.toggleScreen(),
                            child: Text(
                              "Back to LOGIN",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      if (signupProvider.errorMessage != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          color: Colors.amberAccent,
                          child: ListTile(
                            title: Text(signupProvider.errorMessage),
                            leading: Icon(Icons.error),
                            trailing: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () =>
                                  signupProvider.setErrorMessage(null),
                            ),
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
    );
  }
}
