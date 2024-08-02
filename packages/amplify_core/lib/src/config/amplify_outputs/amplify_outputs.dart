// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_core/src/config/amplify_outputs/analytics/analytics_outputs.dart';
import 'package:amplify_core/src/config/amplify_outputs/auth/auth_outputs.dart';
import 'package:amplify_core/src/config/amplify_outputs/data/data_outputs.dart';
import 'package:amplify_core/src/config/amplify_outputs/notifications/notifications_outputs.dart';
import 'package:amplify_core/src/config/amplify_outputs/rest_api/rest_api_outputs.dart';
import 'package:amplify_core/src/config/amplify_outputs/storage/storage_outputs.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'amplify_outputs.g.dart';

/// {@template amplify_core.amplify_outputs}
/// The amplify outputs generated by Amplify Gen 2 for
/// Amplify libraries to communicate with backend services.
/// {@endtemplate}
@zAmplifyOutputsSerializable
class AmplifyOutputs
    with AWSEquatable<AmplifyOutputs>, AWSSerializable, AWSDebuggable {
  /// {@macro amplify_core.amplify_outputs}
  @internal
  const AmplifyOutputs({
    this.schema,
    required this.version,
    this.analytics,
    this.auth,
    this.data,
    this.restApi,
    this.notifications,
    this.storage,
    this.custom,
  });

  factory AmplifyOutputs.fromJson(Map<String, Object?> json) =>
      _$AmplifyOutputsFromJson(json);

  /// The json schema for amplify output json object.
  final String? schema;

  /// The schema version.
  final String version;

  /// {@macro amplify_core.amplify_outputs.analytics_outputs}
  final AnalyticsOutputs? analytics;

  /// {@macro amplify_core.amplify_outputs.auth_outputs}
  final AuthOutputs? auth;

  /// {@macro amplify_core.amplify_outputs.data_outputs}
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  final Map<String, DataOutputs>? data;

  /// {@macro amplify_core.amplify_outputs.rest_api_outputs}
  @internal
  @JsonKey(includeToJson: false)
  final Map<String, RestApiOutputs>? restApi;

  /// {@macro amplify_core.amplify_outputs.notifications_outputs}
  final NotificationsOutputs? notifications;

  /// {@macro amplify_core.amplify_outputs.storage_outputs}
  final StorageOutputs? storage;

  /// The custom outputs generated by Amplify Gen 2.
  ///
  /// Amplify Categories do not use custom outputs.
  final Map<String, dynamic>? custom;

  @override
  List<Object?> get props => [
        schema,
        version,
        analytics,
        auth,
        data,
        restApi,
        notifications,
        storage,
        custom,
      ];

  @override
  String get runtimeTypeName => 'AmplifyOutputs';

  @override
  Map<String, Object?> toJson() {
    return _$AmplifyOutputsToJson(this);
  }
}

/// The name of the API plugin when a Gen 2 config is used.
///
/// "data" is consistent with the name Gen 2 uses when generating a Gen 1 config.
/// reference: https://github.com/aws-amplify/amplify-backend/blob/4dd9d5a35c378895d1360c15a3b7ad1f09cc7653/packages/client-config/src/client-config-writer/client_config_to_mobile_legacy_converter.ts#L93
const _dataPluginName = 'data';

/// Converts a single data json object to a map of [DataOutputs].
///
/// This manual mapping is required since the Amplify Outputs schema only supports
/// a single data object, but Amplify Flutter supports more than 1.
Map<String, DataOutputs>? _dataFromJson(Map<String, Object?>? object) {
  if (object == null) return null;
  return {
    _dataPluginName: DataOutputs.fromJson(object),
  };
}

/// Converts a map of [DataOutputs] to a single data json object.
///
/// This manual mapping is required since the Amplify Outputs schema only supports
/// a single data object, but Amplify Flutter supports more than 1.
Object? _dataToJson(Map<String, DataOutputs>? outputs) {
  if (outputs == null) return null;
  if (outputs.length > 1) {
    throw ConfigurationError(
      'Found ${outputs.length} endpoints.'
      ' Amplify Outputs does not support multiple GraphQL endpoints.',
    );
  }
  final data = outputs.values.firstOrNull;
  return data?.toJson();
}
