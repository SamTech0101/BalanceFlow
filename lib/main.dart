import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:telephony/telephony.dart';

String _message = "No SMS";
String matchResult = '';

// Define regex patterns for different SMS types

final atmWithdrawalRegex = RegExp(r'Dear (\S+) Customer, (\S+) withdrawn at (\S+) ATM (\S+) from (\S+) on (\d{2}[A-Za-z]{3}\d{2}) Transaction Number (\d+). Available Balance (\S+)', caseSensitive: false);

final RegExp creditSmsRegex = RegExp(
  r'Dear (\S+) UPI User, ur A/c(\S+) credited by Rs(\d+) on (\d{2}[A-Za-z]{3}\d{2}) by \(Ref no (\d+)\)',
);

final RegExp upiSmsRegex = RegExp(
  r'Dear UPI user A/C (\S+) debited by (\d+\.\d+) on date (\d{2}[A-Za-z]{3}\d{2}) trf to ([\w\s]+) Refno (\d+)',
);

onBackgroundMessage(SmsMessage message) {
  if (message.body != null) {
    if (atmWithdrawalRegex.hasMatch(message.body!)) {
      final matches = atmWithdrawalRegex.firstMatch(message.body!);
      debugPrint("Sms Body match string 0   ${matches!.group(0)}");
      debugPrint("Sms Body match string 1   ${matches!.group(1)}");
      debugPrint("Sms Body match string 2   ${matches!.group(2)}");
      debugPrint("Sms Body match string 3   ${matches!.group(3)}");
      debugPrint("Sms Body match string 4   ${matches!.group(4)}");
      debugPrint("Sms Body match string 5   ${matches!.group(5)}");
      debugPrint("Sms Body match string 6   ${matches!.group(6)}");
      debugPrint("Sms Body match string 7   ${matches!.group(7)}");
      debugPrint("Sms Body match string 8   ${matches!.group(8)}");


      matchResult = "ATM Withdrawal: Bank: ${matches?.group(1)}, Amount: ${matches?.group(2)}, ATM ID: ${matches?.group(4)}, Account: ${matches?.group(5)}, Date: ${matches?.group(6)}, Transaction #: ${matches?.group(7)}, Balance: ${matches?.group(8)}";

    } else if (creditSmsRegex.hasMatch(message.body!)) {

      final matches = creditSmsRegex.firstMatch(message.body!);
      matchResult = "Credit Transaction: Bank: ${matches?.group(1)}, Account: ${matches?.group(2)}, Amount Credited: ${matches?.group(3)}, Date: ${matches?.group(4)}, Ref No: ${matches?.group(5)}";
    } else if (upiSmsRegex.hasMatch(message.body!)) {
      final matches = upiSmsRegex.firstMatch(message.body!);
      matchResult = "UPI Debit: Account: ${matches?.group(1)}, Amount Debited: ${matches?.group(2)}, Date: ${matches?.group(3)}, Recipient: ${matches?.group(4)}, Ref No: ${matches?.group(5)}";
    } else {
      matchResult = "Received SMS does not match expected formats.";
    }


      _message = matchResult;
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

    // final regex = RegExp(r'Dear(\s([A-Za-z]+\s)+)Customer, [A-Za-z]+\.[0-9]+ [A-Za-z]+ at [A-Za-z]+ [A-Za-z]+ [A-Za-z0-9]+ from [A-Za-z0-9]+\/[A-Za-z0-9]+ on [A-Za-z0-9]+ Transaction Number [0-9]+\. Available Balance [A-Za-z]+([+-]?(?=\.\d|\d)(?:\d+)?(?:\.?\d*))(?:[Ee]([+-]?\d+))?\.', caseSensitive: false);

    // final regex = RegExp(r'Dear (\S+) Customer, (\S+) withdrawn at (\S+) ATM (\S+) from (\S+) on (\d{2}[A-Za-z]{3}\d{2}) Transaction Number (\d+). Available Balance (\S+)', caseSensitive: false);
    // final regex = RegExp(
    //     r'Dear (\S+) Customer, Rs\.(\d+) withdrawn at \S+ ATM (\S+) from A\/c(\S+) on (\d{2}[A-Za-z]{3}\d{2}) Transaction Number (\d+)\. Available Balance Rs\.(\d+\.\d+).*',
    //     caseSensitive: false
    // );


    debugPrint("Sms Body is  ${message.body}");
    debugPrint("Sms Body status  ${atmWithdrawalRegex.hasMatch(message.body!)}");
    if (message.body != null) {
      if (atmWithdrawalRegex.hasMatch(message.body!)) {
        final matches = atmWithdrawalRegex.firstMatch(message.body!);
        debugPrint("Sms Body match string 0   ${matches!.group(0)}");
        debugPrint("Sms Body match string 1   ${matches!.group(1)}");
        debugPrint("Sms Body match string 2   ${matches!.group(2)}");
        debugPrint("Sms Body match string 3   ${matches!.group(3)}");
        debugPrint("Sms Body match string 4   ${matches!.group(4)}");
        debugPrint("Sms Body match string 5   ${matches!.group(5)}");
        debugPrint("Sms Body match string 6   ${matches!.group(6)}");
        debugPrint("Sms Body match string 7   ${matches!.group(7)}");
        debugPrint("Sms Body match string 8   ${matches!.group(8)}");


        matchResult = "ATM Withdrawal: Bank: ${matches?.group(1)}, Amount: ${matches?.group(2)}, ATM ID: ${matches?.group(4)}, Account: ${matches?.group(5)}, Date: ${matches?.group(6)}, Transaction #: ${matches?.group(7)}, Balance: ${matches?.group(8)}";

      } else if (creditSmsRegex.hasMatch(message.body!)) {

        final matches = creditSmsRegex.firstMatch(message.body!);
        matchResult = "Credit Transaction: Bank: ${matches?.group(1)}, Account: ${matches?.group(2)}, Amount Credited: ${matches?.group(3)}, Date: ${matches?.group(4)}, Ref No: ${matches?.group(5)}";
      } else if (upiSmsRegex.hasMatch(message.body!)) {
        final matches = upiSmsRegex.firstMatch(message.body!);
        matchResult = "UPI Debit: Account: ${matches?.group(1)}, Amount Debited: ${matches?.group(2)}, Date: ${matches?.group(3)}, Recipient: ${matches?.group(4)}, Ref No: ${matches?.group(5)}";
      } else {
        matchResult = "Received SMS does not match expected formats.";
      }

      setState(() {
        // _message = message.body ?? "Error reading message body.";
        debugPrint("Sms message is  ${_message}");

        _message = matchResult;

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("Latest received SMS: $_message")),
            TextButton(
                onPressed: () async {
                  // await telephony.openDialer("1234567890");
                  setState(() {
                    _message = matchResult;

                  });
                },
                child: Text('Open Dialer')
            ),

          ],
        ),
      ),
    );
  }
}
