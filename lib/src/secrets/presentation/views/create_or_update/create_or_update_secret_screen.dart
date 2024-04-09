part of create_or_update_secrets_views;

final class CreateOrUpdateSecretScreen extends StatefulWidget {
  const CreateOrUpdateSecretScreen({super.key});

  @override
  State<CreateOrUpdateSecretScreen> createState() => _CreateOrUpdateSecretScreenState();
}

final class _CreateOrUpdateSecretScreenState extends State<CreateOrUpdateSecretScreen> {
  TextEditingController? _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen.normal(
      appBar: CustomAppBar.withFooter(
        context,
        leading: const AppBackButton(),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            color: AppColors.kIndigo50,
            onPressed: () {
              context.read<SecretsBloc>().add(const CreateOrUpdateSecretsEntry());
            },
          ),
        ],
        bottom: CreateOrUpdateSecretAppBarBottom(
          titleController: _titleController,
        ),
      ),
      child: const SizedBox.shrink(),
    );
  }
}
