import 'package:mocktail/mocktail.dart';
import 'package:objectbox/objectbox.dart';
import 'package:secrets_box/src/auth/data/datasources/users_box_query_conditions.dart';

final class BoxMock<T> extends Mock implements Box<T> {}

final class UsersBoxQueryConditionsMock extends Mock implements UsersBoxQueryConditions {}

final class QueryMock<T> extends Mock implements Query<T> {}

final class QueryBuilderMock<T> extends Mock implements QueryBuilder<T> {}

final class ConditionMock<T> extends Mock implements Condition<T> {}