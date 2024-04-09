import 'package:bloc/bloc.dart';
import 'package:secrets_box/src/core/domain/entities/index.dart';
import 'package:secrets_box/src/core/errors/failure.dart';
import 'package:secrets_box/src/core/presentation/extensions.dart';
import 'package:secrets_box/src/core/services/index.dart';
import 'package:secrets_box/src/secrets/domain/entities/index.dart';
import 'package:secrets_box/src/secrets/domain/use_cases/index.dart';
import 'package:secrets_box/src/secrets/presentation/bloc/events/index.dart';
import 'package:secrets_box/src/secrets/presentation/bloc/states/index.dart';

class SecretsBloc extends Bloc<SecretsEvent, SecretsState> {
  SecretsBloc({
    required this.userId,
    required FetchSecretsEntries fetchSecretsEntries,
    required CreateSecretsEntry createSecretsEntry,
    required AppUuid appUuid,
  })  : _fetchSecretsEntries = fetchSecretsEntries,
        _createSecretsEntry = createSecretsEntry,
        _appUuid = appUuid,
        super(const SecretsInitial()) {
    on<FetchSecretsEntriesEvent>(_handleFetchSecretsEntries);
    on<StoreCreateSecretsEntryInfoEvent>(_handleStoreCreateSecretsEntryInfoEvent);
    on<CreateOrUpdateSecretsEntry>(_handleCreateOrUpdateSecretsEntry);
  }

  final String userId;
  final FetchSecretsEntries _fetchSecretsEntries;
  final CreateSecretsEntry _createSecretsEntry;
  final AppUuid _appUuid;

  Future<void> _handleFetchSecretsEntries(FetchSecretsEntriesEvent event, Emitter<SecretsState> emitter) async {
    emitter(const FetchingSecretsEntries());
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      final Result<List<SecretsEntry>> entriesResult = await _fetchSecretsEntries(
        FetchSecretsEntriesParams(userId),
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

  void _handleStoreCreateSecretsEntryInfoEvent(
    StoreCreateSecretsEntryInfoEvent event,
    Emitter<SecretsState> emitter,
  ) {
    final CreateSecretsEntryInfo? info = event.info;
    if (info != null) {
      emitter(CreateSecretsEntryInfoState.fromInfo(info));
    } else {
      final CreateSecretsEntryInfoState currentState = concreteState() ?? CreateSecretsEntryInfoState.empty();
      emitter(
        currentState.copyWith(
          title: event.title,
          categories: event.categories,
          secrets: event.secrets,
        ),
      );
    }
  }

  Future<void> _handleCreateOrUpdateSecretsEntry(
    CreateOrUpdateSecretsEntry event,
    Emitter<SecretsState> emitter,
  ) async {
    try {
      final CreateSecretsEntryInfoState? info = concreteState<CreateSecretsEntryInfoState>();
      emitter(const CreatingSecretsEntry());
      if (info != null) {
        final String? title = info.title;
        if (title != null) {
          await _createSecretsEntry(
            CreateSecretsEntryParams(
              secretsEntryId: info.secretsEntryId ?? _appUuid.generateV4Uuid(),
              userId: userId,
              title: title,
              categories: info.categories,
              secrets: info.secrets,
            ),
          );
          emitter(const SecretsEntryCreated());
        }
      }
    } on Failure catch (failure) {
      emitter(SecretsError(message: failure.message));
    }
  }
}
