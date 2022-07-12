import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';
import 'package:igroove_fan_box_one/ui/widgets/input_fields/base.dart';

class RadioPicker<T> extends StatelessWidget {
  const RadioPicker(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.items,
      this.title,
      this.readOnly = false,
      this.description,
      this.showCheckbox = true,
      this.enabled = true})
      : super(key: key);

  final List<RadioItem<T>> items;
  final T value;
  final void Function(T) onChanged;
  final String? title;
  final bool readOnly;
  final String? description;
  final bool enabled;
  final bool showCheckbox;

  _prepareList() {
    return items.map(
      (RadioItem<T> e) {
        int current = items.indexOf(e);

        bool showBorder = true;

        if (current == items.length - 1) showBorder = false;

        final bool checked = value == e.value;

        if (readOnly && !checked) {
          return const SizedBox();
        }

        return InkWell(
          onTap: () {
            if (enabled) onChanged(e.value);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showCheckbox)
                    checked
                        ? SvgPicture.asset(
                            IGrooveAssets.svgRadioButtonSelected2,
                            height: 26,
                            width: 26,
                            //color: IGrooveTheme.colors.black,
                          )
                        : SvgPicture.asset(
                            IGrooveAssets.svgRadioButtonUnselected2,
                            height: 26,
                            width: 26,
                            //color: IGrooveTheme.colors.black,
                          ),
                  if (showCheckbox) const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 0),
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: showBorder
                                  ? IGrooveTheme.colors.whiteColor!
                                  : IGrooveTheme.colors.transparent!),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 2),
                          Text(
                            e.title,
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: -0.2,
                              height: 20 / 16,
                              color: IGrooveTheme.colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          if (e.description != null &&
                              e.description!.isNotEmpty)
                            const SizedBox(height: 8),
                          if (e.description != null &&
                              e.description!.isNotEmpty)
                            Text(
                              e.description!,
                              style: TextStyle(
                                fontSize: 13,
                                height: 15 / 13,
                                letterSpacing: -0.15,
                                color:
                                    IGrooveTheme.colors.black!.withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 14,
                      color: IGrooveTheme.colors.black!.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 5),
                  if (title != null)
                    FieldHelper(
                      title: title,
                      description: description,
                    ),
                ],
              ),
            ),
          Container(
              height: 1,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: IGrooveTheme.colors.whiteColor!),
                ),
              )),
          ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: _prepareList()),
          Container(
              height: 1,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: IGrooveTheme.colors.whiteColor!),
                ),
              )),
          const SizedBox(height: 25)
        ],
      ),
    );
  }
}

class RadioItem<T> {
  const RadioItem(
      {required this.value,
      required this.title,
      this.description,
      this.trailing});

  final String title;
  final String? description;
  final Widget? trailing;
  final T value;
}
