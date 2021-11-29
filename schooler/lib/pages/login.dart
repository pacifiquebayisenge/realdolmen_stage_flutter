import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooler/classes/user.dart' as thisUser;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // TODO: comments + remove prints

  Widget _currWidget = Container();
  Widget _errWidget = Container();
  Widget _succWidget = Container();
  bool _isLogin = false;
  bool _isSucces = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  // login text field controllers
  final _loginEmail = TextEditingController();
  final _loginPwd = TextEditingController();

  // sign up text field controllers
  final _signUpEmail = TextEditingController();
  final _signUpPwd = TextEditingController();
  final _signUpPwd2 = TextEditingController();

  bool _customValidator() {
    RegExp passwordRegex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

    RegExp emailRegex =
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?)*$");

    if (_isLogin == false) {
      if (_signUpEmail.text.isEmpty ||
          _signUpPwd.text.isEmpty ||
          _signUpPwd2.text.isEmpty) {
        _showErrMsg('Please fill in all fields !');
        return false;
      }

      if (!emailRegex.hasMatch(_signUpEmail.text)) {
        _showErrMsg("Please, enter a valid email ! ");
        return false;
      }

      if (_signUpPwd.text != _signUpPwd2.text) {
        _showErrMsg('Passwords do not match !');
        return false;
      }

      if (!passwordRegex.hasMatch(_signUpPwd.text)) {
        _showErrMsg("Password: [ A ,a , 1] \n 8 characters ! ");
        return false;
      }
    } else {
      if (_loginEmail.text.isEmpty || _loginPwd.text.isEmpty) {
        _showErrMsg('Please fill in all fields !');
        return false;
      }

      if (!emailRegex.hasMatch(_loginEmail.text)) {
        _showErrMsg("Please, enter a valid email ! ");
        return false;
      }
    }

    return true;
  }

  // om van login naar sign up te veranderen en omgekeerd
  _changeMode() {
    setState(() {
      // als login true is, toon sign up
      if (_isLogin) {
        _currWidget = Container(
          key: const ValueKey<int>(0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // login op de achtergrond
              ClipPath(
                clipper: LoginClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.6,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30),
                        child: Text(
                          'Login',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: Colors.grey.shade600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // sing up vooraan
              CustomPaint(
                // schaduw van de clipped widget
                painter: SignUpShadowPaint(),
                child: ClipPath(
                  // clip path om de vorm van login te maken
                  clipper: SignUpClipper(),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.6,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: Text(
                                'Sign up',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // onderlijn
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Container(
                              height: 12,
                              margin: const EdgeInsets.only(right: 20),
                              width: 100,
                              child: Card(
                                elevation: 2,
                                color: Colors.indigo.shade800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          margin: const EdgeInsets.only(left: 30),
                          height: 60,
                          child: TextField(
                            controller: _signUpEmail,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.mail,
                                  size: 24,
                                  color: Colors.indigo.shade800,
                                ),
                                labelText: 'Email',
                                labelStyle: GoogleFonts.roboto(
                                    fontSize: 16, color: Colors.grey.shade500)),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          margin: const EdgeInsets.only(left: 30),
                          height: 60,
                          child: TextField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: _signUpPwd,
                            decoration: InputDecoration(
                                icon: Icon(
                                  FontAwesomeIcons.eyeSlash,
                                  size: 24,
                                  color: Colors.indigo.shade800,
                                ),
                                labelText: 'Password',
                                labelStyle: GoogleFonts.roboto(
                                    fontSize: 16, color: Colors.grey.shade500)),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          margin: const EdgeInsets.only(left: 30),
                          height: 60,
                          child: TextField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: _signUpPwd2,
                            decoration: InputDecoration(
                                icon: Icon(
                                  FontAwesomeIcons.eyeSlash,
                                  size: 24,
                                  color: Colors.indigo.shade800,
                                ),
                                labelText: 'Confirm Password',
                                labelStyle: GoogleFonts.roboto(
                                    fontSize: 16, color: Colors.grey.shade500)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ontzichtbare knop om van mode te veranderen
              Positioned(
                top: 5,
                left: 0,
                child: GestureDetector(
                  onTap: _changeMode,
                  child: Container(
                    height: 85,
                    width: 150,
                    color: Colors.transparent,
                  ),
                ),
              ),

              // sign up button
              Positioned(
                left: MediaQuery.of(context).size.width * 0.26,
                bottom: -20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.indigo.shade800,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(1),
                              spreadRadius: -5,
                              blurRadius: 15,
                              offset: const Offset(6, 6),
                            )
                          ]),
                      child: MaterialButton(
                        onPressed: () {
                          _signUp();
                        },
                        elevation: 2,
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

        _isLogin = false;
      }
      //als login false is, toon login
      else {
        _currWidget = Container(
          key: const ValueKey<int>(1),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Sign up achtergrond
              ClipPath(
                clipper: SignUpClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.6,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 30, top: 0, right: 15),
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: Colors.grey.shade500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // login vooraan
              CustomPaint(
                // schaduw van de clipped widget
                painter: LoginShadowPaint(),
                child: ClipPath(
                  // clip path om de vorm van login te maken
                  clipper: LoginClipper(),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.6,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: Text(
                            'Login',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        // onderlijn
                        Container(
                          height: 12,
                          margin: const EdgeInsets.only(left: 30),
                          width: 90,
                          child: Card(
                            elevation: 2,
                            color: Colors.indigo.shade800,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          margin: const EdgeInsets.only(left: 30),
                          height: 60,
                          child: TextField(
                            controller: _loginEmail,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.mail,
                                  size: 24,
                                  color: Colors.indigo.shade800,
                                ),
                                labelText: 'Email',
                                labelStyle: GoogleFonts.roboto(
                                    fontSize: 16, color: Colors.grey.shade500)),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          margin: const EdgeInsets.only(left: 30),
                          height: 60,
                          child: TextField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: _loginPwd,
                            decoration: InputDecoration(
                                icon: Icon(
                                  FontAwesomeIcons.eyeSlash,
                                  size: 24,
                                  color: Colors.indigo.shade800,
                                ),
                                labelText: 'Password',
                                labelStyle: GoogleFonts.roboto(
                                    fontSize: 16, color: Colors.grey.shade500)),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 28),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Text(
                                'Forgot Password ?',
                                style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.indigo.shade800),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // ontzichtbare knop om van mode te veranderen
              Positioned(
                top: 5,
                right: 0,
                child: GestureDetector(
                  onTap: _changeMode,
                  child: Container(
                    height: 85,
                    width: 150,
                    color: Colors.transparent,
                  ),
                ),
              ),
              // login knop
              Positioned(
                  left: MediaQuery.of(context).size.width * 0.26,
                  bottom: -20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.indigo.shade800,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(1),
                                spreadRadius: -5,
                                blurRadius: 15,
                                offset: const Offset(6, 6),
                              )
                            ]),
                        child: MaterialButton(
                          onPressed: () {
                            _login();
                          },
                          elevation: 2,
                          child: Text(
                            'Log in',
                            style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        );

        _isLogin = true;
      }
    });
  }

  _signUp() async {
    if (_customValidator() == false) return;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _signUpEmail.text, password: _signUpPwd.text);
      setState(() {
        _isSucces = true;
      });

      thisUser.User.newUser(
              uid: userCredential.user!.uid, email: _signUpEmail.text)
          .then((value) {
        _showSuccesMsg();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showErrMsg('The password provided is too weak !');
      }
      if (e.code == 'email-already-in-use') {
        _showErrMsg('The account already exists for that email !');
      }
    } catch (e) {
      _showErrMsg('Something went wrong, please try again later.');
      print(e);
    }
  }

  _login() async {
    if (_customValidator() == false) return;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _loginEmail.text, password: _loginPwd.text);

      setState(() {
        _isSucces = true;
      });
      _showSuccesMsg();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showErrMsg('No user found for that email.');
      }
      if (e.code == 'wrong-password') {
        _showErrMsg('Wrong password provided for that user.');
      }
    } catch (e) {
      _showErrMsg('Something went wrong, please try again later.');
      print(e);
    }
  }

  _showSuccesMsg() {
    String text = 'User is succesfully registred';

    if (_isLogin) text = 'Login Succesfull';
    setState(() {
      _succWidget = Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
            color: Colors.green, fontWeight: FontWeight.w700),
      );
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
// Here you can write your code

      setState(() {
        // Here you can write your code for open new view
        _succWidget = Container();
        _isSucces = false;
        if (_isLogin == false) _changeMode();
        if (_isLogin == true) {
          print("NAVIGATE");
        }
      });
    });
  }

  _showErrMsg(String text) {
    setState(() {
      _errWidget = Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
            color: Colors.red, fontWeight: FontWeight.w700),
      );
    });
    Future.delayed(const Duration(milliseconds: 5000), () {
// Here you can write your code

      setState(() {
        // Here you can write your code for open new view
        _errWidget = Container();
      });
    });
  }

  @override
  initState() {
    super.initState();

    // methode om te wachten tot alle widgets gebouwd zijn
    WidgetsBinding.instance!.addPostFrameCallback((_) => _changeMode());
  }

  @override
  void dispose() {
    // login text field controllers
    _loginEmail.dispose();
    _loginPwd.dispose();

    // sign up text field controllers
    _signUpEmail.dispose();
    _signUpPwd.dispose();
    _signUpPwd2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.indigo.shade800,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'lib/images/81.png',
            ),
            repeat: ImageRepeat.repeat,
            fit: BoxFit.scaleDown,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Text(
              'Schooler',
              style: GoogleFonts.montserrat(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Stack(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _currWidget,
                  ),
                  Positioned(
                    bottom: 20,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            margin: const EdgeInsets.only(left: 40),
                            height: 60,
                            child:
                                _isSucces == true ? _succWidget : _errWidget),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// clip punten om de vorm van de widget te bepalen
// aangepast naar eigen smaakt
// bron: https://github.com/mohit67890/Login-UI/blob/master/lib/main.dart
class LoginClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clip = Path();

    clip.moveTo(0, 70);
    clip.lineTo(0, size.height - 70);
    clip.quadraticBezierTo(0, size.height, 70, size.height);

    clip.lineTo(size.width - 70, size.height);
    clip.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 70);

    clip.lineTo(size.width, size.height / 10 * 0.3 + 50);
    clip.quadraticBezierTo(size.width, size.height * 0.25, size.width - 50,
        size.height * 0.3 - 50);

    clip.lineTo(70, 0);
    clip.quadraticBezierTo(0, 0, 0, 70);
    clip.close();

    return clip;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SignUpClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clip = Path();
    clip.moveTo(size.width, 70);
    clip.lineTo(size.width, size.height - 70);
    clip.quadraticBezierTo(
        size.width, size.height, size.width - 70, size.height);

    clip.lineTo(70, size.height);
    clip.quadraticBezierTo(0, size.height, 0, size.height - 70);

    clip.lineTo(0, size.height / 10 * 0.3 + 50);
    clip.quadraticBezierTo(5, size.height * 0.23, 40, size.height * 0.25 - 20);
    clip.lineTo(size.width - 75, 5);

    clip.quadraticBezierTo(size.width, 0, size.width, 70);

    clip.close();
    return clip;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class LoginShadowPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path clip = Path();

    clip.moveTo(0, 70);
    clip.lineTo(-10, size.height - 70);
    clip.quadraticBezierTo(0, size.height + 5, 60, size.height + 5);

    clip.lineTo(size.width - 50, size.height + 5);
    clip.quadraticBezierTo(
        size.width, size.height, size.width + 10, size.height - 70);

    clip.lineTo(size.width + 10, size.height * 0.3 + 50);
    clip.quadraticBezierTo(size.width + 5, size.height * 0.2, size.width - 200,
        size.height * 0.2 - 25);

    clip.lineTo(70, 0);
    clip.quadraticBezierTo(0, 0, 0, 70);
    clip.close();

    canvas.drawShadow(clip, Colors.black, 5, true);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class SignUpShadowPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path clip = Path();
    clip.moveTo(size.width, 50);
    clip.lineTo(size.width + 10, size.height - 70);
    clip.quadraticBezierTo(
        size.width + 5, size.height + 5, size.width - 50, size.height + 5);

    clip.lineTo(70, size.height + 5);
    clip.quadraticBezierTo(-10, size.height + 10, -10, size.height - 65);

    clip.lineTo(0, size.height * 0.3 + 50);
    clip.quadraticBezierTo(0, size.height * 0.3, 50, size.height * 0.3 - 30);
    clip.lineTo(size.width - 70, 0);

    clip.quadraticBezierTo(size.width, 0, size.width, 70);

    clip.close();
    canvas.drawShadow(clip, Colors.black, 5, true);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

/*
                  // Sign in
                  _isLogin?
                  Positioned(
                    child: Container(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Sign up achtergrond
                          Container(
                            child: ClipPath(
                              clipper: SignUpClipper(),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.6,
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 30, top: 0, right: 15),
                                      child: Text(
                                        'Sign up',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 30,
                                          color: Colors.grey.shade500
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ),
                          ),

                          CustomPaint(
                            // schaduw van de clipped widget
                            painter: LoginShadowPaint(),
                            child: ClipPath(
                              // clip path om de vorm van login te maken
                              clipper: LoginClipper(),
                              child: Container(
                                height:
                                MediaQuery.of(context).size.height / 1.6,
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration:
                                const BoxDecoration(color: Colors.white,

                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 30),
                                      child: Text(
                                        'Login',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 12,
                                      margin: EdgeInsets.only(left: 30),
                                      width: 90,
                                      child: Card(
                                        elevation: 2,
                                        color: Colors.indigo.shade800,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      margin: EdgeInsets.only(left: 30),
                                      height: 60,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.mail,
                                              size: 24,
                                              color: Colors.indigo.shade800,
                                            ),
                                            labelText: 'Email',
                                            labelStyle: GoogleFonts.roboto(
                                                fontSize: 16,
                                                color: Colors.grey.shade500)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      margin: EdgeInsets.only(left: 30),
                                      height: 60,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            icon: Icon(
                                              FontAwesomeIcons.eyeSlash,
                                              size: 24,
                                              color: Colors.indigo.shade800,
                                            ),
                                            labelText: 'Password',
                                            labelStyle: GoogleFonts.roboto(
                                                fontSize: 16,
                                                color: Colors.grey.shade500)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 28),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Spacer(),
                                          Text(
                                            'Forgot Password ?',
                                            style: GoogleFonts.roboto(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.indigo.shade800),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                           Positioned(
                              left: MediaQuery.of(context).size.width*0.27,
                              bottom: -15,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 120,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.indigo.shade800,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(30),),
                                        boxShadow: [
                                          BoxShadow(

                                            color: Colors.black.withOpacity(1),
                                            spreadRadius: -5,
                                            blurRadius: 15,
                                            offset: const Offset(6, 6),

                                          )
                                        ] ),
                                    child: MaterialButton(
                                      onPressed: () {},
                                      elevation: 2,
                                      child: Text(
                                        'Log in',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ))

                        ],
                      ),
                    ),
                  ):


                  // Sign up
                  Positioned(
                    child: Container(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // login op de achtergrond
                          Container(
                            child: ClipPath(
                              clipper: LoginClipper(),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.6,
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 30),
                                      child: Text(
                                        'Login',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 30,
                                            color: Colors.grey.shade500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // sing up vooraan
                          CustomPaint(
                            // schaduw van de clipped widget
                            painter: SignUpShadowPaint(),
                            child: ClipPath(
                              // clip path om de vorm van login te maken
                              clipper: SignUpClipper(),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.6,
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 15),
                                          child: Text(
                                            'Sign up',
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 30,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Container(
                                          height: 12,
                                          margin: EdgeInsets.only(right: 20),
                                          width: 100,
                                          child: Card(
                                            elevation: 2,
                                            color: Colors.indigo.shade800,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      margin: EdgeInsets.only(left: 30),
                                      height: 60,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.mail,
                                              size: 24,
                                              color: Colors.indigo.shade800,
                                            ),
                                            labelText: 'Email',
                                            labelStyle: GoogleFonts.roboto(
                                                fontSize: 16,
                                                color: Colors.grey.shade500)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      margin: EdgeInsets.only(left: 30),
                                      height: 60,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            icon: Icon(
                                              FontAwesomeIcons.eyeSlash,
                                              size: 24,
                                              color: Colors.indigo.shade800,
                                            ),
                                            labelText: 'Password',
                                            labelStyle: GoogleFonts.roboto(
                                                fontSize: 16,
                                                color: Colors.grey.shade500)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      margin: EdgeInsets.only(left: 30),
                                      height: 60,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            icon: Icon(
                                              FontAwesomeIcons.eyeSlash,
                                              size: 24,
                                              color: Colors.indigo.shade800,
                                            ),
                                            labelText: 'Confirm Password',
                                            labelStyle: GoogleFonts.roboto(
                                                fontSize: 16,
                                                color: Colors.grey.shade500)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: MediaQuery.of(context).size.width * 0.27,
                            bottom: -15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 120,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.indigo.shade800,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(1),
                                          spreadRadius: -5,
                                          blurRadius: 15,
                                          offset: const Offset(6, 6),
                                        )
                                      ]),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    elevation: 2,
                                    child: Text(
                                      'Sign up',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white70),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

*/
