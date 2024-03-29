part of create_or_update_secrets_views;

final class CreateOrUpdateSecretScreen extends StatefulWidget {
  const CreateOrUpdateSecretScreen({super.key});

  @override
  State<CreateOrUpdateSecretScreen> createState() => _CreateOrUpdateSecretScreenState();
}

final class _CreateOrUpdateSecretScreenState extends State<CreateOrUpdateSecretScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScreen.normal(
      appBar: CustomAppBar.withFooter(
        context,
        leading: const AppBackButton(),
        bottom: CreateOrUpdateSecretAppBarBottom(),
      ),
      child: const SizedBox(),
    );
  }
}
