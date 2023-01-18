// Generated with smithy-dart 0.3.1. DO NOT MODIFY.

library smoke_test.config_service.model.conformance_pack_template_validation_exception; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i2;

part 'conformance_pack_template_validation_exception.g.dart';

/// You have specified a template that is not valid or supported.
abstract class ConformancePackTemplateValidationException
    with
        _i1.AWSEquatable<ConformancePackTemplateValidationException>
    implements
        Built<ConformancePackTemplateValidationException,
            ConformancePackTemplateValidationExceptionBuilder>,
        _i2.SmithyHttpException {
  /// You have specified a template that is not valid or supported.
  factory ConformancePackTemplateValidationException({String? message}) {
    return _$ConformancePackTemplateValidationException._(message: message);
  }

  /// You have specified a template that is not valid or supported.
  factory ConformancePackTemplateValidationException.build(
      [void Function(ConformancePackTemplateValidationExceptionBuilder)
          updates]) = _$ConformancePackTemplateValidationException;

  const ConformancePackTemplateValidationException._();

  /// Constructs a [ConformancePackTemplateValidationException] from a [payload] and [response].
  factory ConformancePackTemplateValidationException.fromResponse(
    ConformancePackTemplateValidationException payload,
    _i1.AWSBaseHttpResponse response,
  ) =>
      payload.rebuild((b) {
        b.statusCode = response.statusCode;
        b.headers = response.headers;
      });

  static const List<_i2.SmithySerializer> serializers = [
    ConformancePackTemplateValidationExceptionAwsJson11Serializer()
  ];

  @BuiltValueHook(initializeBuilder: true)
  static void _init(ConformancePackTemplateValidationExceptionBuilder b) {}

  /// Error executing the command
  @override
  String? get message;
  @override
  _i2.ShapeId get shapeId => const _i2.ShapeId(
        namespace: 'com.amazonaws.configservice',
        shape: 'ConformancePackTemplateValidationException',
      );
  @override
  _i2.RetryConfig? get retryConfig => null;
  @override
  @BuiltValueField(compare: false)
  int? get statusCode;
  @override
  @BuiltValueField(compare: false)
  Map<String, String>? get headers;
  @override
  Exception? get underlyingException => null;
  @override
  List<Object?> get props => [message];
  @override
  String toString() {
    final helper = newBuiltValueToStringHelper(
        'ConformancePackTemplateValidationException');
    helper.add(
      'message',
      message,
    );
    return helper.toString();
  }
}

class ConformancePackTemplateValidationExceptionAwsJson11Serializer extends _i2
    .StructuredSmithySerializer<ConformancePackTemplateValidationException> {
  const ConformancePackTemplateValidationExceptionAwsJson11Serializer()
      : super('ConformancePackTemplateValidationException');

  @override
  Iterable<Type> get types => const [
        ConformancePackTemplateValidationException,
        _$ConformancePackTemplateValidationException,
      ];
  @override
  Iterable<_i2.ShapeId> get supportedProtocols => const [
        _i2.ShapeId(
          namespace: 'aws.protocols',
          shape: 'awsJson1_1',
        )
      ];
  @override
  ConformancePackTemplateValidationException deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConformancePackTemplateValidationExceptionBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final value = iterator.current;
      switch (key) {
        case 'message':
          if (value != null) {
            result.message = (serializers.deserialize(
              value,
              specifiedType: const FullType(String),
            ) as String);
          }
          break;
      }
    }

    return result.build();
  }

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Object? object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final payload = (object as ConformancePackTemplateValidationException);
    final result = <Object?>[];
    if (payload.message != null) {
      result
        ..add('message')
        ..add(serializers.serialize(
          payload.message!,
          specifiedType: const FullType(String),
        ));
    }
    return result;
  }
}