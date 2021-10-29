import 'dart:async';
import 'package:alpaca/screens/profile/profile_pages/get_support/get_support.dart';
import 'package:alpaca/shared/buttons.dart';
import 'package:alpaca/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailSender extends StatefulWidget {
  const EmailSender({Key? key}) : super(key: key);

  @override
  _EmailSenderState createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  bool isHTML = false;

  final _supportEmail = 'crunchapp2021@gmail.com';

  final _emailSubject = 'Crunch: Contact Support';

  final _emailController = TextEditingController(text: '');

  final _bodyController = TextEditingController(
    text: '',
  );

  Future<void> send() async {
    final String contactEmailSendToSupport =
        'User Email:$_emailController \n User Message: $_bodyController';
    final Email email = Email(
      body: contactEmailSendToSupport,
      subject: _emailSubject,
      recipients: [_supportEmail],
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      platformResponse = 'E-mail provider is not available.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(platformResponse),
        ),
      );
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contact Support',
                  style: Theme.of(context).textTheme.headline1!.merge(
                        const TextStyle(
                          color: AlpacaColor.blackColor,
                        ),
                      ),
                ),
              ),
              AlpacaTextFieldWithLabel(
                controller: _emailController,
                labelText: 'Your Email',
              ),
              AlpacaTextFieldWithLabel(
                controller: _bodyController,
                labelText: 'Your Message',
                maxLines: null,
                expands: true,
              ),
              AlpacaIconButton(
                onPressed: send,
                icon: Icons.send,
                label: 'Send',
              )
            ],
          ),
        ),
      ),
    );
  }
}
