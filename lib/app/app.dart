import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterquiz/core/core.dart';
import 'package:flutterquiz/features/ads/ads.dart';
import 'package:flutterquiz/features/auth/auth_repository.dart';
import 'package:flutterquiz/features/auth/cubits/auth_cubit.dart';
import 'package:flutterquiz/features/badges/badges_repository.dart';
import 'package:flutterquiz/features/badges/blocs/badges_cubit.dart';
import 'package:flutterquiz/features/battle_room/battle_room_repository.dart';
import 'package:flutterquiz/features/battle_room/cubits/battle_room_cubit.dart';
import 'package:flutterquiz/features/battle_room/cubits/multi_user_battle_room_cubit.dart';
import 'package:flutterquiz/features/bookmark/bookmark_repository.dart';
import 'package:flutterquiz/features/bookmark/cubits/audio_question_bookmark_cubit.dart';
import 'package:flutterquiz/features/bookmark/cubits/bookmark_cubit.dart';
import 'package:flutterquiz/features/bookmark/cubits/guess_the_word_bookmark_cubit.dart';
import 'package:flutterquiz/features/exam/cubits/exam_cubit.dart';
import 'package:flutterquiz/features/exam/exam_repository.dart';
import 'package:flutterquiz/features/profile_management/cubits/user_details_cubit.dart';
import 'package:flutterquiz/features/profile_management/profile_management_repository.dart';
import 'package:flutterquiz/features/quiz/cubits/comprehension_cubit.dart';
import 'package:flutterquiz/features/quiz/cubits/contest_cubit.dart';
import 'package:flutterquiz/features/quiz/cubits/quiz_category_cubit.dart';
import 'package:flutterquiz/features/quiz/cubits/subcategory_cubit.dart';
import 'package:flutterquiz/features/quiz/cubits/unlock_premium_category_cubit.dart';
import 'package:flutterquiz/features/quiz/cubits/unlocked_level_cubit.dart';
import 'package:flutterquiz/features/quiz/quiz_repository.dart';
import 'package:flutterquiz/features/settings/settings_cubit.dart';
import 'package:flutterquiz/features/settings/settings_local_data_source.dart';
import 'package:flutterquiz/features/settings/settings_repository.dart';
import 'package:flutterquiz/features/statistic/cubits/statistics_cubit.dart';
import 'package:flutterquiz/features/statistic/statistic_repository.dart';
import 'package:flutterquiz/features/system_config/cubits/system_config_cubit.dart';
import 'package:flutterquiz/features/system_config/system_config_repository.dart';
import 'package:flutterquiz/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:hive_flutter/hive_flutter.dart';

// Theme data map for different brightness modes
final appThemeData = <Brightness, ThemeData>{
  Brightness.light: AppTheme.lightTheme(),
  Brightness.dark: AppTheme.darkTheme(),
};

Future<Widget> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ).copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize Firebase. On web, ensure Firebase web options are configured.
  var firebaseConfigured = true;
  if (kIsWeb) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      firebaseConfigured = true;
    } on Exception catch (e) {
      // If web options are not configured (DefaultFirebaseOptions throws),
      // skip Firebase initialization to avoid crashing the app on web.
      // Firebase-dependent features will not work until web config is added.
      // Log to console for debugging.
      // ignore: avoid_print -- Needed to show Firebase web configuration error.
      print('Firebase web not configured: $e');
      firebaseConfigured = false;
    }
  } else {
    try {
      await Firebase.initializeApp();
      firebaseConfigured = true;
    } on Exception catch (e) {
      // ignore: avoid_print -- Needed to show Firebase initialization error.
      print('Firebase initialization failed: $e');
      firebaseConfigured = false;
    }
  }
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: false,
  );

  // Local phone storage
  await Hive.initFlutter();
  await Hive.openBox<dynamic>(authBox);
  await Hive.openBox<dynamic>(settingsBox);
  await Hive.openBox<dynamic>(userDetailsBox);
  await Hive.openBox<dynamic>(examBox);

  return MyApp(firebaseConfigured: firebaseConfigured);
}

class MyApp extends StatelessWidget {
  const MyApp({required this.firebaseConfigured, super.key});

  final bool firebaseConfigured;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(SettingsLocalDataSource()),
        ),
        BlocProvider<SettingsCubit>(
          create: (_) => SettingsCubit(SettingsRepository()),
        ),
        BlocProvider<AuthCubit>(create: (_) => AuthCubit(AuthRepository())),
        BlocProvider<AppLocalizationCubit>(
          create: (_) => AppLocalizationCubit(SettingsRepository()),
        ),
        BlocProvider<QuizLanguageCubit>(
          create: (_) => QuizLanguageCubit(SettingsLocalDataSource()),
        ),
        BlocProvider<UserDetailsCubit>(
          create: (_) => UserDetailsCubit(ProfileManagementRepository()),
        ),
        //bookmark questions of quiz zone
        BlocProvider<BookmarkCubit>(
          create: (_) => BookmarkCubit(BookmarkRepository()),
        ),
        BlocProvider<GuessTheWordBookmarkCubit>(
          create: (_) => GuessTheWordBookmarkCubit(BookmarkRepository()),
        ),
        BlocProvider<AudioQuestionBookmarkCubit>(
          create: (_) => AudioQuestionBookmarkCubit(BookmarkRepository()),
        ),
        BlocProvider<MultiUserBattleRoomCubit>(
          create: (_) => MultiUserBattleRoomCubit(BattleRoomRepository()),
        ),
        BlocProvider<BattleRoomCubit>(
          create: (_) => BattleRoomCubit(BattleRoomRepository()),
        ),
        BlocProvider<SystemConfigCubit>(
          create: (_) => SystemConfigCubit(SystemConfigRepository()),
        ),
        BlocProvider<BadgesCubit>(
          create: (_) => BadgesCubit(BadgesRepository()),
        ),
        BlocProvider<StatisticCubit>(
          create: (_) => StatisticCubit(StatisticRepository()),
        ),
        BlocProvider<InterstitialAdCubit>(create: (_) => InterstitialAdCubit()),
        BlocProvider<RewardedAdCubit>(create: (_) => RewardedAdCubit()),
        BlocProvider<ExamCubit>(create: (_) => ExamCubit(ExamRepository())),
        BlocProvider<ComprehensionCubit>(
          create: (_) => ComprehensionCubit(QuizRepository()),
        ),
        BlocProvider<ContestCubit>(
          create: (_) => ContestCubit(QuizRepository()),
        ),
        //
        BlocProvider<QuizCategoryCubit>(
          create: (_) => QuizCategoryCubit(QuizRepository()),
        ),
        BlocProvider<UnlockedLevelCubit>(
          create: (_) => UnlockedLevelCubit(QuizRepository()),
        ),
        BlocProvider<SubCategoryCubit>(
          create: (_) => SubCategoryCubit(QuizRepository()),
        ),
        BlocProvider<UnlockPremiumCategoryCubit>(
          create: (_) => UnlockPremiumCategoryCubit(QuizRepository()),
        ),
        BlocProvider<BannerAdCubit>(create: (_) => BannerAdCubit()),
      ],
      child: Builder(
        builder: (context) {
          final currentTheme = context.select<ThemeCubit, Brightness>(
            (bloc) => bloc.state,
          );

          return BlocBuilder<AppLocalizationCubit, AppLocalizationState>(
            buildWhen: (prev, curr) => prev.language.name != curr.language.name,
            builder: (context, state) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value:
                    (currentTheme == Brightness.light
                            ? SystemUiOverlayStyle.dark
                            : SystemUiOverlayStyle.light)
                        .copyWith(
                          statusBarColor: Colors.transparent,
                          systemNavigationBarColor: appThemeData[currentTheme]
                              ?.scaffoldBackgroundColor,
                          systemNavigationBarIconBrightness:
                              currentTheme == Brightness.light
                              ? Brightness.dark
                              : Brightness.light,
                        ),
                child: MaterialApp(
                  title: kAppName,
                  key: ValueKey(state.language.name),
                  builder: (_, widget) => Directionality(
                    textDirection: state.language.isRTL
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: widget!,
                  ),
                  navigatorKey: globalNavigator,
                  theme: appThemeData[currentTheme],
                  debugShowCheckedModeBanner: false,
                  // If Firebase is not configured on web, show a friendly fallback
                  // screen; otherwise use the normal initial route.
                  home: (kIsWeb && !firebaseConfigured)
                      ? const _FirebaseNotConfiguredScreen()
                      : null,
                  initialRoute: (kIsWeb && !firebaseConfigured)
                      ? null
                      : Routes.splash,
                  onGenerateRoute: Routes.onGenerateRouted,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// Simple fallback screen shown on web when Firebase isn't configured.
class _FirebaseNotConfiguredScreen extends StatelessWidget {
  const _FirebaseNotConfiguredScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuration Required')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 72, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Firebase is not configured for web. Some features may not work.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              Text(
                'Backend: $panelUrl',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 18),
            ],
          ),
        ),
      ),
      floatingActionButton: const ElevatedButton(
        onPressed: null,
        child: Text('Continue to app'),
      ),
    );
  }
}

