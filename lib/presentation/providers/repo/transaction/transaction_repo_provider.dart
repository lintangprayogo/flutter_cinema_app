import 'package:cinema_app/data/firebase/firebase_transaction_repo.dart';
import 'package:cinema_app/data/repositories/transaction_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_repo_provider.g.dart';

@riverpod
TransactionRepo transactionRepo(TransactionRepoRef ref) =>
    FirebaseTransactionRepo();
