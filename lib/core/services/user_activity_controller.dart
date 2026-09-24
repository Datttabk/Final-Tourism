import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Central controller for managing user bookmarks, saved travel plans,
/// and recently viewed destinations with SharedPreferences persistence.
class UserActivityController extends ChangeNotifier {
  static const String _bookmarkedPlacesKey = 'user_bookmarked_places';
  static const String _savedPlansKey = 'user_saved_plans';
  static const String _recentlyViewedPlacesKey = 'user_recently_viewed_places';

  static final UserActivityController _instance =
      UserActivityController._internal();
  factory UserActivityController() => _instance;
  static UserActivityController get instance => _instance;

  UserActivityController._internal();

  final Set<String> _bookmarkedPlaceIds = {};
  final Set<String> _savedPlanIds = {};
  final List<String> _recentlyViewedPlaceIds = [];

  List<String> get bookmarkedPlaceIds => List.unmodifiable(_bookmarkedPlaceIds);
  List<String> get savedPlanIds => List.unmodifiable(_savedPlanIds);
  List<String> get recentlyViewedPlaceIds =>
      List.unmodifiable(_recentlyViewedPlaceIds);

  bool isPlaceBookmarked(String id) => _bookmarkedPlaceIds.contains(id);
  bool isPlanSaved(String id) => _savedPlanIds.contains(id);

  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarks = prefs.getStringList(_bookmarkedPlacesKey);
      if (bookmarks != null) {
        _bookmarkedPlaceIds.clear();
        _bookmarkedPlaceIds.addAll(bookmarks);
      }

      final savedPlans = prefs.getStringList(_savedPlansKey);
      if (savedPlans != null) {
        _savedPlanIds.clear();
        _savedPlanIds.addAll(savedPlans);
      }

      final recentlyViewed = prefs.getStringList(_recentlyViewedPlacesKey);
      if (recentlyViewed != null) {
        _recentlyViewedPlaceIds.clear();
        _recentlyViewedPlaceIds.addAll(recentlyViewed);
      }
    } catch (e) {
      debugPrint('UserActivityController initialize error: $e');
    }
    notifyListeners();
  }

  Future<void> togglePlaceBookmark(String id) async {
    if (_bookmarkedPlaceIds.contains(id)) {
      _bookmarkedPlaceIds.remove(id);
    } else {
      _bookmarkedPlaceIds.add(id);
    }
    notifyListeners();
    await _persistBookmarks();
  }

  Future<void> removePlaceBookmark(String id) async {
    if (_bookmarkedPlaceIds.remove(id)) {
      notifyListeners();
      await _persistBookmarks();
    }
  }

  Future<void> togglePlanSaved(String id) async {
    if (_savedPlanIds.contains(id)) {
      _savedPlanIds.remove(id);
    } else {
      _savedPlanIds.add(id);
    }
    notifyListeners();
    await _persistSavedPlans();
  }

  Future<void> removePlanSaved(String id) async {
    if (_savedPlanIds.remove(id)) {
      notifyListeners();
      await _persistSavedPlans();
    }
  }

  Future<void> recordPlaceViewed(String id) async {
    _recentlyViewedPlaceIds.remove(id);
    _recentlyViewedPlaceIds.insert(0, id);
    if (_recentlyViewedPlaceIds.length > 25) {
      _recentlyViewedPlaceIds.removeLast();
    }
    notifyListeners();
    await _persistRecentlyViewed();
  }

  Future<void> clearRecentlyViewed() async {
    _recentlyViewedPlaceIds.clear();
    notifyListeners();
    await _persistRecentlyViewed();
  }

  Future<void> _persistBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        _bookmarkedPlacesKey,
        _bookmarkedPlaceIds.toList(),
      );
    } catch (_) {}
  }

  Future<void> _persistSavedPlans() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_savedPlansKey, _savedPlanIds.toList());
    } catch (_) {}
  }

  Future<void> _persistRecentlyViewed() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        _recentlyViewedPlacesKey,
        _recentlyViewedPlaceIds,
      );
    } catch (_) {}
  }
}
