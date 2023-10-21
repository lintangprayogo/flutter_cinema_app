import 'package:cinema_app/domain/usecases/get_transaction/get_transaction.dart';
import 'package:cinema_app/presentation/providers/repo/transaction/transaction_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_transaction_provider.g.dart';

@riverpod
GetTransactions getTransactions(GetTransactionsRef ref) =>
    GetTransactions(transactionRepo: ref.watch(transactionRepoProvider));
