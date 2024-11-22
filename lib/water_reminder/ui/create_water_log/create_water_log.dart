import 'package:fitbangapp/water_reminder/repos/water_log_repository.dart';
import 'package:fitbangapp/water_reminder/ui/create_water_log/bloc/create_water_log_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateWaterLogButton extends StatelessWidget {
  const CreateWaterLogButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreateWaterLogBloc(context.read<WaterLogRepository>()),
      child: BlocBuilder<CreateWaterLogBloc, CreateWaterLogState>(
        builder: (context, state) {
          return Center(
            child: SizedBox(
              height: 70,
              width: 70,
              child: FloatingActionButton(
                onPressed: state is CreateWaterLogInProgress
                    ? null
                    : () => context
                        .read<CreateWaterLogBloc>()
                        .add(CreateWaterLogPressed()),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                elevation: 0,
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                child: state is CreateWaterLogInProgress
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : const Icon(
                        Icons.add,
                        size: 30,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
