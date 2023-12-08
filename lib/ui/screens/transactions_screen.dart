import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_bloc.dart';
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_event.dart';
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_state.dart';
import 'package:BalanceFlow/core/service_locator.dart';
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
      body: BlocProvider<TransactionBloc>(
        create: (context) => locator<TransactionBloc>(),
      child: BlocBuilder<TransactionBloc,TransactionState>(
        builder: (context,state){
          if (state is TransactionLoading){
            return  GestureDetector(
                onTap: (){context.read<TransactionBloc>().add(LoadBankTransactions());},
                child: const CircularProgressIndicator());
          }else if( state is FetchTransactions){
            return ListTile(title: Text(state.transactions.first.transactionId.toString()),);
          }else if (state is TransactionError){
            return ErrorScreen(errorMessage: state.error.message);
          }
          return Container();
        },
      ),),
    );
  }
}
