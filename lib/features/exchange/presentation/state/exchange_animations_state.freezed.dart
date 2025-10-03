// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exchange_animations_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExchangeAnimationsState {

 double get heroSize; bool get showWelcome; bool get showContent;
/// Create a copy of ExchangeAnimationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExchangeAnimationsStateCopyWith<ExchangeAnimationsState> get copyWith => _$ExchangeAnimationsStateCopyWithImpl<ExchangeAnimationsState>(this as ExchangeAnimationsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExchangeAnimationsState&&(identical(other.heroSize, heroSize) || other.heroSize == heroSize)&&(identical(other.showWelcome, showWelcome) || other.showWelcome == showWelcome)&&(identical(other.showContent, showContent) || other.showContent == showContent));
}


@override
int get hashCode => Object.hash(runtimeType,heroSize,showWelcome,showContent);

@override
String toString() {
  return 'ExchangeAnimationsState(heroSize: $heroSize, showWelcome: $showWelcome, showContent: $showContent)';
}


}

/// @nodoc
abstract mixin class $ExchangeAnimationsStateCopyWith<$Res>  {
  factory $ExchangeAnimationsStateCopyWith(ExchangeAnimationsState value, $Res Function(ExchangeAnimationsState) _then) = _$ExchangeAnimationsStateCopyWithImpl;
@useResult
$Res call({
 double heroSize, bool showWelcome, bool showContent
});




}
/// @nodoc
class _$ExchangeAnimationsStateCopyWithImpl<$Res>
    implements $ExchangeAnimationsStateCopyWith<$Res> {
  _$ExchangeAnimationsStateCopyWithImpl(this._self, this._then);

  final ExchangeAnimationsState _self;
  final $Res Function(ExchangeAnimationsState) _then;

/// Create a copy of ExchangeAnimationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? heroSize = null,Object? showWelcome = null,Object? showContent = null,}) {
  return _then(_self.copyWith(
heroSize: null == heroSize ? _self.heroSize : heroSize // ignore: cast_nullable_to_non_nullable
as double,showWelcome: null == showWelcome ? _self.showWelcome : showWelcome // ignore: cast_nullable_to_non_nullable
as bool,showContent: null == showContent ? _self.showContent : showContent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ExchangeAnimationsState].
extension ExchangeAnimationsStatePatterns on ExchangeAnimationsState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double heroSize,  bool showWelcome,  bool showContent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExchangeAnimationsState() when $default != null:
return $default(_that.heroSize,_that.showWelcome,_that.showContent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double heroSize,  bool showWelcome,  bool showContent)  $default,) {final _that = this;
switch (_that) {
case _ExchangeAnimationsState():
return $default(_that.heroSize,_that.showWelcome,_that.showContent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double heroSize,  bool showWelcome,  bool showContent)?  $default,) {final _that = this;
switch (_that) {
case _ExchangeAnimationsState() when $default != null:
return $default(_that.heroSize,_that.showWelcome,_that.showContent);case _:
  return null;

}
}

}

/// @nodoc


class _ExchangeAnimationsState extends ExchangeAnimationsState {
  const _ExchangeAnimationsState({required this.heroSize, this.showWelcome = true, this.showContent = false}): super._();
  

@override final  double heroSize;
@override@JsonKey() final  bool showWelcome;
@override@JsonKey() final  bool showContent;

/// Create a copy of ExchangeAnimationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExchangeAnimationsStateCopyWith<_ExchangeAnimationsState> get copyWith => __$ExchangeAnimationsStateCopyWithImpl<_ExchangeAnimationsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExchangeAnimationsState&&(identical(other.heroSize, heroSize) || other.heroSize == heroSize)&&(identical(other.showWelcome, showWelcome) || other.showWelcome == showWelcome)&&(identical(other.showContent, showContent) || other.showContent == showContent));
}


@override
int get hashCode => Object.hash(runtimeType,heroSize,showWelcome,showContent);

@override
String toString() {
  return 'ExchangeAnimationsState(heroSize: $heroSize, showWelcome: $showWelcome, showContent: $showContent)';
}


}

/// @nodoc
abstract mixin class _$ExchangeAnimationsStateCopyWith<$Res> implements $ExchangeAnimationsStateCopyWith<$Res> {
  factory _$ExchangeAnimationsStateCopyWith(_ExchangeAnimationsState value, $Res Function(_ExchangeAnimationsState) _then) = __$ExchangeAnimationsStateCopyWithImpl;
@override @useResult
$Res call({
 double heroSize, bool showWelcome, bool showContent
});




}
/// @nodoc
class __$ExchangeAnimationsStateCopyWithImpl<$Res>
    implements _$ExchangeAnimationsStateCopyWith<$Res> {
  __$ExchangeAnimationsStateCopyWithImpl(this._self, this._then);

  final _ExchangeAnimationsState _self;
  final $Res Function(_ExchangeAnimationsState) _then;

/// Create a copy of ExchangeAnimationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? heroSize = null,Object? showWelcome = null,Object? showContent = null,}) {
  return _then(_ExchangeAnimationsState(
heroSize: null == heroSize ? _self.heroSize : heroSize // ignore: cast_nullable_to_non_nullable
as double,showWelcome: null == showWelcome ? _self.showWelcome : showWelcome // ignore: cast_nullable_to_non_nullable
as bool,showContent: null == showContent ? _self.showContent : showContent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
