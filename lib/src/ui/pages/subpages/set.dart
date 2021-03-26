import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vccs/src/blocs/configuration_bloc/configuration_bloc.dart';
import 'package:vccs/src/blocs/project_bloc/project_bloc.dart';
import 'package:vccs/src/blocs/set_bloc/set_bloc.dart';
import 'package:vccs/src/globals.dart';
import 'package:vccs/src/model/domain/domian.dart';
import 'package:vccs/src/ui/widgets/buttons.dart';
import 'package:vccs/src/ui/widgets/cards.dart';
import 'package:vccs/src/ui/widgets/inherited.dart';
import 'package:vccs/src/ui/widgets/misc/set_preview_pics.dart';

class SetPage extends StatelessWidget {
  final VCCSSet set;

  SetPage({Key key, this.set}) : super(key: key);

  Widget _picture() {
    return SlotCard();
  }

  Widget _slotPictures(BuildContext context, VCCSSet set, List<Slot> slots) {
    return GridView.count(
      crossAxisCount: (MediaQuery.of(context).size.width / 200).floor(),
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: [
        ...slots
            .map((e) => SlotImagePreview(
                  slot: e,
                  set: set,
                ))
            .toList()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MultiCameraCaptureBloc bloc = MultiCameraCaptureBloc(
        AppData.of(context).controller,
        AppData.of(context).camerasCapture,
        configuration);
    var routeData = RouteData.of(context);
    var id = routeData.pathParams['id'].value;
    VCCSSet _set = context.read<ProjectBloc>().project.getSetById(id);
    List<Slot> slots = configuration.getSlots();
    return Scaffold(
      body: _set == null
          ? Center(
              child: Text("Unknown set"),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _set.name,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            ExtendedNavigator.named("project").pop();
                          })
                    ],
                  ),
                ),
                _slotPictures(context, _set, slots)
              ],
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            VCCSRaisedButton(
              color: Colors.red[400],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Delete Pictures"),
              ),
              onPressed: () {},
            ),
            BlocBuilder<MultiCameraCaptureBloc, MultiCameraCaptureState>(
              bloc: bloc,
              builder: (context, state) {
                switch (state.runtimeType) {
                  case SetCapturingState:
                    return VCCSRaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Taking Pictures"),
                      ),
                      onPressed: null,
                    );
                  default:
                    return VCCSRaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Take Pictures"),
                      ),
                      onPressed: () {
                        bloc.add(CaptureSetEvent(
                            set, context.read<ProjectBloc>().project));
                      },
                    );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
