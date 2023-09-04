part of 'example_freezed_bloc.dart';

@freezed
class ExampleFreezedState with _$ExampleFreezedState {
  factory ExampleFreezedState.initial() = ExampleFreezedStateInitial;
  factory ExampleFreezedState.loading() = ExampleFreezedStateloading;
  factory ExampleFreezedState.showBanner(
      {required List<String> names,
      required String message}) = ExampleFreezedStateshowBanner;
  factory ExampleFreezedState.data({required List<String> names}) =
      _ExampleFreezedStateData;
}
