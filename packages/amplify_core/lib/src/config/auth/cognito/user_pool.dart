// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:amplify_core/amplify_core.dart';

part 'user_pool.g.dart';

@zAwsSerializable
class CognitoUserPoolConfig
    with AWSEquatable<CognitoUserPoolConfig>, AWSSerializable {
  const CognitoUserPoolConfig({
    required this.poolId,
    required this.appClientId,
    this.appClientSecret,
    required this.region,
    this.hostedUI,
  });

  factory CognitoUserPoolConfig.fromJson(Map<String, Object?> json) =>
      _$CognitoUserPoolConfigFromJson(json);
  final String poolId;
  final String appClientId;
  final String? appClientSecret;
  final String region;
  final CognitoOAuthConfig? hostedUI;

  @override
  List<Object?> get props => [
        poolId,
        appClientId,
        appClientSecret,
        region,
        hostedUI,
      ];

  CognitoUserPoolConfig copyWith({
    String? poolId,
    String? appClientId,
    String? appClientSecret,
    String? region,
    CognitoOAuthConfig? hostedUI,
  }) {
    return CognitoUserPoolConfig(
      poolId: poolId ?? this.poolId,
      appClientId: appClientId ?? this.appClientId,
      appClientSecret: appClientSecret ?? this.appClientSecret,
      region: region ?? this.region,
      hostedUI: hostedUI ?? this.hostedUI,
    );
  }

  @override
  Map<String, Object?> toJson() => _$CognitoUserPoolConfigToJson(this);
}
