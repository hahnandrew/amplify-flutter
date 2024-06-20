// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:amplify_auth_cognito_dart/amplify_auth_cognito_dart.dart';
import 'package:amplify_auth_cognito_dart/src/credentials/cognito_keys.dart';
import 'package:amplify_auth_cognito_dart/src/credentials/device_metadata_repository.dart';
import 'package:amplify_auth_cognito_dart/src/sdk/cognito_identity_provider.dart';
import 'package:amplify_auth_cognito_dart/src/state/cognito_state_machine.dart';
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

  late DeviceMetadataRepository repo;
  late AmplifyAuthCognitoDart plugin;
  late CognitoAuthStateMachine stateMachine;
  late MockSecureStorage secureStorage;

  Future<String?> getDeviceKey() async {
    final secrets = await repo.get(username);
    return secrets?.deviceKey;
  }

  group('getCurrentDevice', () {
    setUp(() async {
      secureStorage = MockSecureStorage();
      seedStorage(
        secureStorage,
        userPoolKeys: userPoolKeys,
        identityPoolKeys: identityPoolKeys,
        deviceKeys: CognitoDeviceKeys(userPoolConfig, username),
      );
      plugin = AmplifyAuthCognitoDart(
        secureStorageFactory: (_) => secureStorage,
      );
      stateMachine = plugin.stateMachine;
      await plugin.configure(
        config: mockConfig,
        authProviderRepo: testAuthRepo,
      );
      final mockIdp = MockCognitoIdentityProviderClient(
        getDevice: () async => GetDeviceResponse(device: mockDevice),
      );
      stateMachine.addInstance<CognitoIdentityProviderClient>(mockIdp);
      repo = stateMachine.getOrCreate<DeviceMetadataRepository>();
    });

    test('should get the current device. current device id should be equal to the local device id',
        () async {
      final currentDeviceKey = await getDeviceKey();
      expect(await repo.get(username), isNotNull);
      expect(currentDeviceKey, isNotNull);
      final currentDevice = await plugin.getCurrentDevice();
      expect(currentDeviceKey, currentDevice.id);
    });

    test('should should throw a DeviceNotTrackedException when current device key is null',
        () async {
      expect(await repo.get(username), isNotNull);
      await plugin.forgetDevice();
      await expectLater(() => plugin.getCurrentDevice(), throwsA(isA<DeviceNotTrackedException>));
    });

    tearDown(() async {
      await plugin.close();
    });
  });
}
