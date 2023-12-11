import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_bloc.dart';
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_event.dart';
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_state.dart';
import 'package:BalanceFlow/bloc/theme/theme_bloc.dart';
import 'package:BalanceFlow/bloc/theme/theme_event.dart';
import 'package:BalanceFlow/bloc/theme/theme_state.dart';
import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/ui/screens/transactions_screen.dart';
import 'package:BalanceFlow/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'core/service_locator.dart';
import 'model/transaction_type_adapter.dart';
import 'utils/constants.dart';
String _message = "No SMS";
String matchResult = '';


// Define a list to store all messages
List<String> messages = [];

//Dear SBI UPI User, ur A/ cX0273 credited by Rs20 on 13Nov23 by (Ref no564654654646)
//Dear UPI user A/C X3327 debited by 210.0 on date 01 Dec23 trf to RAGHAV SINGH SO Refno 333552183075. If not u? call
// 1800111109. -SBI
// onBackgroundMessage(SmsMessage message) async {
//   if (message.body != null) {
//     if (atmWithdrawalRegex.hasMatch(message.body!)) {
//       final matches = atmWithdrawalRegex.firstMatch(message.body!);
//       matchResult = "ATM Withdrawal: Bank: ${matches?.group(1)}, Amount: ${matches?.group(2)}, ATM ID: ${matches?.group(4)}, Account: ${matches?.group(5)}, Date: ${matches?.group(6)}, Transaction #: ${matches?.group(7)}, Balance: ${matches?.group(8)}";
//     } else if (creditSmsRegex.hasMatch(message.body!)) {
//       final matches = creditSmsRegex.firstMatch(message.body!);
//       matchResult = "Credit Transaction: Bank: ${matches?.group(1)} ${matches!.group(2)}, Account: ${matches?.group(3)}, Amount Credited: ${matches?.group(4)}, Date: ${matches?.group(5)}, Ref : ${matches?.group(6)}";
//     } else if (debitedRegex.hasMatch(message.body!)) {
//       final matches = debitedRegex.firstMatch(message.body!);
//       matchResult = "${matches?.group(1)} Debit: Account: ${matches?.group(2)}, Amount Debited: ${matches?.group(3)}, Date: ${matches?.group(4)}, Recipient: ${matches?.group(5)}, Ref No: ${matches?.group(6)}";
//     } else {
//       matchResult = "Received SMS does not match expected formats.";
//     }
//
//
//     messages.add(matchResult);
//
//     debugPrint("onBackgroundMessage called: ${message.body}");
//     // await SmsStorage().writeSMS(matchResult);
//
//   } else {
//       _message = "Error reading message body.";
//   }
// }

void main() async {
  setupLocator();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(TransactionMessageAdapter());
  await Hive.openBox(hiveThemeKey);
  await Hive.openBox<TransactionMessage>(hiveTransactionKey);
   await Hive.openBox<List<String>>(hiveSMSKey);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp>  {
  // final telephony = Telephony.instance;


  @override
  void initState() {
    super.initState();
    initPlatformState();

  }
  // void loadMessages() async {
  //   List<String> loadedMessages = await SmsStorage().readSMS();
  //   setState(() {
  //     messages = loadedMessages;
  //   });
  // }

  //
  Future<void> initPlatformState() async {
    // Check and request SMS permissions at runtime using permission_handler
    var status = await Permission.sms.status;
    debugPrint("Initial SMS permission status: ${status}");

    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      status = await Permission.sms.request();
      debugPrint("SMS permission status after request: ${status}");

    }


  }


  // onMessage(SmsMessage message) async {
  //
  //
  //   debugPrint("Sms Body is  ${message.body}");
  //   debugPrint("Sms Body status  ${atmWithdrawalRegex.hasMatch(message.body!)}");
  //   if (message.body != null) {
  //     if (atmWithdrawalRegex.hasMatch(message.body!)) {
  //       final matches = atmWithdrawalRegex.firstMatch(message.body!);
  //       matchResult = "ATM Withdrawal: Bank: ${matches?.group(1)}, Amount: ${matches?.group(2)}, ATM ID: ${matches?.group(4)}, Date: ${matches?.group(6)}, Transaction #: ${matches?.group(7)}, Balance: ${matches?.group(8)}";
  //     } else if (creditSmsRegex.hasMatch(message.body!)) {
  //       final matches = creditSmsRegex.firstMatch(message.body!);
  //       matchResult = "Credit Transaction: Bank: ${matches?.group(1)} ${matches!.group(2)}, Amount Credited: ${matches?.group(4)}, Date: ${matches?.group(5)}, Ref : ${matches?.group(6)}";
  //     } else if (debitedRegex.hasMatch(message.body!)) {
  //       final matches = debitedRegex.firstMatch(message.body!);
  //       matchResult = "${matches?.group(1)} Debit:  Amount Debited: ${matches?.group(3)}, Date: ${matches?.group(4)}, Recipient: ${matches?.group(5)}, Ref No: ${matches?.group(6)}";
  //     } else {
  //       matchResult = "Received SMS does not match expected formats.";
  //     }
  //     if (matchResult.isNotEmpty){
  //       // await SmsStorage().writeSMS(matchResult);
  //
  //     }
  //     setState(() {
  //       // _message = message.body ?? "Error reading message body.";
  //       debugPrint("Sms message is  ${_message}");
  //
  //       messages.add(matchResult);
  //
  //
  //     });
  //   } else {
  //     setState(() {
  //       _message = "Error reading message body.";
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // loadMessages();
    return MultiBlocProvider(
      providers: [
       BlocProvider(create: (context)=> locator<ThemeBloc>() ),
       BlocProvider(create: (context)=> locator<TransactionBloc>()..add(LoadBankTransactions()) ),
      ],

      child: BlocBuilder<ThemeBloc,ThemeState>(
        builder: (context,themeState) =>
            MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeState.themeData,
          home: Scaffold(
            appBar: AppBar(
              title: const Text('SmartXP'),
            ),

              body: Padding(padding: EdgeInsets.all(8),child: BankTransactionList(),),
          ),
        ),
      ),
    );
  }
}
class BankTransactionList extends StatefulWidget {
  const BankTransactionList({super.key});

  @override
  _BankTransactionListState createState() => _BankTransactionListState();
}

class _BankTransactionListState extends State<BankTransactionList> {

  @override
  void initState()  {
    super.initState();
// initPlatformState();
  }
// Future<void> initPlatformState() async {
//   // Check and request SMS permissions at runtime using permission_handler
//   var status = await Permission.sms.status;
//   debugPrint("Initial SMS permission status: ${status}");
//
//   if (status.isDenied) {
//     // We didn't ask for permission yet or the permission has been denied before but not permanently.
//     status = await Permission.sms.request();
//     debugPrint("SMS permission status after request: ${status}");
//
//   }
//
//   if (status.isGranted) {
//     // Permission is granted, listen for incoming SMS
//     telephony.listenIncomingSms(
//         onNewMessage: onMessage,
//         onBackgroundMessage: onBackgroundMessage,
//         listenInBackground: true
//     );
//
//     debugPrint('onBackgroundMessage --- foreground is ${matchResult} .');
//
//   } else {
//     debugPrint('SMS permission denied by user.');
//   }
// }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(actions: [
  BlocBuilder<ThemeBloc,ThemeState>(
      builder: (context, themeSate){
    return Switch(
      value: themeSate.themeData == darkTheme,
      onChanged: (isDark){
        context.read<ThemeBloc>().add(InitializeTheme(isDark ? darkTheme : lightTheme));

      },);
  })
],),
      body:  TransactionsScreen()
      // ListView.builder(
      //   itemCount: messages.length,
      //   itemBuilder: (context, index) {
      //     var message = messages[index];
      //     Color signColor = Colors.grey; // Default color
      //     IconData icon = Icons.info; // Default icon
      //     // Check message type and assign color and icon accordingly
      //     if (message.contains("Debited")|| message.contains("Withdrawn")) {
      //       signColor = Colors.red;
      //       icon = Icons.arrow_downward; // Icon for withdrawal
      //
      //     } else if (message.contains("Credited")) {
      //       signColor = Colors.green;
      //       icon = Icons.arrow_upward; // Icon for deposit
      //     }else{
      //       message = "";
      //     }
      //
      //     return message.isNotEmpty ? Card(
      //       child: ListTile(
      //         leading: Icon(icon, color: signColor),
      //         title: Text(message),
      //         tileColor: signColor.withOpacity(0.1),
      //       ),
      //     ) : SizedBox();
      //   },
      // ),

    );}
  }