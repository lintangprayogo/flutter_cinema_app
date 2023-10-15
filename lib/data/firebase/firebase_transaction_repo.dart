import 'package:cinema_app/data/firebase/firebase_user_repo.dart';
import 'package:cinema_app/data/repositories/transaction_repo.dart';
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/entities/transaction.dart';

import 'package:cloud_firestore/cloud_firestore.dart' as fire_store;
import 'package:firebase_core/firebase_core.dart';

class FirebaseTransactionRepo implements TransactionRepo {
  final fire_store.FirebaseFirestore _firebaseFirestore;

  FirebaseTransactionRepo(
      {required fire_store.FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore =
            firebaseFirestore ?? fire_store.FirebaseFirestore.instance;

  @override
  Future<Result<Transaction>> createTransaction(
      {required Transaction transaction}) async {
    try {
      fire_store.CollectionReference<Map<String, dynamic>> transactions =
          _firebaseFirestore.collection("transactions");

      final balanceResult =
          await FirebaseUserRepo().getUserBalance(uid: transaction.uid);
      if (balanceResult is Success) {
        final prevBalance = balanceResult.resultValue ?? 0;
        if ((prevBalance - transaction.total) > 0) {
          await transactions.doc(transaction.id).set(transaction.toJson());

          final result = await transactions.doc(transaction.id).get();
          if (result.exists) {
            await FirebaseUserRepo().updateUserBalance(
                uid: transaction.uid, balance: prevBalance - transaction.total);
            return Result.success(transaction);
          } else {
            return const Result.failed("Failed To Add Transaction");
          }
        } else {
          return const Result.failed("Insufficient Balance");
        }
      } else {
        return const Result.failed("Failed To Get Balance");
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? "Unknown error");
    }
  }

  @override
  Future<Result<List<Transaction>>> getUserTransactions(
      {required String uid}) async {
    try {
      fire_store.CollectionReference<Map<String, dynamic>> transactions =
          _firebaseFirestore.collection("transactions");

      final result = await transactions.where({"uid": uid}).get();
      if (result.docs.isEmpty) {
        return const Result.success([]);
      } else {
        return Result.success(
            result.docs.map((e) => Transaction.fromJson(e.data())).toList());
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? "Unknown error");
    }
  }
}
