@Timeout(Duration(milliseconds: 500))

import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late AccountScreenController controller;
  setUp(() {
    authRepository = MockAuthRepository();
    controller = AccountScreenController(authRepository: authRepository);
  });

  group("AccountScreenController", () {
    test("initial state is AsyncValue.data", () {
      verifyNever(authRepository.signOut);
      expect(
        controller.debugState,
        const AsyncValue<void>.data(null),
      );
    });

    test(
      'signOut success',
      () async {
        //setup

        when(authRepository.signOut).thenAnswer((_) => Future.value());
        final controller = AccountScreenController(
          authRepository: authRepository,
        );
        //run
        expectLater(
            controller.stream,
            emitsInOrder([
              const AsyncLoading<void>(),
              const AsyncData<void>(null),
            ]));
        await controller.signOut();
        verify(authRepository.signOut).called(1);
      },
    );

    test(
      'signOut failure',
      () async {
        //setup

        final exception = Exception("Connection failed");

        when(authRepository.signOut).thenThrow(exception);

        //except later
        expectLater(
            controller.stream,
            emitsInOrder([
              const AsyncLoading<void>(),
              predicate<AsyncValue<void>>((value) {
                expect(value.hasError, true);
                return true;
              })
            ]));
        //run
        await controller.signOut();

        verify(authRepository.signOut).called(1);
        expect(controller.debugState.hasError, true);
      },
    );
  });
}
