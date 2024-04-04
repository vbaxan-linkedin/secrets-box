import 'package:bloc/bloc.dart';
import 'package:secrets_box/src/core/domain/entities/index.dart';
import 'package:secrets_box/src/core/errors/failure.dart';
import 'package:secrets_box/src/secrets/domain/entities/index.dart';
import 'package:secrets_box/src/secrets/domain/use_cases/index.dart';
import 'package:secrets_box/src/secrets/presentation/bloc/events/index.dart';
import 'package:secrets_box/src/secrets/presentation/bloc/states/index.dart';

class SecretsBloc extends Bloc<SecretsEvent, SecretsState> {
  SecretsBloc({
    required FetchSecretsEntries fetchSecretsEntries,
  })  : _fetchSecretsEntries = fetchSecretsEntries,
        super(const SecretsInitial()) {
    on<FetchSecretsEntriesEvent>(_handleFetchSecretsEntries);
  }

  final FetchSecretsEntries _fetchSecretsEntries;

  Future<void> _handleFetchSecretsEntries(FetchSecretsEntriesEvent event, Emitter<SecretsState> emitter) async {
    emitter(const FetchingSecretsEntries());
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      final Result<List<SecretsEntry>> entriesResult = await _fetchSecretsEntries(
        FetchSecretsEntriesParams(event.userId),
      );
      emitter(
        SecretsEntriesFetched(
          entries: entriesResult.extractSuccess().data,
        ),
      );
    } on Failure catch (failure) {
      emitter(SecretsError(message: failure.message));
    }
  }
}
