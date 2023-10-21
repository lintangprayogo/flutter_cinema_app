import 'package:cinema_app/domain/usecases/top_up/top_up.dart';
import 'package:cinema_app/presentation/providers/repo/transaction/transaction_repo_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'top_up_provider.g.dart';

@riverpod
TopUp topUp(TopUpRef ref) =>
    TopUp(transactionRepo: ref.watch(transactionRepoProvider));
