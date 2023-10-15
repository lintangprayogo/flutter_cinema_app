import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/entities/transaction.dart';

abstract interface class TransactionRepo {
  Future<Result<Transaction>> createTransaction(
      {required Transaction transaction});
  Future<Result<List<Transaction>>> getUserTransactions({required String uid});
}
