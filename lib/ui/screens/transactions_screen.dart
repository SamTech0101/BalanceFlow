import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_bloc.dart';
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_event.dart';
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_state.dart';
import 'package:BalanceFlow/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'error_screen.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(transactions),),
      body: BlocProvider<BankTransactionBloc>(create: (context) => BankTransactionBloc(),
      child: BlocBuilder<BankTransactionBloc,BankTransactionState>(
        builder: (context,state){
          if (state is BankTransactionLoading){
            return  GestureDetector(
                onTap: (){context.read<BankTransactionBloc>().add(LoadBankTransactions());},
                child: const CircularProgressIndicator());
          }else if( state is BankTransactionLoaded){
            return ListTile(title: Text(state.transactions.first.transactionId.toString()),);
          }else if (state is BankTransactionError){
            return ErrorScreen(errorMessage: state.error.message);
          }
          return Container();
        },
      ),),
    );
  }
}
