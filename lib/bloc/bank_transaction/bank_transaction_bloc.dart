
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_event.dart';
import 'package:BalanceFlow/bloc/bank_transaction/extention_transaction_bloc.dart';
import 'package:BalanceFlow/core/service_locator.dart';
import 'package:BalanceFlow/model/total_balance.dart';
import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/utils/AppError.dart';
import 'package:BalanceFlow/utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:readsms/model/sms.dart';

import '../../repository/transaction_repository.dart';
import 'bank_transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionsRepository _repository;

  TransactionBloc()
      : _repository = locator<TransactionsRepository>(),

        super(TransactionInitial())  {
    on<LoadBankTransactions>((event, emit) {
      _loadBankTransactions(event,emit);
    } );
    on<AddBankTransaction>((event, emit) => _addBankTransaction(event,emit));
    on<DeleteBankTransaction>((event, emit) => _deleteBankTransaction(event,emit));
    on<UpdateBankTransaction>((event, emit) => _updateTransactionBank(event,emit));
    on<AddBankSMS>((event,emit) async{
      _addBankSMS(event,emit);
    });
    on<ShowGraphTransaction>((event, emit) => emit(FetchGraph()));
    on<CalculateTotalBalance>((event, emit) => _fetchTotalBalance(event,emit));

  }

  Future<void> _addBankSMS(AddBankSMS event, Emitter<TransactionState> emit) async {
    try {
      // emit(TransactionLoading());
      await  _processSmsMessages(event,emit);
    }
     catch (e) {
       emit(TransactionError(error: AppError.customError(parseSMSError)));
      debugPrint("========Error=====>>  ${e.toString()}");
    }
  }

  Future<void> _processSmsMessages(AddBankSMS event,Emitter<TransactionState> emit) async {
    final SMS sms = event.sms;
    TransactionMessage? transactionMessage;
    //debit
    debugPrint("========_processSmsMessages=====>>  ${sms.body}");

    if (event.sms.body.contains(debitTitle) ||
        event.sms.body.contains(debitTitle.toLowerCase())) {
      debugPrint("========debitTitle=====>>  ");

      transactionMessage = parseDebitSms(sms.body);
      //credit
    } else if (sms.body.contains(creditTitle)) {
      debugPrint("========creditTitle=====>>  ");

      transactionMessage = parseCreditSms(sms.body);
      //ATM
    } else if (sms.body.contains(atmTitle) ||
        sms.body.contains(withdrawnTitle)) {
      debugPrint("========atmTitle=====>>  ");

      transactionMessage = parseAtmWithdrawalSms(sms.body);
    }
    if (transactionMessage != null) {
      await _repository.addTransaction(transactionMessage);
      add(LoadBankTransactions());
    } else {
      debugPrint("========Error=====>> parseSMSError ");

      emit(TransactionError(error: AppError.customError(parseSMSError)));
    }
  }





  void _updateTransactionBank(UpdateBankTransaction event,
      Emitter<TransactionState> emit) async {
    try {

    } on Exception catch (e) {
      emit(TransactionError(error: AppError.exception(e)));
    }
  }

  void _deleteBankTransaction(DeleteBankTransaction event,
      Emitter<TransactionState> emit) async {
    try {
      await _repository.deleteTransactionMessage(event.id);
      add(LoadBankTransactions());
    } on Exception catch (e) {
      emit(TransactionError(error: AppError.exception(e)));
    }
  }

  void _loadBankTransactions(LoadBankTransactions event,
      Emitter<TransactionState> emit) async {
    try {
      emit(TransactionLoading());

      List<TransactionMessage> transactions = await _repository
          .fetchTransactions();

      emit(FetchTransactions(transactions: transactions.reversed.toList()));

    } on Exception catch (e) {

      emit(TransactionError(error: AppError.exception(e)));
    }
  }

  void _addBankTransaction(AddBankTransaction event,
      Emitter<TransactionState> emit) async {
    try {
      // emit(TransactionLoading());
      await _repository.addTransaction(event.transactionMessage);
      add(LoadBankTransactions());
      // emit(TransactionOperationSuccess(message: addTransactionSuccessTitle));
    } on Exception catch (e) {
      emit(TransactionError(error: AppError.exception(e)));
    }
  }
  Future<void>_fetchTotalBalance(CalculateTotalBalance event, Emitter<TransactionState> emit)async {
    try {
      debugPrint("_fetchTotalBalance Bloc0");
      emit(TransactionLoading());
     TotalBalanceModel totalBalanceModel = await _repository.calculateTotalBalance();
      debugPrint("_fetchTotalBalance Bloc1 ${totalBalanceModel.toString()}");

      emit(FetchTotalBalance(totalBalanceModel: totalBalanceModel));
      debugPrint("_fetchTotalBalance Bloc2  ${totalBalanceModel.toString()}");

    } on Exception catch (e) {
      emit(TransactionError(error: AppError.exception(e)));
    }
  }
}



