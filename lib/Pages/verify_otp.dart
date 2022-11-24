import 'package:document_solution/Pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({Key? key,required this.mobile,required this.verificationId}) : super(key: key);

  final String mobile;
  final String verificationId;

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {

  TextEditingController otpController = TextEditingController();
  bool otpError = false;

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
                  'Verify OTP',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                child: Text(
                  'OTP has been sent to ${widget.mobile}',
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    onChanged: (t){
                      setState((){
                        otpError = false;
                      });
                      if(otpController.text.trim().length >6){
                        otpError = true;
                      }

                    },
                    keyboardType: TextInputType.number,
                    controller: otpController,
                    decoration: InputDecoration(
                      hintText: 'Enter Otp',
                      errorText: (otpError)?'Enter Valid OTP':null
                    ),

                  ),),
              Container(
                margin: const EdgeInsets.all(20),
                child: ElevatedButton(
                  child: const Text('VERIFY'),
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (otpController.text.trim().length == 6) {

                      verifyOtp(otpController.text.trim());

                    } else {
                      otpError = true;
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

  void verifyingOTP(context){
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.all(10),
            child: const Text('Verifying OTP..'),
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

  void verifyOtp(otp) {
    verifyingOTP(context);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    MyApp.auth.signInWithCredential(credential).then((value) {
      //store data to db
      DatabaseReference db = FirebaseDatabase.instance.ref('Users');
      db
          .child('${MyApp.auth.currentUser?.phoneNumber}')
          .set(MyApp.auth.currentUser?.uid);
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
      );
    }).catchError((error, stackTrace) {
      Navigator.pop(context);
      setState((){
        otpError = true;
      });
    });
  }
}
