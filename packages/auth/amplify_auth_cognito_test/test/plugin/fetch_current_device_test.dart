// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:amplify_auth_cognito_dart/amplify_auth_cognito_dart.dart';
import 'package:amplify_auth_cognito_dart/src/credentials/cognito_keys.dart';
import 'package:amplify_auth_cognito_dart/src/credentials/device_metadata_repository.dart';
import 'package:amplify_auth_cognito_dart/src/sdk/cognito_identity_provider.dart';
import 'package:amplify_auth_cognito_test/common/mock_clients.dart';
import 'package:amplify_auth_cognito_test/common/mock_config.dart';
import 'package:amplify_auth_cognito_test/common/mock_secure_storage.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:test/test.dart';

void main() {
  AmplifyLogger().logLevel = LogLevel.verbose;

  final userPoolKeys = CognitoUserPoolKeys(userPoolConfig);
  final identityPoolKeys = CognitoIdentityPoolKeys(identityPoolConfig);
  final testAuthRepo = AmplifyAuthProviderRepository();
  final mockDevice = DeviceType(deviceKey: deviceKey);
  final mockDeviceResponse = GetDeviceResponse(device: mockDevice);

  late DeviceMetadataRepository repo;
  late AmplifyAuthCognitoDart plugin;

  Future<String?> getDeviceKey() async {
    final secrets = await repo.get(username);
    return secrets?.deviceKey;
  }

  group('fetchCurrentDevice', () {
    setUp(() async {
      final secureStorage = MockSecureStorage();
      seedStorage(
        secureStorage,
        userPoolKeys: userPoolKeys,
        identityPoolKeys: identityPoolKeys,
        deviceKeys: CognitoDeviceKeys(userPoolConfig, username),
      );
      plugin = AmplifyAuthCognitoDart(
        secureStorageFactory: (_) => secureStorage,
      );
      await plugin.configure(
        config: mockConfig,
        authProviderRepo: testAuthRepo,
      );
      repo = plugin.stateMachine.getOrCreate<DeviceMetadataRepository>();
    });

    group('Cognito GetDevice returns successfully', () {
      setUp(() async {
        final mockIdp = MockCognitoIdentityProviderClient(
          getDevice: () async => mockDeviceResponse,
          forgetDevice: () async {},
        );
        plugin.stateMachine.addInstance<CognitoIdentityProviderClient>(mockIdp);
      });

      test(
          'should get the current device. current device id should be equal to the local device id',
          () async {
        final currentDeviceKey = await getDeviceKey();
        expect(currentDeviceKey, isNotNull);
        final currentDevice = await plugin.fetchCurrentDevice();
        expect(currentDeviceKey, currentDevice.id);
      });

      test(
          'should should throw a DeviceNotTrackedException when current device key is null',
          () async {
        await plugin.forgetDevice();
        await expectLater(
          plugin.fetchCurrentDevice,
          throwsA(isA<DeviceNotTrackedException>()),
        );
      });
    });

    group('Cognito GetDevice throws AWSHttpException', () {
      setUp(() async {
        final mockIdp = MockCognitoIdentityProviderClient(
          getDevice: () async => throw AWSHttpException(
            AWSHttpRequest.get(Uri.parse('https://aws.amazon.com/cognito/')),
          ),
        );
        plugin.stateMachine.addInstance<CognitoIdentityProviderClient>(mockIdp);
      });

      test('should throw a NetworkException', () async {
        await expectLater(
          plugin.fetchCurrentDevice,
          throwsA(isA<NetworkException>()),
        );
      });
    });

    tearDown(() async {
      await plugin.close();
    });
  });
}
