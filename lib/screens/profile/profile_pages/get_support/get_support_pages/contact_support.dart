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

  final _recipientController = TextEditingController(
    text: 'Lennart.Stachowiak@gmail.com',
  );

  final _subjectController =
      TextEditingController(text: 'Crunch: Contact Support');

  final _emailController = TextEditingController(text: '');

  final _bodyController = TextEditingController(
    text: '',
  );

  Future<void> send() async {
    final String bodyAndEmail =
        'User Email:$_emailController \n User Message: $_bodyController';
    final Email email = Email(
      body: bodyAndEmail,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(color: AlpacaColor.blackColor),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your Email',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _bodyController,
                    maxLines: null,
                    expands: true,
                    style: const TextStyle(color: AlpacaColor.blackColor),
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      labelText: 'Your Message',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AlpacaColor.primary100,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        AlpacaColor.white100Color,
                      ),
                    ),
                    onPressed: send,
                    icon: const Icon(Icons.send),
                    label: const Text('Send'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
