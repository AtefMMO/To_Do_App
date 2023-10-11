import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app_theme.dart';
import 'package:todoapp/providers/app_config_provider.dart';
import 'package:todoapp/settings_tap/theme_sheet.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<AppConfigProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Mode',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        InkWell(
          onTap: () {
            showThemeSheet(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            height: MediaQuery.of(context).size.height * 0.08,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color:  provider.appTheme==ThemeMode.light?Colors.white:Colors.grey,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  provider.appTheme==ThemeMode.light?'Light Mode':'Dark Mode',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void showThemeSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder:(context) => ThemeSheet() );
  }
}
