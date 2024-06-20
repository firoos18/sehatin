import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/features/history/domain/entities/history_item_entity.dart';

abstract class HistoryRepository {
  Future<Either<Failures, void>> addItemToHistory();

  Future<Either<Failures, List<HistoryItemEntity>>> getUserHistory();
}
