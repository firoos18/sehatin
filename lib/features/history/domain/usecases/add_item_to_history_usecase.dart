import 'package:dart_either/dart_either.dart';
import 'package:sehatin/core/failures/failures.dart';
import 'package:sehatin/core/usecase/usecase.dart';
import 'package:sehatin/features/history/domain/repository/history_repository.dart';

class AddItemToHistoryUseCase implements UseCase<Either<Failures, void>, Null> {
  final HistoryRepository historyRepository;

  const AddItemToHistoryUseCase(this.historyRepository);

  @override
  Future<Either<Failures, void>> call({Null params}) async {
    return await historyRepository.addItemToHistory();
  }
}
