import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3_example/common/utils/colors.dart'
    as constants;
import 'package:amplify_storage_s3_example/common/utils/colors.dart'
    as constants;
import 'package:amplify_storage_s3_example/features/trip/controller/trips_list_controller.dart';
import 'package:amplify_storage_s3_example/features/trip/ui/trips_gridview/trips_list_gridview.dart';
import 'package:amplify_storage_s3_example/features/trip/ui/trips_list/add_trip_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3_example/models/ModelProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amplify_api/amplify_api.dart';

Future<List<AuthDevice>> fetchAllDevices() async {
  // final devices = await Amplify.Auth.fetchDevices();
  final mockDevices = [
    CognitoDevice(
      id: 'us-east-2-b81b45a6',
    ),
    CognitoDevice(
        id: 'us-east-2-6502d811',
        name: 'Andrew\'s iPad',
        createdDate: DateTime.now()),
    CognitoDevice(id: 'us-east-2-911245a6', name: 'Andrew\'s Macbook'),
    CognitoDevice(id: 'us-east-2-45a6d371', name: 'Andrew\'s Mac Air'),
  ];

  // Append mock devices to the real devices
  return mockDevices;
}

class TripsListPage extends ConsumerStatefulWidget {
  const TripsListPage({Key? key}) : super(key: key);

  @override
  _TripsListPageState createState() => _TripsListPageState();
}

class _TripsListPageState extends ConsumerState<TripsListPage> {
  List<AuthDevice> devices = [];

  @override
  void initState() {
    super.initState();
    _loadDevices();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showInitialWarning());
  }

  Future<void> _loadDevices() async {
    final loadedDevices = await fetchAllDevices();
    setState(() {
      devices = loadedDevices;
    });
  }

  void _showInitialWarning() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Too Many Devices',
              style: TextStyle(color: Color(constants.primaryColorDark))),
          content: Text(
            'You are currently logged into too many devices. Please log out of at least three devices to continue.',
            style: TextStyle(fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK',
                  style: TextStyle(color: Color(constants.primaryColorDark))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showLogoutConfirmation(List<AuthDevice> loggedOutDevices) {
    final deviceNames =
        loggedOutDevices.map((d) => d.name ?? 'Unnamed Device').join(', ');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('The following devices have been logged out: $deviceNames'),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Personal Devices'),
        backgroundColor: const Color(constants.primaryColorDark),
      ),
      body: Column(
        children: [
          Expanded(
            child: devices.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      final device = devices[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        elevation: 4,
                        child: ListTile(
                          leading: const Icon(Icons.devices,
                              color: Color(constants.primaryColorDark)),
                          title: Text(
                            device.name ?? 'Andrew\'s iPhone',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('ID: ${device.id}'),
                          trailing: Icon(
                            device.name == null
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Color(constants.primaryColorDark),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(constants.primaryColorDark),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Warning'),
                      content: const Text(
                          'Are you sure you want to forget all devices except the current one? This action cannot be undone.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Confirm'),
                          onPressed: () {
                            print('button pressed');
                            final loggedOutDevices = devices
                                .where((device) => device.name != null)
                                .toList();
                            setState(() {
                              devices
                                  .removeWhere((device) => device.name != null);
                            });
                            Navigator.of(context).pop();
                            _showLogoutConfirmation(loggedOutDevices);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Remove Other Devices'),
            ),
          ),
        ],
      ),
      // ... (floatingActionButton remains the same)
    );
  }
}
