import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:telephony/telephony.dart';
import 'package:smartxp/File Operations.dart';
String _message = "No SMS";
String matchResult = '';

// Define regex patterns for different SMS types

final atmWithdrawalRegex = RegExp(r'Dear (\S+) Customer, (.*?) withdrawn at (.*?) ATM (.*?) from (.*?) on (.*?) Transaction Number (.*?). Available Balance (\S+)', caseSensitive: false);

final RegExp debitedRegex = RegExp(
  r'Dear (\S+) user (.*?) debited by (\S+) on date (.*?) trf to (.*?) Refno (\d+)',
);
final RegExp creditSmsRegex = RegExp(
  r'Dear (\S+) (\S+) User, ur (.*?) credited by (\S+) on (\S+) by \(Ref (\S+)\)',
);
// Define a list to store all messages
List<String> messages = [];

//Dear SBI UPI User, ur A/ cX0273 credited by Rs20 on 13Nov23 by (Ref no564654654646)
//Dear UPI user A/C X3327 debited by 210.0 on date 01 Dec23 trf to RAGHAV SINGH SO Refno 333552183075. If not u? call
// 1800111109. -SBI
onBackgroundMessage(SmsMessage message) {
  if (message.body != null) {
    if (atmWithdrawalRegex.hasMatch(message.body!)) {
      final matches = atmWithdrawalRegex.firstMatch(message.body!);
      matchResult = "ATM Withdrawal: Bank: ${matches?.group(1)}, Amount: ${matches?.group(2)}, ATM ID: ${matches?.group(4)}, Account: ${matches?.group(5)}, Date: ${matches?.group(6)}, Transaction #: ${matches?.group(7)}, Balance: ${matches?.group(8)}";
    } else if (creditSmsRegex.hasMatch(message.body!)) {
      final matches = creditSmsRegex.firstMatch(message.body!);
      matchResult = "Credit Transaction: Bank: ${matches?.group(1)} ${matches!.group(2)}, Account: ${matches?.group(3)}, Amount Credited: ${matches?.group(4)}, Date: ${matches?.group(5)}, Ref : ${matches?.group(6)}";
    } else if (debitedRegex.hasMatch(message.body!)) {
      final matches = debitedRegex.firstMatch(message.body!);
      matchResult = "${matches?.group(1)} Debit: Account: ${matches?.group(2)}, Amount Debited: ${matches?.group(3)}, Date: ${matches?.group(4)}, Recipient: ${matches?.group(5)}, Ref No: ${matches?.group(6)}";
    } else {
      matchResult = "Received SMS does not match expected formats.";
    }


    messages.add(matchResult);

    debugPrint("onBackgroundMessage called: ${_message}");

  } else {
      _message = "Error reading message body.";
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final telephony = Telephony.instance;



  @override
  void initState() {
    super.initState();
    initPlatformState();
    loadMessages();
  }
  void loadMessages() async {
    List<String> loadedMessages = await SmsStorage().readSMS();
    setState(() {
      messages = loadedMessages;
    });
  }

  /*onSendStatus(SendStatus status) {
    setState(() {
      _message = status == SendStatus.SENT ? "Sent" : "Delivered";
    });
  }
*/
  Future<void> initPlatformState() async {
    // Check and request SMS permissions at runtime using permission_handler
    var status = await Permission.sms.status;
    debugPrint("Initial SMS permission status: ${status}");

    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      status = await Permission.sms.request();
      debugPrint("SMS permission status after request: ${status}");

    }

    if (status.isGranted) {
      // Permission is granted, listen for incoming SMS
      telephony.listenIncomingSms(
          onNewMessage: onMessage,
          onBackgroundMessage: onBackgroundMessage,
          listenInBackground: true
      );

        debugPrint('onBackgroundMessage --- foreground is ${matchResult} .');

    } else {
      debugPrint('SMS permission denied by user.');
    }
  }

  onMessage(SmsMessage message) async {




    debugPrint("Sms Body is  ${message.body}");
    debugPrint("Sms Body status  ${atmWithdrawalRegex.hasMatch(message.body!)}");
    if (message.body != null) {
      if (atmWithdrawalRegex.hasMatch(message.body!)) {
        final matches = atmWithdrawalRegex.firstMatch(message.body!);
        matchResult = "ATM Withdrawal: Bank: ${matches?.group(1)}, Amount: ${matches?.group(2)}, ATM ID: ${matches?.group(4)}, Account: ${matches?.group(5)}, Date: ${matches?.group(6)}, Transaction #: ${matches?.group(7)}, Balance: ${matches?.group(8)}";
      } else if (creditSmsRegex.hasMatch(message.body!)) {
        final matches = creditSmsRegex.firstMatch(message.body!);
        matchResult = "Credit Transaction: Bank: ${matches?.group(1)} ${matches!.group(2)}, Account: ${matches?.group(3)}, Amount Credited: ${matches?.group(4)}, Date: ${matches?.group(5)}, Ref : ${matches?.group(6)}";
      } else if (debitedRegex.hasMatch(message.body!)) {
        final matches = debitedRegex.firstMatch(message.body!);
        matchResult = "${matches?.group(1)} Debit: Account: ${matches?.group(2)}, Amount Debited: ${matches?.group(3)}, Date: ${matches?.group(4)}, Recipient: ${matches?.group(5)}, Ref No: ${matches?.group(6)}";
      } else {
        matchResult = "Received SMS does not match expected formats.";
      }
      await SmsStorage().writeSMS(matchResult);
      setState(() {
        // _message = message.body ?? "Error reading message body.";
        debugPrint("Sms message is  ${_message}");

        messages.add(matchResult);


      });
    } else {
      setState(() {
        _message = "Error reading message body.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
          body: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(messages[index]),
              );
            },
          ),
      ),
    );
  }
}
