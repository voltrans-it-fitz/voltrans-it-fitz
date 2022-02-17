import 'package:flutter/material.dart';

import '../config/config.dart';

class MyTodoAppBar extends AppBar {
  // ignore: annotate_overrides, overridden_fields
  final double toolbarHeight;
  final Widget heading;
  final Widget subtitle;
  final Widget? popupMenuButton;

  MyTodoAppBar({
    Key? key,
    required this.toolbarHeight,
    required this.heading,
    required this.subtitle,
    this.popupMenuButton = const SizedBox.shrink(),
  }) : super(
          automaticallyImplyLeading: false,
          key: key,
          toolbarHeight: toolbarHeight,
          flexibleSpace: Container(
            padding: const EdgeInsets.only(
              left: SizeConfig.defaultPadding * 3,
              top: SizeConfig.defaultPadding * 3,
              right: SizeConfig.defaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    heading,
                    popupMenuButton ?? const SizedBox.shrink(),
                  ],
                ),
                subtitle,
                const Spacer(),
                const Divider(
                  thickness: 2,
                  endIndent: SizeConfig.defaultPadding * 2,
                )
              ],
            ),
          ),
        );
}
