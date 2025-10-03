import 'package:freezed_annotation/freezed_annotation.dart';

part 'exchange_animations_state.freezed.dart';

@freezed
abstract class ExchangeAnimationsState with _$ExchangeAnimationsState {
  
  const factory ExchangeAnimationsState({
    required double heroSize,
    @Default(true) bool showWelcome,
    @Default(false) bool showContent,
  }) = _ExchangeAnimationsState;
  const ExchangeAnimationsState._();
}
