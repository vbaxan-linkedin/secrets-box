part of secrets_list_views;

final class SecretsEntryListItem extends StatelessWidget {
  const SecretsEntryListItem({
    super.key,
    required this.entry,
    this.onTap,
  });

  final SecretsEntry entry;
  final EntityCallback<String>? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(entry.secretsEntryId),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.kIndigo100,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          entry.title
        ),
      ),
    );
  }
}
