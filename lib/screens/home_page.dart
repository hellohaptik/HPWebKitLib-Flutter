import 'dart:io';

import 'package:flutter/material.dart';

import 'bot_launcher.dart';
import 'widgets/primary_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textFieldController = TextEditingController();
  String _launchMessage = '';

  void _onButtonPressed() {
    setState(() {
      _launchMessage = _textFieldController.text;
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Haptik Flutter Example"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(
                labelText: 'Enter Launch Message',
                hintText: "Empty if no Launch Message",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  text: "Guest Sign Up",
                  onPressed: () {
                    if (Platform.isIOS) {
                      BotLaunch().iosGuestBot();
                    } else {
                      BotLaunch().androidGuestBot();
                    }
                  },
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: PrimaryButton(
                  text: "Custom Sign Up",
                  onPressed: () {
                    _onButtonPressed();
                    if (Platform.isIOS) {
                      BotLaunch().iosCustomBot(_launchMessage);
                    } else {
                      BotLaunch().androidCustomBot(_launchMessage);
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
}
