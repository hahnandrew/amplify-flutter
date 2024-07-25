import 'package:amplify_storage_s3_example/common/navigation/router/routes.dart';
import 'package:amplify_storage_s3_example/common/utils/colors.dart'
    as constants;
import 'package:amplify_storage_s3_example/features/trip/controller/trip_controller.dart';
import 'package:amplify_storage_s3_example/features/trip/ui/trip_page/trip_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TripPage extends ConsumerWidget {
  const TripPage({
    required this.tripId,
    super.key,
  });
  final String tripId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripValue = ref.watch(tripControllerProvider(tripId));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'dasfdAmplify Trips Planner',
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed(
                AppRoute.home.name,
              );
            },
            icon: const Icon(Icons.home),
          ),
        ],
        backgroundColor: const Color(constants.primaryColorDark),
      ),
      body: TripDetails(
        tripId: tripId,
        trip: tripValue,
      ),
    );
  }
}
