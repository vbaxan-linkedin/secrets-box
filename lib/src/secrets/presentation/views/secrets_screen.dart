part of secrets_views;

final class SecretsScreen extends StatefulWidget {
  const SecretsScreen({super.key});

  @override
  State<SecretsScreen> createState() => _SecretsScreenState();
}

final class _SecretsScreenState extends State<SecretsScreen> {
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton.extended(
                icon: const Icon(Icons.add),
                label: Text(S.of(context).addSecret),
                onPressed: () async {
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
