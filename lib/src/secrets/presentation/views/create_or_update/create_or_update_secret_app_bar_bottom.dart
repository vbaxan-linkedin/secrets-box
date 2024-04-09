part of create_or_update_secrets_views;

class CreateOrUpdateSecretAppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  const CreateOrUpdateSecretAppBarBottom({
    super.key,
    this.titleController,
  });

  final TextEditingController? titleController;

  @override
  Size get preferredSize => const Size.fromHeight(54.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: titleController,
        style: const TextStyle(
          color: AppColors.kIndigo50,
        ),
        decoration: customInputDecoration(
          labelText: S.of(context).title,
          hintText: S.of(context).title,
          labelStyle: const TextStyle(
            color: AppColors.kIndigo50,
          ),
          hintStyle: const TextStyle(
            color: AppColors.kIndigo50,
          ),
          border: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.kIndigo50)),
        ),
        onChanged: (String value) {
          context.read<SecretsBloc>().add(
                StoreCreateSecretsEntryInfoEvent(
                  title: NewStateValue<String>(value),
                ),
              );
        },
      ),
    );
  }
}
