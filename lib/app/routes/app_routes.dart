// Generated Integration Routes
// This file maps all 66 screens to their respective BLoCs
// Auto-generated: DO NOT EDIT MANUALLY

abstract class AppRoutes {
  // Authentication Routes
  static const String splash = '/';
  static const String emailSignIn = '/email-signin';
  static const String signup = '/signup';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String profileNameInput = '/profile-name-input';
  static const String languageSelection = '/language-selection';
  static const String avatarSelection = '/avatar-selection';
  static const String onboardingKnowledge = '/onboarding-knowledge';
  static const String onboardingGetReady = '/onboarding-ready';
  static const String phoneLogin = '/phone-login';
  static const String emailVerification = '/email-verification';
  static const String accountSettings = '/account-settings';
  static const String languageSettings = '/language-settings';

  // Profile Routes
  static const String profileDisplay = '/profile-display';
  static const String profileEdit = '/profile-edit';
  static const String profileStatistics = '/profile-statistics';
  static const String profileSetup = '/profile-setup';
  static const String profileStatisticsVariant = '/profile-statistics-v2';

  // Wallet Routes
  static const String coinStore = '/coin-store';
  static const String coinHistory = '/coin-history';
  static const String coinHistoryVariant = '/coin-history-v2';
  static const String transactionHistory = '/transaction-history';
  static const String paymentMethod = '/payment-method';
  static const String paymentSuccess = '/payment-success';

  // Quiz Routes
  static const String quizPlaying = '/quiz-playing';
  static const String quizVictory = '/quiz-victory';
  static const String quizDefeat = '/quiz-defeat';
  static const String quizReview = '/quiz-review';
  static const String quizSettings = '/quiz-settings';
  static const String categorySelection = '/category-selection';
  static const String quizBattle = '/quiz-battle';
  static const String quizBattleInProgress = '/quiz-battle-progress';
  static const String quizBattleCompletion = '/quiz-battle-complete';

  // Game Routes
  static const String guessWord = '/guess-word';
  static const String guessWordVictory = '/guess-word-victory';
  static const String wordGameResults = '/word-game-results';
  static const String ticTacToe = '/tictactoe';
  static const String ticTacToeTimer = '/tictactoe-timer';
  static const String numberPuzzle = '/number-puzzle';
  static const String numberPuzzleGrid = '/number-puzzle-grid';
  static const String memoryFlip = '/memory-flip';
  static const String scratchCard = '/scratch-card';
  static const String scratchCardReward = '/scratch-card-reward';
  static const String miniGames = '/mini-games';

  // Battle Routes
  static const String quizBattleScreen = '/quiz-battle-screen';
  static const String battleCountdown = '/battle-countdown';
  static const String battleCountdownV2 = '/battle-countdown-v2';
  static const String battleModeSelection = '/battle-mode-selection';
  static const String battleRoomJoin = '/battle-room-join';
  static const String battleRoomNumberPad = '/battle-room-numberpad';
  static const String battleRoomCreation = '/battle-room-creation';
  static const String battleMatching = '/battle-matching';
  static const String battleChat = '/battle-chat';

  // Leaderboard Routes
  static const String leaderboard = '/leaderboard';
  static const String rewardsLeaderboard = '/rewards-leaderboard';
  static const String badgesCollection = '/badges-collection';
  static const String dailyRewards = '/daily-rewards';

  // Other Routes
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String contestEntry = '/contest-entry';
  static const String challenge = '/challenge';
  static const String friendsList = '/friends-list';
  static const String friendChat = '/friend-chat';
  static const String quickChat = '/quick-chat';
  static const String referral = '/referral';
  static const String homeQuizFeed = '/home-quiz-feed';
}
