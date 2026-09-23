import '../models/travel_plan.dart';

abstract interface class TravelPlansRepository {
  Future<List<TravelPlan>> getPlans();
  Future<TravelPlan?> getPlanById(String id);
}
