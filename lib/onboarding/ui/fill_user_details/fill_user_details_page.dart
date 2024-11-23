import 'dart:developer';

import 'package:fitbangapp/onboarding/ui/fill_user_details/bloc/fill_user_details_bloc.dart';
import 'package:fitbangapp/onboarding/repos/user_repository.dart';
import 'package:fitbangapp/shared/widgets/big_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

class FillUserDetailsPage extends StatelessWidget {
  const FillUserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FillUserDetailsBloc(UserRepository(context.read<Isar>()))
            ..add(FillUserDetailsPageLoaded()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<FillUserDetailsBloc, FillUserDetailsState>(
          builder: (context, state) {
            log(state.toString());

            if (state is FillUserHeightShowing) {
              return const FillUserHeightView();
            }

            if (state is FillUserWeightShowing) {
              return const SetUserWeightView();
            }

            if (state is FillUserDetailsFail) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is FillUserAgeShowing) {
              return const SetUserAgeView();
            }

            if (state is FillUserGenderShowing) {
              return const SetUserGenderView();
            }

            if (state is FillUserDetailsComplete) {
              return const Center(
                child: Text('Complete'),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class FillUserHeightView extends StatefulWidget {
  const FillUserHeightView({super.key});

  @override
  State<FillUserHeightView> createState() => _FillUserHeightViewState();
}

class _FillUserHeightViewState extends State<FillUserHeightView> {
  late TextEditingController feetController, inchController;

  @override
  void initState() {
    super.initState();
    feetController = TextEditingController(text: "5");
    inchController = TextEditingController(text: '10');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How tall are you?',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 20),
          Form(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: feetController,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Feet',
                      suffixText: 'Feet',
                      suffixStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: inchController,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Inch',
                      suffixText: 'Inch',
                      suffixStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          BlocBuilder<FillUserDetailsBloc, FillUserDetailsState>(
            builder: (context, state) {
              return BigActionButton(
                label:
                    state is FillUserDetailsInProgress ? 'Saving...' : 'Save',
                onPressed: state is FillUserDetailsInProgress
                    ? null
                    : () {
                        final feet = int.tryParse(feetController.text);
                        final inch = int.tryParse(inchController.text);

                        if (feet == null || inch == null) {
                          log('Error: Feet or Inch null');
                          return;
                        }

                        context.read<FillUserDetailsBloc>().add(
                              SaveUserHeightPressed(
                                convertFeetInchToCm(feet, inch),
                              ),
                            );
                      },
              );
            },
          ),
        ],
      ),
    );
  }

  int convertFeetInchToCm(int feet, int inches) {
    const double cmPerInch = 2.54; // 1 inch = 2.54 cm
    const int inchesPerFoot = 12; // 1 foot = 12 inches

    int totalInches = (feet * inchesPerFoot) + inches;
    double cm = totalInches * cmPerInch;

    return cm.toInt();
  }
}

class SetUserWeightView extends StatefulWidget {
  const SetUserWeightView({super.key});

  @override
  State<SetUserWeightView> createState() => _SetUserWeightViewState();
}

class _SetUserWeightViewState extends State<SetUserWeightView> {
  late TextEditingController weightController;

  @override
  void initState() {
    super.initState();
    weightController = TextEditingController(text: '75');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How much do you weight?',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 20),
          Form(
            child: TextFormField(
              controller: weightController,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Weight',
                suffixText: 'Kg',
                suffixStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          BlocBuilder<FillUserDetailsBloc, FillUserDetailsState>(
            builder: (context, state) {
              return BigActionButton(
                label:
                    state is FillUserDetailsInProgress ? 'Saving...' : 'Save',
                onPressed: state is FillUserDetailsInProgress
                    ? null
                    : () {
                        final weight = int.tryParse(weightController.text);
                        context.read<FillUserDetailsBloc>().add(
                              SaveUserWeightPressed(weight ?? 75),
                            );
                      },
              );
            },
          ),
        ],
      ),
    );
  }
}

class SetUserAgeView extends StatefulWidget {
  const SetUserAgeView({super.key});

  @override
  State<SetUserAgeView> createState() => _SetUserAgeViewState();
}

class _SetUserAgeViewState extends State<SetUserAgeView> {
  late TextEditingController ageController;

  @override
  void initState() {
    super.initState();
    ageController = TextEditingController(text: '24');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How old are you?',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 20),
          Form(
            child: TextFormField(
              controller: ageController,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'Age',
                suffixStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          BlocBuilder<FillUserDetailsBloc, FillUserDetailsState>(
            builder: (context, state) {
              return BigActionButton(
                label:
                    state is FillUserDetailsInProgress ? 'Saving...' : 'Save',
                onPressed: state is FillUserDetailsInProgress
                    ? null
                    : () {
                        final age = int.tryParse(ageController.text);
                        context.read<FillUserDetailsBloc>().add(
                              SaveUserAgePressed(age ?? 24),
                            );
                      },
              );
            },
          ),
        ],
      ),
    );
  }
}

class SetUserGenderView extends StatefulWidget {
  const SetUserGenderView({super.key});

  @override
  State<SetUserGenderView> createState() => _SetUserGenderViewState();
}

class _SetUserGenderViewState extends State<SetUserGenderView> {
  bool isMale = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is your gender?',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (!isMale) {
                        setState(() {
                          isMale = true;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isMale ? Colors.black : Colors.grey.shade300,
                      ),
                      child: Center(
                        child: Text(
                          'Male',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: isMale ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (isMale) {
                        setState(() {
                          isMale = false;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: !isMale ? Colors.black : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Female',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: !isMale ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          BlocBuilder<FillUserDetailsBloc, FillUserDetailsState>(
            builder: (context, state) {
              return BigActionButton(
                label:
                    state is FillUserDetailsInProgress ? 'Saving...' : 'Save',
                onPressed: state is FillUserDetailsInProgress
                    ? null
                    : () {
                        context.read<FillUserDetailsBloc>().add(
                              SaveUserGenderPressed(isMale: isMale),
                            );
                      },
              );
            },
          ),
        ],
      ),
    );
  }
}
