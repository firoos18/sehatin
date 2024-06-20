import 'package:dart_either/dart_either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sehatin/core/exceptions/exceptions.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/features/history/data/data_sources/history_api_service.dart';
import 'package:sehatin/features/history/data/models/history_item_model.dart';
import 'package:sehatin/features/history/domain/repository/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryApiService _historyApiService;
  final FirebaseAuth _firebaseAuth;

  const HistoryRepositoryImpl(this._historyApiService, this._firebaseAuth);

  @override
  Future<Either<Failures, void>> addItemToHistory() async {
    try {
      final user = _firebaseAuth.currentUser;

      final result = await _historyApiService.addCartItemToHistory(user!.uid);

      return Right(result);
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }

  @override
  Future<Either<Failures, List<HistoryItemModel>>> getUserHistory() async {
    try {
      final user = _firebaseAuth.currentUser;

      final result = await _historyApiService.getUserHistory(user!.uid);

      return Right(result);
    } on RequestErrorException catch (e) {
      return Left(RequestFailures(e.message));
    }
  }
}
