part of secrets_list_views;

final class SecretsEntriesList extends StatelessWidget {
  const SecretsEntriesList({super.key, required this.entries});

  final List<SecretsEntry> entries;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return SecretsEntryListItem(
          entry: entries[index],
          onTap: (String secretsEntryId) {},
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 8.0);
      },
      itemCount: entries.length,
    );
  }
}
