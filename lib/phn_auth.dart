import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth/otp.dart';

class PhnAuth extends StatefulWidget {
  const PhnAuth({super.key});

  @override
  State<PhnAuth> createState() => _PhnAuthState();
}

class _PhnAuthState extends State<PhnAuth> {
  TextEditingController phncntroler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Authriztion"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: phncntroler,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter the phone no.",
                suffixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(height: 27),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException ex) {},
                  codeSent: (String verificationid, int? resendtoken) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>  OtpScreen(verificationid: verificationid,)));
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                  phoneNumber: phncntroler.text.toString());
            },
            child: const Text("Verify the Number"),
          ),
        ],
      ),
    );
  }
}
