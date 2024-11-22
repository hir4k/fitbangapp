import 'package:fitbangapp/water_reminder/repos/water_log_repository.dart';
import 'package:fitbangapp/water_reminder/ui/create_water_log/create_water_log.dart';
import 'package:fitbangapp/water_reminder/ui/list_water_log/water_log_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

class WaterReminderPage extends StatelessWidget {
  const WaterReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WaterLogRepository(context.read<Isar>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Water Reminder'),
        ),
        body: ListView(
          children: const [
            CreateWaterLogButton(),
            WaterLogListView(),
          ],
        ),
      ),
    );
  }
}
