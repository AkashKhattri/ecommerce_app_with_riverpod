import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));
  final FakeAuthRepository authRepository;

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard<void>(() => authRepository.signOut());
  }
}

final accountScreenControllerProvider =
    StateNotifierProvider.autoDispose<AccountScreenController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(
    authRepository: authRepository,
  );
});
