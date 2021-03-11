import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vccs/src/blocs/project_list/project_list_bloc.dart';
import 'package:vccs/src/ui/widgets/textfield.dart';

class SelectProject extends StatelessWidget {
  final bool filter;

  const SelectProject({Key key, this.filter = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 500,
        maxHeight: 400,
      ),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: VCCSTextFormField(
                label: "Search",
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: BlocBuilder<ProjectListBloc, ProjectListState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case ProjectListLoadingState:
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Row(children: [
                              Expanded(
                                child: SpinKitWave(
                                  color: Colors.grey[300],
                                ),
                              )
                            ]),
                          ),
                        );
                      case ProjectListDataState:
                        var typed = state as ProjectListDataState;
                        if (typed.projects.isEmpty)
                          return Center(
                            child: Text("There are no projects yet :("),
                          );
                        return ListView(
                          shrinkWrap: true,
                          children: [
                            ...typed.projects
                                .map((e) => ListTile(
                                      title: Text(e ?? "Unknown"),
                                      onTap: () {
                                        Navigator.pop(context, e);
                                      },
                                    ))
                                .toList()
                          ],
                        );
                      default:
                        return Center(
                          child: Text("Failed to get projects"),
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
