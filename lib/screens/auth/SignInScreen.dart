import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techuni/Constants/Constants.dart';
import 'package:techuni/Models/FirebaseError.dart';
import 'package:techuni/Services/AuthServices.dart';
import 'package:techuni/Utils/Auth/FirebaseError.dart';
import 'package:techuni/widgets/custom_alert_daialog.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenViewState createState() => _SignInScreenViewState();
}

class _SignInScreenViewState extends State<SignInScreen> {
  final GlobalKey<FormState> _signinKey = GlobalKey<FormState>();

  String _email;
  String _password;
  bool _showPassword = false;
  bool isSubmitting; //ローディング用
  String errorMessage = "";

  @override
  void initState() {
    isSubmitting = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    void showAlertDialog(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController _emailControllerField =
                TextEditingController();
            return CustomAlertDialog(
              content: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 4.5,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Text("Please enter email address."),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: _emailControllerField,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Palette.utilColor["grey"],
                            ),
                          ),
                          labelText: "E-Mail",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 35),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(25.0),
                        color: Palette.utilColor["grey"],
                        child: MaterialButton(
                          minWidth: mq.size.width / 2,
                          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                          child: Text(
                            "Send a mail",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            try {
                              FirebaseAuth.instance.sendPasswordResetEmail(
                                  email: _emailControllerField.text);
                              Navigator.of(context).pop();
                            } catch (e) {
                              print(e);
                              // TODO: Add snackbar reporting error
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }

    final emailField = TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'メールアドレスを入力してください';
        } else if (errorMessage != 'パスワードが違います。' && errorMessage != '') {
          return errorMessage;
        }
        return null;
      },
      onChanged: (value) {
        _email = value;
      },
      onSaved: (value) => () {
        _email = value;
      },
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Palette.utilColor["grey"],
      ),
      cursorColor: Palette.utilColor["grey"],
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        labelText: "E-Mail",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final passwordField = Column(
      children: <Widget>[
        TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'パスワードを入力してください';
            } else if (errorMessage == 'パスワードが違います。') {
              print(errorMessage);
              return errorMessage;
            }
            return null;
          },
          obscureText: !_showPassword,
          style: TextStyle(
            color: Palette.utilColor["grey"],
          ),
          cursorColor: Palette.utilColor["grey"],
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            labelText: "Password",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            suffixIcon: IconButton(
              icon:
                  Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
          ),
          onChanged: (value) {
            _password = value;
          },
          onSaved: (value) => () {
            _password = value;
          },
        ),
        Padding(
          padding: EdgeInsets.all(2.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
                child: Text(
                  "Forgot Password？",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.white),
                ),
                onPressed: () {
                  showAlertDialog(context);
                }),
          ],
        ),
      ],
    );

    final fields = Padding(
      padding: EdgeInsets.only(top: 300, bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          emailField,
          passwordField,
        ],
      ),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Palette.utilColor["grey"],
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          setState(() {
            isSubmitting = false;
          });
          errorMessage = '';
          if (_signinKey.currentState.validate()) {
            print("aaaaaa");
            isSubmitting = true;
            _signinKey.currentState.save();
            final FirebaseAuthResultStatus signInResult =
                await AuthService().login(_email, _password);
            if (signInResult != FirebaseAuthResultStatus.Successful) {
              setState(() {
                errorMessage =
                    FirebaseAuthExceptionHandler.exceptionMessage(signInResult);
              });
              _signinKey.currentState.validate();
              isSubmitting = false;
            }
          }
        },
      ),
    );

    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/sign in background.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Form(
        key: _signinKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(36),
          child: Container(
            height: mq.size.height,
            child: Column(
              children: <Widget>[fields, loginButton],
            ),
          ),
        ),
      ),
    ]));
  }
}
