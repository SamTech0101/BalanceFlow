import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_event.dart';
import 'package:BalanceFlow/core/service_locator.dart';
import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/utils/AppError.dart';
import 'package:BalanceFlow/utils/constants.dart';
import 'package:bloc/bloc.dart';
import '../../repository/transaction_repository.dart';
import 'bank_transaction_state.dart';
import 'extention_transaction_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionsRepository _repository;

  TransactionBloc()
      : _repository = locator<TransactionsRepository>(),
        super(TransactionInitial()) {
    on<LoadBankTransactions>((event, emit) => _loadBankTransactions);
    on<AddBankTransaction>((event, emit) => _addBankTransaction);
    on<DeleteBankTransaction>((event, emit) => _deleteBankTransaction);
    on<UpdateBankTransaction>((event, emit) => _updateTransactionBank);
    on<AddBankSMS>((event, emit) => _addBankSMS);
  }

  void _addBankSMS(AddBankSMS event, Emitter<TransactionState> emit) async {
    try {
      emit(TransactionLoading());
      //debit
      if (event.sms.contains(debitTitle)) {
        TransactionMessage transactionMessage = _parseDebitSms(event.sms);
        await _repository.addTransaction(transactionMessage);
        emit(TransactionOperationSuccess(message: addTransactionSuccessTitle));
        //credit
      } else if (event.sms.contains(creditTitle)) {
        TransactionMessage transactionMessage = _parseCreditSms(event.sms);
        await _repository.addTransaction(transactionMessage);
        emit(TransactionOperationSuccess(message: addTransactionSuccessTitle));
        //ATM
      } else if (event.sms.contains(atmTitle)) {
        TransactionMessage transactionMessage = _parseAtmWithdrawalSms(
            event.sms);
        await _repository.addTransaction(transactionMessage);
        emit(TransactionOperationSuccess(message: addTransactionSuccessTitle));
      }
    } catch (_) {
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
      emit(TransactionLoading());
      await _repository.deleteTransactionMessage(event.id);
      emit(TransactionOperationSuccess(message: deleteTransactionSuccessTitle));
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
      emit(FetchTransactions(transactions: transactions));
      // emit(FetchTransactions(transactions: [
      //   TransactionMessage(bankName : "Panama", amount: 29.3, transactionId: "324", type: TransactionType.atmWithdrawal,  date: DateTime(2023),),
      //   TransactionMessage(amount: 222349.3, transactionId: "23423424234", type: TransactionType.credit,  date: DateTime(2023), bankName: 'HTC')]));
    } on Exception catch (e) {
      emit(TransactionError(error: AppError.exception(e)));
    }
  }

  void _addBankTransaction(AddBankTransaction event,
      Emitter<TransactionState> emit) async {
    try {
      emit(TransactionLoading());
      await _repository.addTransaction(event.transactionMessage);
      emit(TransactionOperationSuccess(message: addTransactionSuccessTitle));
    } on Exception catch (e) {
      emit(TransactionError(error: AppError.exception(e)));
    }
  }

}

