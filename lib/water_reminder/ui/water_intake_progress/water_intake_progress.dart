import 'package:fitbangapp/water_reminder/ui/water_intake_progress/bloc/water_intake_progress_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

class WaterIntakeProgress extends StatelessWidget {
  const WaterIntakeProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WaterIntakeProgressBloc(context.read<Isar>())
        ..add(WaterIntakeProgressLoaded()),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: Colors.white),
        child: BlocBuilder<WaterIntakeProgressBloc, WaterIntakeProgressState>(
          builder: (context, state) {
            if (state is FetchWaterIntakeSuccess) {
              return Text(
                  "${state.todayTotalWaterIntakeAmount} / ${state.todayWaterIntakeGoalAmount} ml");
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
