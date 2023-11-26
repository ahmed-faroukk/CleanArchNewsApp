// Import necessary packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:day_night_switch/day_night_switch.dart';

// Import your ModelTheme class (replace with the correct path)
import '../../../data/data_sources/local/Pref/ModelTheme.dart';

// AnimatedSwitchIcon class
class AnimatedSwitchIcon extends StatelessWidget {
  final ModelTheme themeNotifier;

  AnimatedSwitchIcon({required this.themeNotifier, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        themeNotifier.isDark = !themeNotifier.isDark;
      },
      child: DayNightSwitch(
        value: themeNotifier.isDark,
        sunColor: Colors.yellow,
        moonColor: Colors.white,
        dayColor: Colors.transparent,
        nightColor: Colors.transparent,
        onChanged: (value) {
          themeNotifier.isDark = value;
        },
      ),
    );
  }
}

// SwitchWidget class
class SwitchWidget extends StatelessWidget {
  final ModelTheme themeNotifier;

  const SwitchWidget({required this.themeNotifier, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
          return AnimatedSwitchIcon(themeNotifier: themeNotifier);
        },
      ),
    );
  }
}

// SettingScreen class
class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
            return SwitchWidget(themeNotifier: themeNotifier);
          },
        ),
      ),
    );
  }
}
