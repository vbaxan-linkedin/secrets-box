part of secrets_datasources;

abstract interface class SecretsEntriesBoxQueryConditions {
  Condition<BoxSecretsEntry> userIdEquals(String userId);
}

final class SecretsEntriesBoxQueryConditionsImpl implements SecretsEntriesBoxQueryConditions {
  @override
  Condition<BoxSecretsEntry> userIdEquals(String userId) {
    return BoxSecretsEntry_.userId.equals(userId);
  }
}