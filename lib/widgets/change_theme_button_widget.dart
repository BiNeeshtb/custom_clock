import 'package:custom_clock/config/color_palette.dart';

import 'package:custom_clock/provider/themeprovider.dart';
import 'package:flutter/material.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  final ThemeProvider theme;

  const ChangeThemeButtonWidget({Key? key, required this.theme})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: apptheme == 'light' ? false : true,
      onChanged: (value) {
        theme.toggleTheme(value);
      },
    );
  }
}
