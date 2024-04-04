import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocExtension<Event, State> on Bloc<Event, State> {
  S? concreteState<S extends State>() => state as S?;
}