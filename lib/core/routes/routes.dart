import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterquiz/commons/screens/dashboard_screen.dart';
import 'package:flutterquiz/ui/screens/about_app_screen.dart';
import 'package:flutterquiz/ui/screens/app_settings_screen.dart';
import 'package:flutterquiz/ui/screens/bookmark_screen.dart';
import 'package:flutterquiz/ui/screens/category_screen.dart';
import 'package:flutterquiz/ui/screens/category_screen_variant_2.dart';
import 'package:flutterquiz/ui/screens/forgot_password_screen.dart';
import 'package:flutterquiz/ui/screens/forgot_password_screen_variant_2.dart';
import 'package:flutterquiz/ui/screens/home_screen_variant_2.dart';
import 'package:flutterquiz/ui/screens/home_screen_variant_3.dart';
import 'package:flutterquiz/ui/screens/home_screen_variant_4.dart';
import 'package:flutterquiz/ui/screens/initial_language_selection_screen.dart';
import 'package:flutterquiz/ui/screens/language_selection_screen_variant_2.dart';
import 'package:flutterquiz/ui/screens/notifications_screen.dart';
import 'package:flutterquiz/ui/screens/onboarding_screen_variant_2.dart';
import 'package:flutterquiz/ui/screens/onboarding_screen_variant_3.dart';
import 'package:flutterquiz/ui/screens/onboarding_screen_variant_4.dart';
import 'package:flutterquiz/ui/screens/onboarding_screen_variant_5.dart';
import 'package:flutterquiz/ui/screens/otp_screen.dart';
import 'package:flutterquiz/ui/screens/otp_screen_variant_2.dart';
import 'package:flutterquiz/ui/screens/refer_and_earn_screen.dart';
import 'package:flutterquiz/ui/screens/search_screen.dart';
import 'package:flutterquiz/ui/screens/search_screen_variant_2.dart';
import 'package:flutterquiz/ui/screens/search_screen_variant_3.dart';
import 'package:flutterquiz/ui/screens/sign_in_screen.dart';
import 'package:flutterquiz/ui/screens/sign_in_screen_variant_2.dart';
import 'package:flutterquiz/ui/screens/sign_in_screen_variant_3.dart';
import 'package:flutterquiz/ui/screens/sign_up_screen.dart';
import 'package:flutterquiz/ui/screens/sign_up_screen_variant_2.dart';
import 'package:flutterquiz/ui/screens/sign_up_screen_variant_3.dart';
import 'package:flutterquiz/ui/screens/splash_screen.dart';
import 'package:flutterquiz/ui/screens/splash_screen_variant_2.dart';
import 'package:flutterquiz/ui/screens/splash_screen_variant_3.dart';
import 'package:flutterquiz/ui/screens/statistics_screen.dart';
import 'package:flutterquiz/ui/screens/true_splash_screen_v2.dart';
import 'package:flutterquiz/ui/screens/onboarding_ultimate_challenge_v2.dart';
import 'package:flutterquiz/ui/screens/onboarding_get_ready_v2.dart';
import 'package:flutterquiz/ui/screens/language_selection_flags_v2.dart';
import 'package:flutterquiz/ui/screens/sign_in_email_v2.dart';
import 'package:flutterquiz/ui/screens/sign_up_email_v2.dart';
import 'package:flutterquiz/ui/screens/profile_avatar_selection_grid_v2.dart';
import 'package:flutterquiz/ui/screens/profile_name_input_v2.dart';
import 'package:flutterquiz/ui/screens/profile_statistics_v2.dart';
import 'package:flutterquiz/ui/screens/profile_edit_v2.dart';
import 'package:flutterquiz/ui/screens/coin_store_packages_v2.dart';
import 'package:flutterquiz/ui/screens/payment_method_selection_v2.dart';
import 'package:flutterquiz/ui/screens/payment_success_v2.dart';
import 'package:flutterquiz/ui/screens/battle_mode_selection_v2.dart';
import 'package:flutterquiz/ui/screens/battle_countdown_v2.dart';
import 'package:flutterquiz/ui/screens/battle_room_create_v2.dart';
import 'package:flutterquiz/ui/screens/battle_room_join_v2.dart';
import 'package:flutterquiz/ui/screens/battle_quiz_in_progress_v2.dart';
import 'package:flutterquiz/ui/screens/battle_completion_v2.dart';
import 'package:flutterquiz/ui/screens/battle_quick_chat_v2.dart';
import 'package:flutterquiz/ui/screens/battle_pin_entry_v2.dart';
import 'package:flutterquiz/ui/screens/battle_match_finding_v2.dart';
import 'package:flutterquiz/ui/screens/mini_games_grid_v2.dart';
import 'package:flutterquiz/ui/screens/game_tic_tac_toe_v2.dart';
import 'package:flutterquiz/ui/screens/game_number_puzzle_v2.dart';
import 'package:flutterquiz/ui/screens/game_memory_cards_v2.dart';
import 'package:flutterquiz/ui/screens/game_guess_word_v2.dart';
import 'package:flutterquiz/ui/screens/quiz_playing_screen_v2.dart';
import 'package:flutterquiz/ui/screens/quiz_victory_results_v2.dart';
import 'package:flutterquiz/ui/screens/quiz_defeat_results_v2.dart';
import 'package:flutterquiz/ui/screens/quiz_review_answers_v2.dart';
import 'package:flutterquiz/ui/screens/contest_entry_v2.dart';
import 'package:flutterquiz/ui/screens/leaderboard_podium_v2.dart';
import 'package:flutterquiz/ui/screens/badges_collection_v2.dart';
import 'package:flutterquiz/ui/screens/daily_rewards_v2.dart';
import 'package:flutterquiz/ui/screens/rewards_leaderboard_v2.dart';
import 'package:flutterquiz/ui/screens/settings_main_v2.dart';
import 'package:flutterquiz/ui/screens/settings_sound_v2.dart';
import 'package:flutterquiz/ui/screens/settings_language_v2.dart';
import 'package:flutterquiz/ui/screens/notifications_list_v2.dart';
import 'package:flutterquiz/ui/screens/friends_list_v2.dart';
import 'package:flutterquiz/ui/screens/friend_chat_v2.dart';
import 'package:flutterquiz/ui/screens/scratch_card_v2.dart';
import 'package:flutterquiz/ui/screens/category_selection_tabs_v2.dart';
import 'package:flutterquiz/ui/screens/home_quiz_feed_v2.dart';
import 'package:flutterquiz/ui/screens/referral_earn_v2.dart';

final globalNavigator = GlobalKey<NavigatorState>();
final BuildContext globalCtx = globalNavigator.currentContext!;

class Routes {
  static const home = '/';
  static const login = 'login';
  static const splash = 'splash';
  static const splashVariant2 = '/splashVariant2';
  static const splashVariant3 = '/splashVariant3';
  static const signUp = 'signUp';
  static const introSlider = 'introSlider';
  static const selectProfile = 'selectProfile';
  static const onboardingVariant2 = '/onboardingVariant2';
  static const onboardingVariant3 = '/onboardingVariant3';
  static const onboardingVariant4 = '/onboardingVariant4';
  static const onboardingVariant5 = '/onboardingVariant5';
  static const languageSelect = '/language-select';
  static const languageSelectVariant2 = '/languageSelectVariant2';
  static const signInVariant2 = '/signInVariant2';
  static const signInVariant3 = '/signInVariant3';
  static const signUpVariant2 = '/signUpVariant2';
  static const signUpVariant3 = '/signUpVariant3';
  static const otpScreenVariant2 = '/otpScreenVariant2';
  static const forgotPasswordVariant2 = '/forgotPasswordVariant2';
  static const homeVariant2 = '/homeVariant2';
  static const homeVariant3 = '/homeVariant3';
  static const homeVariant4 = '/homeVariant4';
  static const searchVariant2 = '/searchVariant2';
  static const searchVariant3 = '/searchVariant3';
  static const categoryVariant2 = '/categoryVariant2';
  static const categoryVariant3 = '/categoryVariant3';
  static const quizZoneVariant2 = '/quizZoneVariant2';
  static const quizVariant2 = '/quizVariant2';
  static const quizVariant3 = '/quizVariant3';
  static const quizResultsVariant2 = '/quizResultsVariant2';
  static const reviewQuizVariant2 = '/reviewQuizVariant2';
  static const battleRoomVariant2 = '/battleRoomVariant2';
  static const examVariant2 = '/examVariant2';
  static const profileVariant2 = '/profileVariant2';
  static const leaderboardVariant2 = '/leaderboardVariant2';
  static const friendsVariant2 = '/friendsVariant2';
  static const challengeVariant2 = '/challengeVariant2';
  static const badgesVariant2 = '/badgesVariant2';
  static const statisticsVariant2 = '/statisticsVariant2';
  static const quote = '/quiz';
  static const multiMatchQuiz = '/multiMatchQuiz';
  static const multiMatchResultScreen = '/multiMatchResultScreen';
  static const multiMatchReviewScreen = '/multiMatchReviewScreen';
  static const subcategoryAndLevel = '/subcategoryAndLevel';
  static const subCategory = '/subCategory';

  static const referAndEarn = '/referAndEarn';
  static const notification = '/notification';
  static const bookmark = '/bookmark';
  static const bookmarkQuiz = '/bookmarkQuiz';
  static const coinStore = '/coinStore';
  static const rewards = '/rewards';
  static const result = '/result';
  static const selectRoom = '/selectRoom';
  static const category = '/category';
  static const editProfile = '/editProfile';
  static const settings = '/settings';
  static const reviewAnswers = '/reviewAnswers';
  static const selfChallenge = '/selfChallenge';
  static const selfChallengeQuestions = '/selfChallengeQuestions';
  static const battleRoomQuiz = '/battleRoomQuiz';
  static const battleRoomFindOpponent = '/battleRoomFindOpponent';

  static const logOut = '/logOut';
  static const trueFalse = '/trueFalse';
  static const multiUserBattleRoomQuiz = '/multiUserBattleRoomQuiz';
  static const multiUserBattleRoomQuizResult = '/multiUserBattleRoomQuizResult';

  static const contest = '/contest';
  static const contestLeaderboard = '/contestLeaderboard';
  static const funAndLearnTitle = '/funAndLearnTitle';
  static const funAndLearn = 'funAndLearn';
  static const guessTheWord = '/guessTheWord';
  static const appSettings = '/appSettings';
  static const levels = '/levels';
  static const aboutApp = '/aboutApp';
  static const badges = '/badges';
  static const exams = '/exams';
  static const exam = '/exam';
  static const otpScreen = '/otpScreen';
  static const statistics = '/statistics';
  static const coinHistory = '/coinHistory';
  static const wallet = '/wallet';
  static const randomBattle = '/randomBattle';
  static const forgotPassword = '/forgotPassword';
  static const search = '/search';
  static const quizZone = '/quizZone';
  static const quizResults = '/quizResults';
  static const reviewQuiz = '/reviewQuiz';
  static const battleRoom = '/battleRoom';
  static const profile = '/profile';
  static const leaderboard = '/leaderboard';
  static const friends = '/friends';
  static const challenge = '/challenge';
  static const helpSupport = '/helpSupport';
  static const performance = '/performance';
  static const subscription = '/subscription';
  static const referral = '/referral';

  // V2 Routes
  static const trueSplashV2 = '/true-splash-v2';
  static const onboardingUltimateV2 = '/onboarding-ultimate';
  static const onboardingGetReadyV2 = '/onboarding-get-ready';
  static const languageSelectionFlagsV2 = '/language-selection';
  static const signInEmailV2 = '/sign-in-email';
  static const signUpEmailV2 = '/sign-up-email';
  static const profileAvatarSelectionV2 = '/profile-avatar-selection';
  static const profileNameInputV2 = '/profile-name-input';
  static const profileStatisticsV2 = '/profile-statistics';
  static const profileEditV2 = '/profile-edit';
  static const coinStorePackagesV2 = '/coin-store-packages';
  static const paymentMethodSelectionV2 = '/payment-method-selection';
  static const paymentSuccessV2 = '/payment-success';
  static const battleModeSelectionV2 = '/battle-mode-selection';
  static const battleCountdownV2 = '/battle-countdown';
  static const battleRoomCreateV2 = '/battle-room-created';
  static const battleRoomJoinV2 = '/battle-room-join';
  static const battleQuizInProgressV2 = '/battle-quiz-in-progress';
  static const battleCompletionV2 = '/battle-completion';
  static const battleQuickChatV2 = '/battle-quick-chat';
  static const battlePinEntryV2 = '/battle-pin-entry';
  static const battleMatchFindingV2 = '/battle-match-finding';
  static const miniGamesGridV2 = '/mini-games';
  static const gameTicTacToeV2 = '/game-tic-tac-toe';
  static const gameNumberPuzzleV2 = '/game-number-puzzle';
  static const gameMemoryCardsV2 = '/game-memory-cards';
  static const gameGuessWordV2 = '/game-guess-word';
  static const quizPlayingV2 = '/quiz-playing';
  static const quizVictoryV2 = '/quiz-victory';
  static const quizDefeatV2 = '/quiz-defeat';
  static const quizReviewV2 = '/quiz-review';
  static const contestEntryV2 = '/contest-entry';
  static const leaderboardPodiumV2 = '/leaderboard-podium';
  static const badgesCollectionV2 = '/badges-collection';
  static const dailyRewardsV2 = '/daily-rewards';
  static const rewardsLeaderboardV2 = '/rewards-leaderboard';
  static const settingsMainV2 = '/settings-main';
  static const settingsSoundV2 = '/sound-settings';
  static const settingsLanguageV2 = '/language-settings';
  static const notificationsListV2 = '/notifications-list';
  static const friendsListV2 = '/friends-list';
  static const friendChatV2 = '/friend-chat';
  static const scratchCardV2 = '/scratch-card';
  static const categorySelectionTabsV2 = '/category-tabs';
  static const homeQuizFeedV2 = '/home-quiz-feed';
  static const referralEarnV2 = '/referral-earn';

  static String currentRoute = splash;

  static Route<dynamic>? onGenerateRouted(RouteSettings rs) {
    //to track current route
    //this will only track pushed route on top of previous route
    currentRoute = rs.name ?? '';

    if (rs.name!.contains('/link')) {
      return null;
    }

    log(name: 'Current Route', currentRoute);

    final args = rs.arguments;

    switch (rs.name) {
      case splash:
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
      case splashVariant2:
        return CupertinoPageRoute(builder: (_) => const SplashScreenVariant2());
      case splashVariant3:
        return CupertinoPageRoute(builder: (_) => const SplashScreenVariant3());
      case home:
        return DashboardScreen.route();
      case onboardingVariant2:
        return CupertinoPageRoute(builder: (_) => const OnboardingScreenVariant2());
      case onboardingVariant3:
        return CupertinoPageRoute(builder: (_) => const OnboardingScreenVariant3());
      case onboardingVariant4:
        return CupertinoPageRoute(builder: (_) => const OnboardingScreenVariant4());
      case onboardingVariant5:
        return CupertinoPageRoute(builder: (_) => const OnboardingScreenVariant5());
      case login:
        return CupertinoPageRoute(builder: (_) => const SignInScreen());
      case signInVariant2:
        return CupertinoPageRoute(builder: (_) => const SignInScreenVariant2());
      case signInVariant3:
        return CupertinoPageRoute(builder: (_) => const SignInScreenVariant3());
      case signUp:
        return CupertinoPageRoute(builder: (_) => const SignUpScreen());
      case signUpVariant2:
        return CupertinoPageRoute(builder: (_) => const SignUpScreenVariant2());
      case signUpVariant3:
        return CupertinoPageRoute(builder: (_) => const SignUpScreenVariant3());
      case otpScreen:
        final email = (args as Map<String, dynamic>?)?['email'] as String? ?? 'user@example.com';
        return CupertinoPageRoute(builder: (_) => OtpScreen(email: email));
      case otpScreenVariant2:
        final email = (args as Map<String, dynamic>?)?['email'] as String? ?? 'user@example.com';
        return CupertinoPageRoute(builder: (_) => OtpScreenVariant2(email: email));
      case forgotPassword:
        return CupertinoPageRoute(builder: (_) => const ForgotPasswordScreen());
      case forgotPasswordVariant2:
        return CupertinoPageRoute(builder: (_) => const ForgotPasswordScreenVariant2());
      case languageSelect:
        return CupertinoPageRoute(builder: (_) => const InitialLanguageSelectionScreen());
      case languageSelectVariant2:
        return CupertinoPageRoute(builder: (_) => const LanguageSelectionScreenVariant2());
      case search:
        return CupertinoPageRoute(builder: (_) => const SearchScreen());
      case searchVariant2:
        return CupertinoPageRoute(builder: (_) => const SearchScreenVariant2());
      case searchVariant3:
        return CupertinoPageRoute(builder: (_) => const SearchScreenVariant3());
      case appSettings:
        return CupertinoPageRoute(builder: (_) => const AppSettingsScreen());
      case aboutApp:
        return CupertinoPageRoute(builder: (_) => const AboutAppScreen());
      case bookmark:
        return CupertinoPageRoute(builder: (_) => const BookmarkScreen());
      case notification:
        return CupertinoPageRoute(builder: (_) => const NotificationsScreen());
      case statistics:
        return CupertinoPageRoute(builder: (_) => const StatisticsScreen());
      case referAndEarn:
        return CupertinoPageRoute(builder: (_) => const ReferAndEarnScreen());
      case category:
        return CupertinoPageRoute(builder: (_) => const CategoryScreen());
      case categoryVariant2:
        return CupertinoPageRoute(builder: (_) => const CategoryScreenVariant2());
      case homeVariant2:
        return CupertinoPageRoute(builder: (_) => const HomeScreenVariant2());
      case homeVariant3:
        return CupertinoPageRoute(builder: (_) => const HomeScreenVariant3());
      case homeVariant4:
        return CupertinoPageRoute(builder: (_) => const HomeScreenVariant4());
      case trueSplashV2:
        return CupertinoPageRoute(builder: (_) => const TrueSplashScreenV2());
      case onboardingUltimateV2:
        return CupertinoPageRoute(builder: (_) => const OnboardingUltimateChallengeV2());
      case onboardingGetReadyV2:
        return CupertinoPageRoute(builder: (_) => const OnboardingGetReadyV2());
      case languageSelectionFlagsV2:
        return CupertinoPageRoute(builder: (_) => const LanguageSelectionFlagsV2());
      case signInEmailV2:
        return CupertinoPageRoute(builder: (_) => const SignInEmailV2());
      case signUpEmailV2:
        return CupertinoPageRoute(builder: (_) => const SignUpEmailV2());
      case profileAvatarSelectionV2:
        return CupertinoPageRoute(builder: (_) => const ProfileAvatarSelectionGridV2());
      case profileNameInputV2:
        return CupertinoPageRoute(builder: (_) => const ProfileNameInputV2());
      case profileStatisticsV2:
        return CupertinoPageRoute(builder: (_) => const ProfileStatisticsV2());
      case profileEditV2:
        return CupertinoPageRoute(builder: (_) => const ProfileEditV2());
      case coinStorePackagesV2:
        return CupertinoPageRoute(builder: (_) => const CoinStorePackagesV2());
      case paymentMethodSelectionV2:
        return CupertinoPageRoute(builder: (_) => const PaymentMethodSelectionV2());
      case paymentSuccessV2:
        return CupertinoPageRoute(builder: (_) => const PaymentSuccessV2());
      case battleModeSelectionV2:
        return CupertinoPageRoute(builder: (_) => const BattleModeSelectionV2());
      case battleCountdownV2:
        return CupertinoPageRoute(builder: (_) => const BattleCountdownV2());
      case battleRoomCreateV2:
        return CupertinoPageRoute(builder: (_) => const BattleRoomCreateV2());
      case battleRoomJoinV2:
        return CupertinoPageRoute(builder: (_) => const BattleRoomJoinV2());
      case battleQuizInProgressV2:
        return CupertinoPageRoute(builder: (_) => const BattleQuizInProgressV2());
      case battleCompletionV2:
        return CupertinoPageRoute(builder: (_) => const BattleCompletionV2());
      case battleQuickChatV2:
        return CupertinoPageRoute(builder: (_) => const BattleQuickChatV2());
      case battlePinEntryV2:
        return CupertinoPageRoute(builder: (_) => const BattlePinEntryV2());
      case battleMatchFindingV2:
        return CupertinoPageRoute(builder: (_) => const BattleMatchFindingV2());
      case miniGamesGridV2:
        return CupertinoPageRoute(builder: (_) => const MiniGamesGridV2());
      case gameTicTacToeV2:
        return CupertinoPageRoute(builder: (_) => const GameTicTacToeV2());
      case gameNumberPuzzleV2:
        return CupertinoPageRoute(builder: (_) => const GameNumberPuzzleV2());
      case gameMemoryCardsV2:
        return CupertinoPageRoute(builder: (_) => const GameMemoryCardsV2());
      case gameGuessWordV2:
        return CupertinoPageRoute(builder: (_) => const GameGuessWordV2());
      case quizPlayingV2:
        return CupertinoPageRoute(builder: (_) => const QuizPlayingScreenV2());
      case quizVictoryV2:
        return CupertinoPageRoute(builder: (_) => const QuizVictoryResultsV2());
      case quizDefeatV2:
        return CupertinoPageRoute(builder: (_) => const QuizDefeatResultsV2());
      case quizReviewV2:
        return CupertinoPageRoute(builder: (_) => const QuizReviewAnswersV2());
      case contestEntryV2:
        return CupertinoPageRoute(builder: (_) => const ContestEntryV2());
      case leaderboardPodiumV2:
        return CupertinoPageRoute(builder: (_) => const LeaderboardPodiumV2());
      case badgesCollectionV2:
        return CupertinoPageRoute(builder: (_) => const BadgesCollectionV2());
      case dailyRewardsV2:
        return CupertinoPageRoute(builder: (_) => const DailyRewardsV2());
      case rewardsLeaderboardV2:
        return CupertinoPageRoute(builder: (_) => const RewardsLeaderboardV2());
      case settingsMainV2:
        return CupertinoPageRoute(builder: (_) => const SettingsMainV2());
      case settingsSoundV2:
        return CupertinoPageRoute(builder: (_) => const SettingsSoundV2());
      case settingsLanguageV2:
        return CupertinoPageRoute(builder: (_) => const SettingsLanguageV2());
      case notificationsListV2:
        return CupertinoPageRoute(builder: (_) => const NotificationsListV2());
      case friendsListV2:
        return CupertinoPageRoute(builder: (_) => const FriendsListV2());
      case friendChatV2:
        return CupertinoPageRoute(builder: (_) => const FriendChatV2());
      case scratchCardV2:
        return CupertinoPageRoute(builder: (_) => const ScratchCardV2());
      case categorySelectionTabsV2:
        return CupertinoPageRoute(builder: (_) => const CategorySelectionTabsV2());
      case homeQuizFeedV2:
        return CupertinoPageRoute(builder: (_) => const HomeQuizFeedV2());
      case referralEarnV2:
        return CupertinoPageRoute(builder: (_) => const ReferralEarnV2());
      default:
        return CupertinoPageRoute(builder: (_) => const Scaffold());
    }
  }
}

