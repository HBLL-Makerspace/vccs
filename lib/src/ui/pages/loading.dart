import 'package:auto_route/auto_route.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vccs/src/blocs/loading_bloc/loading_bloc.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = LoadingBloc()..add(LoadEvent());
    return Scaffold(
      body: BlocListener<LoadingBloc, LoadingState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is LoadingFinished)
            ExtendedNavigator.of(context)
                .pushAndRemoveUntil("/home", (route) => true);
        },
        child: BlocBuilder<LoadingBloc, LoadingState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is LoadingDataState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.loading),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: new LinearPercentIndicator(
                              animation: true,
                              animateFromLastPercent: true,
                              width: 500.0,
                              lineHeight: 8.0,
                              percent: state.percent,
                              progressColor: Colors.blue,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
