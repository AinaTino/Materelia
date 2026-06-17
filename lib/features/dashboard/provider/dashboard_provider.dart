import 'package:materelia/features/dashboard/service/dashboard_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_provider.g.dart';

@riverpod
DashboardService dashboardService(Ref ref) => DashboardService();

@riverpod
class DashboardController extends _$DashboardController {
  @override
  Future<DashboardStats> build() async {
    return ref.read(dashboardServiceProvider).getStats();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(dashboardServiceProvider).getStats(),
    );
  }
}
