import 'dart:async';

import 'package:flutter/material.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  int secondsRemaining = 30;
  bool enableResend = false;
  late Timer timer;
  int correctOtp = 111111;
  late TextEditingController _otpController;
  bool disableTextField = true;

  @override
  initState() {
    super.initState();
    _otpController = TextEditingController();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 60),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: TextField(
                enabled: disableTextField,
                controller: _otpController,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.blue,
                  child: const Text(
                    'Submit',
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  )),
              onTap: () {
                //submission code here
                if (int.parse(_otpController.text) == (correctOtp)) {
                  print("SUCCESSFULL");
                } else {
                  print(" nOT SUCCESSFULL");
                  enableResend = true;
                  secondsRemaining = 0;
                  _otpController.clear();
                  disableTextField = false;
                }
              },
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: enableResend ? _resendCode : null,
              child: Text(
                'Resend Code',
                style: TextStyle(
                  color: enableResend
                      ? Colors.black
                      : Colors.black.withOpacity(0.2),
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'after $secondsRemaining seconds',
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }

  void _resendCode() {
    //other code here
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
      disableTextField = true;
    });
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }
}
