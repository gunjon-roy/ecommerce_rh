import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerifyOTPScreen extends StatefulWidget {
  VerifyOTPScreen({required this.txtFormText, required this.appSingnatureID});

  String? txtFormText;
  String? appSingnatureID;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> with CodeAutoFill {
  String codeValue = "";
  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;
  @override
  void codeUpdated() {
    print("Update code $code");
    setState(() {
      print("codeUpdated");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenOtp();

    timer = Timer.periodic(Duration(seconds: 1), (_) {
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

  void listenOtp() async {
    await SmsAutoFill().unregisterListener();
    listenForCode();
    await SmsAutoFill().listenForCode;
    print("OTP listen Called");

    setState(() {
      secondsRemaining = 30;
      enableResend = false;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    SmsAutoFill().unregisterListener();
    print("unregisterListener");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: PinFieldAutoFill(
                currentCode: codeValue,
                codeLength: 4,
                onCodeChanged: (code) {
                  print("onCodeChanged $code");
                  setState(() {
                    codeValue = code.toString();
                  });
                },
                onCodeSubmitted: (val) {
                  print("onCodeSubmitted $val");
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  print(codeValue);

                  print(widget.txtFormText);
                  print(widget.appSingnatureID);
                },
                child: const Text("Verify OTP")),
            ElevatedButton(
              onPressed: enableResend ? listenOtp : null,
              child: enableResend
                  ? Text("Resend ")
                  : Text(
                      'Resend after $secondsRemaining seconds',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
