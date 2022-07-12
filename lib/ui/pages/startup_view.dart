import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/core/view_models/views/startup_viewmodel.dart';
import 'package:igroove_fan_box_one/ui/base_widget.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';
import 'package:igroove_fan_box_one/ui/widgets/loading_overlay.dart';
import 'package:provider/provider.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<StartUpViewModel>(
      model: StartUpViewModel(
        generalService: Provider.of(context),
        // pushNotificationService: Provider.of(context),
        dynamicLinksService: Provider.of(context),
      ),
      onModelReady: (StartUpViewModel model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: IGrooveTheme.colors.black2,
          body: const Center(child: IGrooveProgressIndicator()),
        );
      },
    );
  }
}
