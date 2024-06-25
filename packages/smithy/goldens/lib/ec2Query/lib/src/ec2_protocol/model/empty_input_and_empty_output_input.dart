// Generated with smithy-dart 0.3.1. DO NOT MODIFY.
// ignore_for_file: avoid_unused_constructor_parameters,deprecated_member_use_from_same_package,non_constant_identifier_names,require_trailing_commas

library ec2_query_v1.ec2_protocol.model.empty_input_and_empty_output_input; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i1;

part 'empty_input_and_empty_output_input.g.dart';

abstract class EmptyInputAndEmptyOutputInput
    with
        _i1.HttpInput<EmptyInputAndEmptyOutputInput>,
        _i2.AWSEquatable<EmptyInputAndEmptyOutputInput>
    implements
        Built<EmptyInputAndEmptyOutputInput,
            EmptyInputAndEmptyOutputInputBuilder>,
        _i1.EmptyPayload {
  factory EmptyInputAndEmptyOutputInput() {
    return _$EmptyInputAndEmptyOutputInput._();
  }

  factory EmptyInputAndEmptyOutputInput.build(
          [void Function(EmptyInputAndEmptyOutputInputBuilder) updates]) =
      _$EmptyInputAndEmptyOutputInput;

  const EmptyInputAndEmptyOutputInput._();

  factory EmptyInputAndEmptyOutputInput.fromRequest(
    EmptyInputAndEmptyOutputInput payload,
    _i2.AWSBaseHttpRequest request, {
    Map<String, String> labels = const {},
  }) =>
      payload;

  static const List<_i1.SmithySerializer<EmptyInputAndEmptyOutputInput>>
      serializers = [EmptyInputAndEmptyOutputInputEc2QuerySerializer()];

  @override
  EmptyInputAndEmptyOutputInput getPayload() => this;

  @override
  List<Object?> get props => [];

  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('EmptyInputAndEmptyOutputInput');
    return helper.toString();
  }
}

class EmptyInputAndEmptyOutputInputEc2QuerySerializer
    extends _i1.StructuredSmithySerializer<EmptyInputAndEmptyOutputInput> {
  const EmptyInputAndEmptyOutputInputEc2QuerySerializer()
      : super('EmptyInputAndEmptyOutputInput');

  @override
  Iterable<Type> get types => const [
        EmptyInputAndEmptyOutputInput,
        _$EmptyInputAndEmptyOutputInput,
      ];

  @override
  Iterable<_i1.ShapeId> get supportedProtocols => const [
        _i1.ShapeId(
          namespace: 'aws.protocols',
          shape: 'ec2Query',
        )
      ];

  @override
  EmptyInputAndEmptyOutputInput deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return EmptyInputAndEmptyOutputInputBuilder().build();
  }

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    EmptyInputAndEmptyOutputInput object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result$ = <Object?>[
      const _i1.XmlElementName(
        'EmptyInputAndEmptyOutputInputResponse',
        _i1.XmlNamespace('https://example.com/'),
      )
    ];

    return result$;
  }
}