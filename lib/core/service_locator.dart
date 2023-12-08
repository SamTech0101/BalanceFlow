
import 'package:BalanceFlow/bloc/bank_transaction/bank_transaction_bloc.dart';
import 'package:BalanceFlow/bloc/theme/theme_bloc.dart';
import 'package:BalanceFlow/repository/transaction_repository.dart';
import 'package:BalanceFlow/storage/hive_storage.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.I;
void setupLocator() {
  //Singleton
  locator.registerLazySingleton<LocalTransactions>(() => LocalTransactions());
  locator.registerLazySingleton<TransactionsRepository>(() => TransactionsRepository(locator<LocalTransactions>()));
  //Factory
  locator.registerFactory<TransactionBloc>(() => TransactionBloc());
  locator.registerFactory<ThemeBloc>(() => ThemeBloc());

}