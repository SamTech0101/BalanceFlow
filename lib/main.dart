import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_bloc.dart';
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_event.dart';
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_state.dart';
import 'package:BalanceFlow/bloc/theme/theme_bloc.dart';
import 'package:BalanceFlow/bloc/theme/theme_event.dart';
import 'package:BalanceFlow/bloc/theme/theme_state.dart';
import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/ui/screens/home_screen.dart';
import 'package:BalanceFlow/ui/widgets/add_transaction_dialog.dart';
import 'package:BalanceFlow/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'core/service_locator.dart';
import 'model/transaction_type_adapter.dart';
import 'utils/constants.dart';



// Define a list to store all messages
List<String> messages = [];

//Dear SBI UPI User, ur A/ cX0273 credited by Rs20 on 13Nov23 by (Ref no564654654646)
//Dear UPI user A/C X3327 debited by 210.0 on date 01 Dec23 trf to RAGHAV SINGH SO Refno 333552183075. If not u? call
// 1800111109. -SBI
/*Dear Customer, transaction number 331709194781 for Rs.10.00 by SBI Debit Card X8231 done at 89050458 on 13Nov23 at 09:45:09.
Your updated available balance is Rs.232.88. If not done by you, forward this SMS to 9223008333/ call 1800111109/9449112211 to block card. GOl helpline for cyber fraud 1930.*/



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


  @override
  void initState() {
    super.initState();
    initPlatformState();

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
              title: const Text('SmartXP'),
                actions: [
                  BlocBuilder<TransactionBloc,TransactionState>(builder: (context,transactionState){
                    return  Row(
                      children: [
                        IconButton(onPressed: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                  child: Container(
                                    child: Text("Info"),
                                    padding: EdgeInsets.all(20), ))

                              ;
                            },
                          );
                        }, icon: const Icon(Icons.info)),
                        IconButton(onPressed: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddTransactionDialog(); // Opens the AddTransactionDialog
                            },
                          );
                        }, icon: const Icon(Icons.add) ),
                      ],

                    );

                  }),
                  BlocBuilder<ThemeBloc,ThemeState>(
                      builder: (context, themeSate){
                        return
                          IconButton(onPressed: (){
                            var isDark = themeSate.themeData == darkTheme;
                                  context.read<ThemeBloc>().add(InitializeTheme(isDark ? darkTheme : lightTheme));

                          }, icon: const Icon(Icons.lightbulb) );

                      }),



                ]

            ),

              body: const Padding(padding: EdgeInsets.all(8),child: HomeScreen(),),
          ),
        ),
      ),
    );
  }
}
