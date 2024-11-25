import 'dart:developer';

import 'package:fitbangapp/water_reminder/repos/water_log_repository.dart';
import 'package:fitbangapp/water_reminder/ui/list_water_log/bloc/list_water_log_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WaterLogListView extends StatelessWidget {
  const WaterLogListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListWaterLogBloc(context.read<WaterLogRepository>())
        ..add(WaterLogsStreamSubRequested())
        ..add(WaterLogListViewLoaded()),
      child: BlocBuilder<ListWaterLogBloc, ListWaterLogState>(
        builder: (context, state) {
          log(state.toString());

          if (state is ListWaterLogSuccess) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: state.waterLogs.length,
              itemBuilder: (context, index) {
                final waterLog = state.waterLogs[index];
                final timestamp =
                    DateFormat('hh:mm a').format(waterLog.createdAt);
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${waterLog.amount} ml"),
                      Text(timestamp),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 0,
                  color: Colors.black12,
                );
              },
            );
          }

          if (state is ListWaterLogInProgress) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
