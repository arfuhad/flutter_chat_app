import 'package:flutter/material.dart';

class UiHeader extends StatelessWidget {
  const UiHeader({
    super.key,
    this.leftWidget,
    this.rightWidget,
    this.middleWidget,
  });

  final Widget? leftWidget;
  final Widget? rightWidget;
  final Widget? middleWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leftWidget ??
            const SizedBox(
              height: 40,
              width: 40,
            ),
        middleWidget ?? const SizedBox.shrink(),
        rightWidget ??
            const SizedBox(
              height: 40,
              width: 40,
            ),
      ],
    );
  }
}
