import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/entities/transaction.dart';
import 'package:cinema_app/domain/entities/user.dart';
import 'package:cinema_app/domain/usecases/get_transaction/get_transaction.dart';
import 'package:cinema_app/domain/usecases/get_transaction/get_transactions_param.dart';
import 'package:cinema_app/presentation/providers/usecase/transaction/get_transaction_provider.dart';
import 'package:cinema_app/presentation/providers/usecase/user_data/user_data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'transaction_data_provider.g.dart';

@Riverpod(keepAlive: true)
class TransactionData extends _$TransactionData {
  
  @override
  Future<List<Transaction>> build() async {
    User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      GetTransactions getTransactions = ref.read(getTransactionsProvider);
      state = const AsyncLoading();

      final result = await getTransactions(GetTransactionsParam(uid: user.uid));

      if (result is Success) {
        return result.resultValue ?? [];
      }
    }

    return const [];
  }

  Future<void> refreshTransactionData() async {
    User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      GetTransactions getTransactions = ref.read(getTransactionsProvider);
      state = const AsyncLoading();

      final result = await getTransactions(GetTransactionsParam(uid: user.uid));

      switch (result) {
        case Success(value: final transactions):
          state = AsyncData(transactions);
        case Failed(:final message):
          state = AsyncError(FlutterError(message), StackTrace.current);
          state = AsyncData(state.valueOrNull ?? const []);
      }
    }
  }
}
