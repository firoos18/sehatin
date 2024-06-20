import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/core/usecase/usecase.dart';
import 'package:sehatin/features/history/domain/entities/history_item_entity.dart';
import 'package:sehatin/features/history/domain/repository/history_repository.dart';

class GetUserHistoryUseCase
    implements UseCase<Either<Failures, List<HistoryItemEntity>>, Null> {
  final HistoryRepository historyRepository;

  const GetUserHistoryUseCase(this.historyRepository);

  @override
  Future<Either<Failures, List<HistoryItemEntity>>> call({Null params}) async {
    return await historyRepository.getUserHistory();
  }
}
