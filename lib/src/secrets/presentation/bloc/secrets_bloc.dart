import 'package:bloc/bloc.dart';
import 'package:secrets_box/src/secrets/presentation/bloc/events/index.dart';
import 'package:secrets_box/src/secrets/presentation/bloc/states/index.dart';

class SecretsBloc extends Bloc<SecretsEvent, SecretsState> {
  SecretsBloc() : super(SecretsInitial()) {
    on<SecretsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
