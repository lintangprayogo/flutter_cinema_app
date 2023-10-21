import 'package:cinema_app/domain/usecases/create_transaction/create_transaction.dart';
import 'package:cinema_app/presentation/providers/repo/transaction/transaction_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_transaction_provider.g.dart';

@riverpod
CreateTransaction createTransaction(CreateTransactionRef ref) =>
    CreateTransaction(transactionRepo: ref.watch(transactionRepoProvider));
