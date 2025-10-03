// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exchange_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExchangeState {

 CurrencyOption? get fromCurrency; CurrencyOption? get toCurrency; String get amount; bool get isLoading; ExchangeRateEntity? get recommendation; String? get errorMessage;
/// Create a copy of ExchangeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExchangeStateCopyWith<ExchangeState> get copyWith => _$ExchangeStateCopyWithImpl<ExchangeState>(this as ExchangeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExchangeState&&(identical(other.fromCurrency, fromCurrency) || other.fromCurrency == fromCurrency)&&(identical(other.toCurrency, toCurrency) || other.toCurrency == toCurrency)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,fromCurrency,toCurrency,amount,isLoading,recommendation,errorMessage);

@override
String toString() {
  return 'ExchangeState(fromCurrency: $fromCurrency, toCurrency: $toCurrency, amount: $amount, isLoading: $isLoading, recommendation: $recommendation, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ExchangeStateCopyWith<$Res>  {
  factory $ExchangeStateCopyWith(ExchangeState value, $Res Function(ExchangeState) _then) = _$ExchangeStateCopyWithImpl;
@useResult
$Res call({
 CurrencyOption? fromCurrency, CurrencyOption? toCurrency, String amount, bool isLoading, ExchangeRateEntity? recommendation, String? errorMessage
});




}
/// @nodoc
class _$ExchangeStateCopyWithImpl<$Res>
    implements $ExchangeStateCopyWith<$Res> {
  _$ExchangeStateCopyWithImpl(this._self, this._then);

  final ExchangeState _self;
  final $Res Function(ExchangeState) _then;

/// Create a copy of ExchangeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromCurrency = freezed,Object? toCurrency = freezed,Object? amount = null,Object? isLoading = null,Object? recommendation = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
fromCurrency: freezed == fromCurrency ? _self.fromCurrency : fromCurrency // ignore: cast_nullable_to_non_nullable
as CurrencyOption?,toCurrency: freezed == toCurrency ? _self.toCurrency : toCurrency // ignore: cast_nullable_to_non_nullable
as CurrencyOption?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,recommendation: freezed == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as ExchangeRateEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExchangeState].
extension ExchangeStatePatterns on ExchangeState {
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CurrencyOption? fromCurrency,  CurrencyOption? toCurrency,  String amount,  bool isLoading,  ExchangeRateEntity? recommendation,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExchangeState() when $default != null:
return $default(_that.fromCurrency,_that.toCurrency,_that.amount,_that.isLoading,_that.recommendation,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CurrencyOption? fromCurrency,  CurrencyOption? toCurrency,  String amount,  bool isLoading,  ExchangeRateEntity? recommendation,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ExchangeState():
return $default(_that.fromCurrency,_that.toCurrency,_that.amount,_that.isLoading,_that.recommendation,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CurrencyOption? fromCurrency,  CurrencyOption? toCurrency,  String amount,  bool isLoading,  ExchangeRateEntity? recommendation,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ExchangeState() when $default != null:
return $default(_that.fromCurrency,_that.toCurrency,_that.amount,_that.isLoading,_that.recommendation,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ExchangeState extends ExchangeState {
  const _ExchangeState({required this.fromCurrency, required this.toCurrency, this.amount = '', this.isLoading = false, this.recommendation, this.errorMessage}): super._();
  

@override final  CurrencyOption? fromCurrency;
@override final  CurrencyOption? toCurrency;
@override@JsonKey() final  String amount;
@override@JsonKey() final  bool isLoading;
@override final  ExchangeRateEntity? recommendation;
@override final  String? errorMessage;

/// Create a copy of ExchangeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExchangeStateCopyWith<_ExchangeState> get copyWith => __$ExchangeStateCopyWithImpl<_ExchangeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExchangeState&&(identical(other.fromCurrency, fromCurrency) || other.fromCurrency == fromCurrency)&&(identical(other.toCurrency, toCurrency) || other.toCurrency == toCurrency)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.recommendation, recommendation) || other.recommendation == recommendation)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,fromCurrency,toCurrency,amount,isLoading,recommendation,errorMessage);

@override
String toString() {
  return 'ExchangeState(fromCurrency: $fromCurrency, toCurrency: $toCurrency, amount: $amount, isLoading: $isLoading, recommendation: $recommendation, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ExchangeStateCopyWith<$Res> implements $ExchangeStateCopyWith<$Res> {
  factory _$ExchangeStateCopyWith(_ExchangeState value, $Res Function(_ExchangeState) _then) = __$ExchangeStateCopyWithImpl;
@override @useResult
$Res call({
 CurrencyOption? fromCurrency, CurrencyOption? toCurrency, String amount, bool isLoading, ExchangeRateEntity? recommendation, String? errorMessage
});




}
/// @nodoc
class __$ExchangeStateCopyWithImpl<$Res>
    implements _$ExchangeStateCopyWith<$Res> {
  __$ExchangeStateCopyWithImpl(this._self, this._then);

  final _ExchangeState _self;
  final $Res Function(_ExchangeState) _then;

/// Create a copy of ExchangeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromCurrency = freezed,Object? toCurrency = freezed,Object? amount = null,Object? isLoading = null,Object? recommendation = freezed,Object? errorMessage = freezed,}) {
  return _then(_ExchangeState(
fromCurrency: freezed == fromCurrency ? _self.fromCurrency : fromCurrency // ignore: cast_nullable_to_non_nullable
as CurrencyOption?,toCurrency: freezed == toCurrency ? _self.toCurrency : toCurrency // ignore: cast_nullable_to_non_nullable
as CurrencyOption?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,recommendation: freezed == recommendation ? _self.recommendation : recommendation // ignore: cast_nullable_to_non_nullable
as ExchangeRateEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
