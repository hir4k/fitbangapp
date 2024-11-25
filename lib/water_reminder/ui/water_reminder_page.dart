import 'dart:developer';

import 'package:fitbangapp/water_reminder/repos/water_log_repository.dart';
import 'package:fitbangapp/water_reminder/ui/bloc/water_reminder_bloc.dart';
import 'package:fitbangapp/water_reminder/ui/create_water_log/create_water_log.dart';
import 'package:fitbangapp/water_reminder/ui/list_water_log/water_log_list_view.dart';
import 'package:fitbangapp/water_reminder/ui/water_intake_progress/water_intake_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

class WaterReminderPage extends StatelessWidget {
  const WaterReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WaterLogRepository(context.read<Isar>()),
      child: BlocProvider(
        create: (context) => WaterReminderBloc(context.read<Isar>())
          ..add(WaterReminderPageLoaded()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Water Reminder'),
          ),
          body: BlocConsumer<WaterReminderBloc, WaterReminderState>(
            listener: (context, state) {
              if (state is WaterReminderError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message), backgroundColor: Colors.red));
              }
            },
            builder: (context, state) {
              log(state.toString());
              if (state is WaterReminderShowSetGoalView) {
                return const WaterReminderSetGoalView();
              } else if (state is WaterReminderShowMainView) {
                return const WaterReminderMainView();
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}

class WaterReminderSetGoalView extends StatefulWidget {
  const WaterReminderSetGoalView({super.key});

  @override
  State<WaterReminderSetGoalView> createState() =>
      _WaterReminderSetGoalViewState();
}

class _WaterReminderSetGoalViewState extends State<WaterReminderSetGoalView> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '2500');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              label: Text('Amount (ml)'),
              suffixText: 'ml',
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                context
                    .read<WaterReminderBloc>()
                    .add(CreateWaterGoalPressed(controller.text));
              },
              icon: const Icon(CupertinoIcons.add),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              label: const Text(
                'Create Water Goal',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaterReminderMainView extends StatelessWidget {
  const WaterReminderMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        WaterIntakeProgress(),
        CreateWaterLogButton(),
        WaterLogListView(),
      ],
    );
  }
}
