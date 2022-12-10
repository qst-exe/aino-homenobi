// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'license.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

License _$LicenseFromJson(Map<String, dynamic> json) {
  return _License.fromJson(json);
}

/// @nodoc
mixin _$License {
  String get packageName => throw _privateConstructorUsedError;
  String get paragraphText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LicenseCopyWith<License> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LicenseCopyWith<$Res> {
  factory $LicenseCopyWith(License value, $Res Function(License) then) =
      _$LicenseCopyWithImpl<$Res, License>;
  @useResult
  $Res call({String packageName, String paragraphText});
}

/// @nodoc
class _$LicenseCopyWithImpl<$Res, $Val extends License>
    implements $LicenseCopyWith<$Res> {
  _$LicenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageName = null,
    Object? paragraphText = null,
  }) {
    return _then(_value.copyWith(
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphText: null == paragraphText
          ? _value.paragraphText
          : paragraphText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LicenseCopyWith<$Res> implements $LicenseCopyWith<$Res> {
  factory _$$_LicenseCopyWith(
          _$_License value, $Res Function(_$_License) then) =
      __$$_LicenseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String packageName, String paragraphText});
}

/// @nodoc
class __$$_LicenseCopyWithImpl<$Res>
    extends _$LicenseCopyWithImpl<$Res, _$_License>
    implements _$$_LicenseCopyWith<$Res> {
  __$$_LicenseCopyWithImpl(_$_License _value, $Res Function(_$_License) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageName = null,
    Object? paragraphText = null,
  }) {
    return _then(_$_License(
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphText: null == paragraphText
          ? _value.paragraphText
          : paragraphText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_License implements _License {
  const _$_License({required this.packageName, required this.paragraphText});

  factory _$_License.fromJson(Map<String, dynamic> json) =>
      _$$_LicenseFromJson(json);

  @override
  final String packageName;
  @override
  final String paragraphText;

  @override
  String toString() {
    return 'License(packageName: $packageName, paragraphText: $paragraphText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_License &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.paragraphText, paragraphText) ||
                other.paragraphText == paragraphText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, packageName, paragraphText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LicenseCopyWith<_$_License> get copyWith =>
      __$$_LicenseCopyWithImpl<_$_License>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LicenseToJson(
      this,
    );
  }
}

abstract class _License implements License {
  const factory _License(
      {required final String packageName,
      required final String paragraphText}) = _$_License;

  factory _License.fromJson(Map<String, dynamic> json) = _$_License.fromJson;

  @override
  String get packageName;
  @override
  String get paragraphText;
  @override
  @JsonKey(ignore: true)
  _$$_LicenseCopyWith<_$_License> get copyWith =>
      throw _privateConstructorUsedError;
}
