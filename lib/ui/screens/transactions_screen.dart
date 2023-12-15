
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_bloc.dart';
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_event.dart';
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_state.dart';
import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/ui/widgets/snack_bar_error.dart';
import 'package:BalanceFlow/ui/widgets/total_balance.dart';
import 'package:BalanceFlow/ui/widgets/transaction_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readsms/readsms.dart';



class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final plugin = Readsms();
  FetchTransactions? lastFetchTransactionsState;



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

      body: BlocConsumer<TransactionBloc,TransactionState>(
          listener: (context,state){
            if(state is FetchTotalBalance){

              showDialog(
                context: context,
                builder: (context) {
                  return  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(child: TotalBalanceWidget(totalBalanceModel: state.totalBalanceModel)),
                  );// Opens the AddTransactionDialog
                },
              );
            }else if (state is FetchGraph){
              showDialog(
                context: context,
                builder: (context) {
                  return  Center(child: TransactionGraph(transactionMessage: lastFetchTransactionsState?.transactions ?? []));// Opens the AddTransactionDialog
                },
              );
            }
            else if (state is TransactionError){
              showErrorSnackBar(context, state.error.message);
            }
          },
          builder: (context,state){
            if (state is FetchTransactions) {
              lastFetchTransactionsState = state;
            }
            if (state is TransactionLoading){
              return const Center(child: CircularProgressIndicator());
            }
            else if( state is FetchTransactions || state is FetchTotalBalance ||state is TransactionError || state is FetchGraph){

              return
                _buildTransactionList(lastFetchTransactionsState,context);
            }else if (state is TransactionOperationSuccess){
              return Dialog(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),child: Text(state.message),);
            }
            else{
              return const Text("");
            }

          },
   )

    );
  }
}


Widget _buildTransactionList(FetchTransactions? state,BuildContext context) {
  if(state == null){
    return const Center(child: Text('No transactions available'));
  }
  return ListView.builder(
    itemCount: state.transactions.length,
    itemBuilder: (context, index) {
      var message = state.transactions[index];
      return _buildTransactionListItem(message, index, state,context);
    },
  );
}

Widget _buildTransactionListItem(TransactionMessage message, int index, FetchTransactions state,BuildContext context) {
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
  return Dismissible(
    background: Container(color: Colors.red.shade400,),
    key: Key(message.id),
    onDismissed: (direction) {
      debugPrint(
          "_buildTransactionListItem  ${message.id.toString().replaceFirst("", "")}");
      context
          .read<TransactionBloc>()
          .add(DeleteBankTransaction(id: message.id));
      //2023-12-12T05:24:04.036440
      //2023-12-12T05:24:04.036
    },


        child: Card(
          margin: const EdgeInsets.all(4),
          child: ListTile(
            leading: Column(children:[ Icon(icon, color: signColor),Text(signColor == Colors.red ? "Expense" : "Credit")]),
            trailing: Text("${message.amount}₹") ,
            title: Text("Category: ${message.description ?? "SMS"}"),
            tileColor: signColor.withOpacity(0.1),

      ),
        ),

  );
}
