import 'package:document_solution/Pages/verify_otp.dart';
import 'package:document_solution/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController numController = TextEditingController();
  TextEditingController verifyController = TextEditingController();
  String mobileNum = '';
  String verificationId = '';
  DatabaseReference db = FirebaseDatabase.instance.ref('User');

  bool otpError = false;

  void showSnackbar(String text) {
    SnackBar snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Image.asset('assets/images/logo.png')),
              Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                child: const Text(
                  'With a valid phone number you can access our services.',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: IntlPhoneField(
                    controller: numController,
                    decoration: const InputDecoration(
                      hintText: 'Enter phone number',
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      mobileNum = phone.completeNumber;
                    },
                  )),
              Container(
                margin: const EdgeInsets.all(20),
                child: ElevatedButton(
                  child: const Text('GET OTP'),
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (numController.text.trim().length == 10) {
                      signupUser(mobileNum, context);
                    } else {
                      showSnackbar('Number is invalid');
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void sendingOTP(context){
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.all(10),
            child: const Text('Sending OTP..'),
          )
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context){
      return alertDialog;
    });
  }


  void signupUser(String number, BuildContext context) async {
    sendingOTP(context);
    MyApp.auth.verifyPhoneNumber(
        phoneNumber: number,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          if (kDebugMode) {
            print('verification complete ${phoneAuthCredential.smsCode}');
          }
          
        },
        verificationFailed: (FirebaseAuthException e) {
          if (kDebugMode) {
            print('verification complete${e.message}');
          }
        },
        codeSent: (String vId, int? forceResendingToken) {
          Navigator.pop(context);
          verificationId = vId;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyOtpPage(mobile: number,verificationId: vId,),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String c) {});
  }

}
