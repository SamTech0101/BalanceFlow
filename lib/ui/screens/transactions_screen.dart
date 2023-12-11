import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_bloc.dart';
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_event.dart';
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_state.dart';
import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readsms/readsms.dart';

import 'error_screen.dart';


class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final plugin = Readsms();



@override
  void initState() {
    super.initState();
    _setupSmsListener();
  }
  void _setupSmsListener(){
  plugin.read();
  plugin.smsStream.listen((sms){
    print(sms.body);
    print(sms.sender);
    print(sms.timeReceived);
    context.read<TransactionBloc>().add(AddBankSMS(sms: sms));

  });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocBuilder<TransactionBloc,TransactionState>(
        builder: (context,state){
          if (state is TransactionLoading){
            return  GestureDetector(
                onTap: (){context.read<TransactionBloc>().add(LoadBankTransactions());},
                child: const CircularProgressIndicator());
          }
          else if( state is FetchTransactions){
         return          ListView.builder(
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                var message = state.transactions[index];
                Color signColor = Colors.grey; // Default color
                IconData icon = Icons.info; // Default icon
                // Check message type and assign color and icon accordingly
                if (message.type == TransactionType.atmWithdrawal || message.type == TransactionType.debit) {
                  signColor = Colors.red;
                  icon = Icons.arrow_downward; // Icon for withdrawal

                } else if (message.type == TransactionType.credit) {
                  signColor = Colors.green;
                  icon = Icons.arrow_upward; // Icon for deposit
                }

                return  Dismissible(
                  key: Key(index.toString()),
                  onDismissed: (direction) {
                    // Remove the item from the data source.
                    state.transactions.removeAt(index);
                    // Then show a snackbar.
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('${message.bankName} ${message.amount} dismissed')));
                  },
                  child: Card(
                    child: ListTile(
                      leading: Icon(icon, color: signColor),
                      title: Text("${message.bankName} ${message.amount}  ${message.date.toIso8601String().split("T")[0]} "),

                      tileColor: signColor.withOpacity(0.1),
                    ),
                  ),
                ) ;
              },
            );
          }else if (state is TransactionOperationSuccess){
            return Dialog(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),child: Text(state.message),);
          }
          else if (state is TransactionError){
            return ErrorScreen(errorMessage: state.error.message);
          }
          return Container();
        },
      )
    );
  }
}
