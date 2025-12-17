import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../api_service.dart';

sealed class BattleRoomState {
  const BattleRoomState();
}

class BattleRoomInitial extends BattleRoomState {
  const BattleRoomInitial();
}

class BattleRoomLoading extends BattleRoomState {
  const BattleRoomLoading();
}

class BattleRoomReady extends BattleRoomState {
  final Map<String, dynamic> battleData;
  const BattleRoomReady(this.battleData);
}

class BattleRoomCubit extends Cubit<BattleRoomState> {
  BattleRoomCubit() : super(const BattleRoomInitial());
  
  Future<void> joinBattle(String battleId) async {
    emit(const BattleRoomLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(const BattleRoomReady({'battleId': battleId}));
  }
}

sealed class LeaderboardState {
  const LeaderboardState();
}

class LeaderboardInitial extends LeaderboardState {
  const LeaderboardInitial();
}

class LeaderboardLoading extends LeaderboardState {
  const LeaderboardLoading();
}

class LeaderboardLoaded extends LeaderboardState {
  final List<Map<String, dynamic>> rankings;
  const LeaderboardLoaded(this.rankings);
}

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit() : super(const LeaderboardInitial());
  
  Future<void> loadLeaderboard() async {
    try {
      emit(const LeaderboardLoading());
      final rankings = await ApiService.getLeaderboard();
      emit(LeaderboardLoaded(rankings));
    } catch (e) {
      emit(const LeaderboardInitial());
    }
  }
}

sealed class ProfileManagementState {
  const ProfileManagementState();
}

class ProfileManagementInitial extends ProfileManagementState {
  const ProfileManagementInitial();
}

class ProfileLoading extends ProfileManagementState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileManagementState {
  final Map<String, dynamic> profile;
  const ProfileLoaded(this.profile);
}

class ProfileManagementCubit extends Cubit<ProfileManagementState> {
  ProfileManagementCubit() : super(const ProfileManagementInitial());
  
  Future<void> loadProfile(String uid) async {
    try {
      emit(const ProfileLoading());
      final profile = await ApiService.getUserProfile(uid);
      if (profile != null) {
        emit(ProfileLoaded(profile));
      }
    } catch (e) {
      emit(const ProfileManagementInitial());
    }
  }
  
  Future<void> updateProfile(String uid, Map<String, dynamic> updates) async {
    try {
      emit(const ProfileLoading());
      // Update in Firebase
      emit(ProfileLoaded(updates));
    } catch (e) {
      emit(const ProfileManagementInitial());
    }
  }
}

sealed class SocialState {
  const SocialState();
}

class SocialInitial extends SocialState {
  const SocialInitial();
}

class SocialLoading extends SocialState {
  const SocialLoading();
}

class SocialLoaded extends SocialState {
  final List<Map<String, dynamic>> friends;
  const SocialLoaded(this.friends);
}

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(const SocialInitial());
  
  Future<void> loadFriends(String uid) async {
    emit(const SocialLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(const SocialLoaded([]));
  }
}

sealed class NotificationState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

class NotificationLoaded extends NotificationState {
  final List<Map<String, dynamic>> notifications;
  const NotificationLoaded(this.notifications);
}

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationInitial());
  
  Future<void> loadNotifications(String uid) async {
    emit(const NotificationLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(const NotificationLoaded([]));
  }
}

sealed class SettingsState {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsInitial());
}

sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());
}

sealed class NavigationState {
  const NavigationState();
}

class NavigationInitial extends NavigationState {
  const NavigationInitial();
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationInitial());
}

sealed class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchInitial());
}
