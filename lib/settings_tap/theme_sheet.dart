import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/app_config_provider.dart';

class ThemeSheet extends StatefulWidget {

  @override
  State<ThemeSheet> createState() => _ThemeSheetState();
}

class _ThemeSheetState extends State<ThemeSheet> {
  @override
  Widget build(BuildContext context) {
   var provider=Provider.of<AppConfigProvider>(context);
    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.light);
            },
            child: provider.appTheme==ThemeMode.light ?onSelected('Light Mode'):notSelected('Light Mode')
          ),
          InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.dark);
               },
            child:provider.appTheme==ThemeMode.dark ?onSelected('Dark Mode'):notSelected('Dark Mode')
          )
        ],
      ),
    );
  }

  Widget onSelected(String themeName){
   return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(themeName,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).primaryColor)),
          Icon(
            Icons.check,
            color: Theme.of(context).primaryColor,
            size: 30,
          )
        ],
      ),
    );
  }
  Widget notSelected(String themeName){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              themeName,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
            ),
            Icon(
              Icons.check,
              size: 30,
              color: Colors.grey,
            )
          ],
        ),
      );
  }
}
