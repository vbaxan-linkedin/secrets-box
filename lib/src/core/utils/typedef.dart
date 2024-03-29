import 'package:flutter/material.dart';
import 'package:secrets_box/src/core/domain/entities/index.dart';

typedef ResultFuture<T> = Future<Result<T>>;

typedef ResultVoid = ResultFuture<void>;

typedef EntityCallback<T> = void Function(T);

typedef EntityProducer<T> = T Function();

typedef FutureEntityProducer<T> = Future<T> Function();

typedef EntityTransformation<T, R> = R Function(T);

typedef EntityTransformation2<T, U, R> = R Function(T, U);

typedef EntityTransformation3<T, U, V, R> = R Function(T, U, V);

typedef FutureEntityTransformation<T, R> = Future<R> Function(T);

typedef Predicate<T> = EntityTransformation<T, bool>;

typedef Json = Map<String, dynamic>;

typedef EntityWidgetBuilder<T> = EntityTransformation2<BuildContext, T, Widget>;

typedef EntityWidgetBuilderIndexed<T> = EntityTransformation3<BuildContext, T, int, Widget>;
