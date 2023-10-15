import 'package:cinema_app/data/repositories/transaction_repo.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/entities/transaction.dart';
import 'package:cinema_app/domain/usecases/get_transaction/get_transactions_param.dart';
import 'package:cinema_app/domain/usecases/usecase.dart';

class GetTransactions
    implements UseCase<Result<List<Transaction>>, GetTransactionsParam> {
  final TransactionRepo _transactionRepo;

  GetTransactions({required TransactionRepo transactionRepo})
      : _transactionRepo = transactionRepo;

  @override
  Future<Result<List<Transaction>>> call(GetTransactionsParam params) async {
    return await _transactionRepo.getUserTransactions(uid: params.uid);
  }
}
