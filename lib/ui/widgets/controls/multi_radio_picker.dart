import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/ui/shared/themes.dart';

class MultiRadioPicker<T> extends StatelessWidget {
  const MultiRadioPicker({
    Key? key,
    required this.value,
    required this.onCheck,
    required this.onUncheck,
    required this.onSelectAll,
    required this.onUnselectAll,
    required this.items,
    required this.checkedAll,
    this.title,
    this.description,
  }) : super(key: key);

  final List<MultiRadioItem<T>> items;
  final List<T> value;
  final void Function(T) onCheck;
  final void Function(T) onUncheck;
  final void Function() onSelectAll;
  final void Function() onUnselectAll;
  final String? title;
  final String? description;
  final bool checkedAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                    color: IGrooveTheme.colors.black!.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                InkWell(
                  onTap: checkedAll ? onUnselectAll : onSelectAll,
                  child: Text(
                    checkedAll
                        ? AppLocalizations.of(context)!.generalUnselectAll!
                        : AppLocalizations.of(context)!.generalSelectAll!,
                    style: TextStyle(
                      color: IGrooveTheme.colors.primary,
                      height: 17 / 14,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      letterSpacing: -0.16,
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 10),
          Divider(
            thickness: 1,
            color: IGrooveTheme.colors.white3,
            height: 0,
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: items.map(
              (MultiRadioItem<T> e) {
                items.length;
                final bool checked = value.contains(e.value);
                //final bool lastItem = items.indexOf(e) == items.length - 1;
                return InkWell(
                  onTap: !checked
                      ? () => onCheck(e.value)
                      : () => onUncheck(e.value),
                  child: Container(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        !checked
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: SvgPicture.asset(
                                  IGrooveAssets.svgCheckboxUnselected2,
                                  height: 20,
                                  width: 20,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: SvgPicture.asset(
                                  IGrooveAssets.svgCheckboxSelected,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 18),
                            padding: const EdgeInsets.only(bottom: 21),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: IGrooveTheme.colors.whiteColor!,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.title!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      height: 16 / 16,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.19,
                                      color: IGrooveTheme.colors.black),
                                ),
                                if (e.description != null)
                                  const SizedBox(height: 5),
                                if (e.description != null)
                                  Text(
                                    e.description!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade400,
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
                );
              },
            ).toList(),
          ),
          Divider(
            thickness: 1,
            color: IGrooveTheme.colors.white3,
            height: 0,
          ),
        ],
      ),
    );
  }
}

class MultiRadioItem<T> {
  const MultiRadioItem({
    required this.value,
    required this.title,
    this.description,
    this.trailing,
  });

  final String? title;
  final String? description;
  final Widget? trailing;
  final T value;
}
