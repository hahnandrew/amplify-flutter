// Generated with smithy-dart 0.3.1. DO NOT MODIFY.

library smoke_test.s3.model.target_grant; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i4;
import 'package:smoke_test/src/sdk/src/s3/model/bucket_logs_permission.dart'
    as _i3;
import 'package:smoke_test/src/sdk/src/s3/model/grantee.dart' as _i2;

part 'target_grant.g.dart';

/// Container for granting information.
///
/// Buckets that use the bucket owner enforced setting for Object Ownership don't support target grants. For more information, see [Permissions server access log delivery](https://docs.aws.amazon.com/AmazonS3/latest/userguide/enable-server-access-logging.html#grant-log-delivery-permissions-general) in the _Amazon S3 User Guide_.
abstract class TargetGrant
    with _i1.AWSEquatable<TargetGrant>
    implements Built<TargetGrant, TargetGrantBuilder> {
  /// Container for granting information.
  ///
  /// Buckets that use the bucket owner enforced setting for Object Ownership don't support target grants. For more information, see [Permissions server access log delivery](https://docs.aws.amazon.com/AmazonS3/latest/userguide/enable-server-access-logging.html#grant-log-delivery-permissions-general) in the _Amazon S3 User Guide_.
  factory TargetGrant({
    _i2.Grantee? grantee,
    _i3.BucketLogsPermission? permission,
  }) {
    return _$TargetGrant._(
      grantee: grantee,
      permission: permission,
    );
  }

  /// Container for granting information.
  ///
  /// Buckets that use the bucket owner enforced setting for Object Ownership don't support target grants. For more information, see [Permissions server access log delivery](https://docs.aws.amazon.com/AmazonS3/latest/userguide/enable-server-access-logging.html#grant-log-delivery-permissions-general) in the _Amazon S3 User Guide_.
  factory TargetGrant.build([void Function(TargetGrantBuilder) updates]) =
      _$TargetGrant;

  const TargetGrant._();

  static const List<_i4.SmithySerializer> serializers = [
    TargetGrantRestXmlSerializer()
  ];

  @BuiltValueHook(initializeBuilder: true)
  static void _init(TargetGrantBuilder b) {}

  /// Container for the person being granted permissions.
  _i2.Grantee? get grantee;

  /// Logging permissions assigned to the grantee for the bucket.
  _i3.BucketLogsPermission? get permission;
  @override
  List<Object?> get props => [
        grantee,
        permission,
      ];
  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('TargetGrant');
    helper.add(
      'grantee',
      grantee,
    );
    helper.add(
      'permission',
      permission,
    );
    return helper.toString();
  }
}

class TargetGrantRestXmlSerializer
    extends _i4.StructuredSmithySerializer<TargetGrant> {
  const TargetGrantRestXmlSerializer() : super('TargetGrant');

  @override
  Iterable<Type> get types => const [
        TargetGrant,
        _$TargetGrant,
      ];
  @override
  Iterable<_i4.ShapeId> get supportedProtocols => const [
        _i4.ShapeId(
          namespace: 'aws.protocols',
          shape: 'restXml',
        )
      ];
  @override
  TargetGrant deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TargetGrantBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current;
      iterator.moveNext();
      final value = iterator.current;
      switch (key as String) {
        case 'Grantee':
          if (value != null) {
            result.grantee.replace((serializers.deserialize(
              value,
              specifiedType: const FullType(_i2.Grantee),
            ) as _i2.Grantee));
          }
          break;
        case 'Permission':
          if (value != null) {
            result.permission = (serializers.deserialize(
              value,
              specifiedType: const FullType(_i3.BucketLogsPermission),
            ) as _i3.BucketLogsPermission);
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
    final payload = (object as TargetGrant);
    final result = <Object?>[
      const _i4.XmlElementName(
        'TargetGrant',
        _i4.XmlNamespace('http://s3.amazonaws.com/doc/2006-03-01/'),
      )
    ];
    if (payload.grantee != null) {
      result
        ..add(const _i4.XmlElementName(
          'Grantee',
          _i4.XmlNamespace(
            'http://www.w3.org/2001/XMLSchema-instance',
            'xsi',
          ),
        ))
        ..add(serializers.serialize(
          payload.grantee!,
          specifiedType: const FullType(_i2.Grantee),
        ));
    }
    if (payload.permission != null) {
      result
        ..add(const _i4.XmlElementName('Permission'))
        ..add(serializers.serialize(
          payload.permission!,
          specifiedType: const FullType.nullable(_i3.BucketLogsPermission),
        ));
    }
    return result;
  }
}