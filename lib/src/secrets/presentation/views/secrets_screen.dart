part of secrets_views;

final class SecretsScreen extends StatefulWidget {
  const SecretsScreen({super.key});

  @override
  State<SecretsScreen> createState() => _SecretsScreenState();
}

final class _SecretsScreenState extends State<SecretsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SecretsBloc>().add(const FetchSecretsEntriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen.normal(
      appBar: CustomAppBar.normal(
        context,
        title: S.of(context).secrets,
      ),
      child: SizedBox.expand(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            BlocBuilder<SecretsBloc, SecretsState>(
              builder: (BuildContext context, SecretsState state) {
                if (state is FetchingSecretsEntries) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SecretsEntriesFetched) {
                  if (state.entries.isEmpty) {
                    return Center(
                      child: Text(
                        S.of(context).noSecretsEntries,
                        textAlign: TextAlign.center,
                      )
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton.extended(
                icon: const Icon(Icons.add),
                label: Text(S.of(context).addSecret),
                onPressed: () async {
                  context.read<SecretsBloc>().add(
                    StoreCreateSecretsEntryInfoEvent(
                      info: CreateSecretsEntryInfo.empty(),
                    ),
                  );
                  Future<void>.delayed(const Duration(milliseconds: 150)).then((_) {
                    const CreateOrUpdateSecretRoute().go(context);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
