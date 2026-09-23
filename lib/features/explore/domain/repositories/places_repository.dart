import '../models/place.dart';

abstract interface class PlacesRepository {
  Future<List<Place>> getPlaces();
  Future<Place?> getPlaceById(String id);
  Future<List<Place>> getPlacesByCategory(String category);
  Future<List<Place>> searchPlaces(String query);
  Future<List<String>> getCategories();
}
