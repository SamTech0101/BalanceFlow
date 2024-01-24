import 'dart:async';

import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_bloc.dart';
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_event.dart';
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_state.dart';
import 'package:BalanceFlow/bloc/theme/theme_bloc.dart';
import 'package:BalanceFlow/bloc/theme/theme_event.dart';
import 'package:BalanceFlow/bloc/theme/theme_state.dart';
import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/ui/screens/transactions_screen.dart';
import 'package:BalanceFlow/ui/widgets/add_transaction_dialog.dart';
import 'package:BalanceFlow/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

import 'core/service_locator.dart';
import 'model/transaction_type_adapter.dart';
import 'utils/constants.dart';

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

class _MyAppState extends State<MyApp> {
  final Telephony telephony = Telephony.instance;
  SmsMessage? lastSms;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    fetchLastSms();
  }

  fetchLastSms() async {
    if (await Permission.sms.request().isGranted) {
      List<SmsMessage> smsMessages = await telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
        sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.DESC)],
      );
      debugPrint("Telephony last SMS is ${smsMessages.first.body}");

      if (smsMessages.isNotEmpty) {
        setState(() {
          lastSms = smsMessages.first;
        });
      }
    }
  }

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

  @override
  Widget build(BuildContext context) {
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

              title: const Text('BalanceFlow'), actions: [
              BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) => Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          context
                              .read<TransactionBloc>()
                              .add(CalculateTotalBalance());
                        }, icon: const Icon(Icons.info)),
                      IconButton(onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddTransactionDialog(); // Opens the AddTransactionDialog
                          },
                        );
                      }, icon: const Icon(Icons.add) ),

                      IconButton(onPressed: (){
                        context.read<TransactionBloc>().add(ShowGraphTransaction());
                      }, icon: const Icon(Icons.map) ),



                    ],


                    ),

                  ),



                  BlocBuilder<ThemeBloc,ThemeState>(
                      builder: (context, themeSate){
                        return
                          IconButton(onPressed: (){
                            var isDark = themeSate.themeData == darkTheme;
                                  context.read<ThemeBloc>().add(InitializeTheme(isDark ? darkTheme : lightTheme));
                    },
                    icon: const Icon(Icons.lightbulb));
              }),
            ]),
            body: const Padding(
              padding: EdgeInsets.all(8),
              child: TransactionsScreen(),
            ),
          ),
        ),
      ),
    );
  }



}
