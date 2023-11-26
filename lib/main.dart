import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:news_app/config/theme/AppThemes.dart';
import 'package:news_app/features/daily_news/presentation/pages/Settings/SettingsSceeen.dart';
import 'package:news_app/features/daily_news/presentation/pages/savedNews/SavedNews.dart';
import 'package:provider/provider.dart';
import 'config/routes/Routes/AppRoutes.dart';
import 'features/daily_news/data/data_sources/local/Pref/ModelTheme.dart';
import 'features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'features/daily_news/presentation/pages/DailyNews/DailyNews.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
  ControllerInit.init();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Define your pages here
  final List<Widget> _pages = [
    const DailyNews(),
    const SavedNews(),
    const SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Your existing BlocProvider
        BlocProvider<RemoteArticleBloc>(
          create: (context) => s1()..add(const GetArticles()),
        ),
        // ChangeNotifierProvider for theme management
        ChangeNotifierProvider(
          create: (_) => ModelTheme(),
        ),
      ],
      child: Builder(
        builder: (context) {
          // Access the themeNotifier from the context
          var themeNotifier = Provider.of<ModelTheme>(context);

          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme : themeNotifier.isDark ? darkTheme : lightTheme,
            onGenerateRoute: AppRoutes.onGenerateRoutes,
            home: const DailyNews(),
          );
        },
      ),
    );
  }
}
