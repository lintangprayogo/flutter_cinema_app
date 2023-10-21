import 'package:cinema_app/data/repositories/transaction_repo.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/entities/transaction.dart';
import 'package:cinema_app/domain/usecases/create_transaction/create_transaction.dart';
import 'package:cinema_app/domain/usecases/create_transaction/create_transaction_param.dart';
import 'package:cinema_app/domain/usecases/top_up/top_up_param.dart';
import 'package:cinema_app/domain/usecases/usecase.dart';

class TopUp implements UseCase<Result<Transaction>, TopUpParam> {
  final TransactionRepo _transactionRepo;

  TopUp({required TransactionRepo transactionRepo})
      : _transactionRepo = transactionRepo;

  @override
  Future<Result<Transaction>> call(TopUpParam params) async {
    int transactionTime = DateTime.now().microsecondsSinceEpoch;
    final CreateTransaction createTransaction =
        CreateTransaction(transactionRepo: _transactionRepo);
    final param = CreateTransactionParam(
        transaction: Transaction(
            title: "Top Up",
            adminFee: 0,
            total: -params.amount,
            uid: params.uid,
            transactionTime: transactionTime,
            id: "cintp-$transactionTime${params.uid}"));
            
    return await createTransaction.call(param);
  }
}
