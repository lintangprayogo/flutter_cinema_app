import 'package:cinema_app/data/repositories/transaction_repo.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/entities/transaction.dart';
import 'package:cinema_app/domain/usecases/create_transaction/create_transaction_param.dart';
import 'package:cinema_app/domain/usecases/usecase.dart';

class CreateTransaction
    implements UseCase<Result<Transaction>, CreateTransactionParam> {
  final TransactionRepo _transactionRepo;

  CreateTransaction({required TransactionRepo transactionRepo})
      : _transactionRepo = transactionRepo;

  @override
  Future<Result<Transaction>> call(CreateTransactionParam params) async {
    int transactionTime = DateTime.now().microsecondsSinceEpoch;
    return await _transactionRepo.createTransaction(
        transaction: params.transaction.copyWith(
            transactionTime: transactionTime,
            id: params.transaction.id??"cin-$transactionTime${params.transaction.uid}"));
  }
}
