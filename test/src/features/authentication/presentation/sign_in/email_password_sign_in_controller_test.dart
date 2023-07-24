@Timeout(Duration(milliseconds: 500))

import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_controller.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  const testEmail = 'test@test.com';
  const testPassword = '12345678';
  group("submit", () {
    test(
      ''' 
      Given formType is signIn
      When signInWithEmailAndPassword succeeds   
      then return true
      and state is AsyncData      
    ''',
      () async {
        final authRepository = MockAuthRepository();
        when(() => authRepository.signInWithEmailAndPassword(testEmail, testPassword)).thenAnswer(
          (_) => (Future.value()),
        );
        final controller = EmailPasswordSignInController(
          formType: EmailPasswordSignInFormType.signIn,
          authRepository: authRepository,
        );
        expectLater(
          controller.stream,
          emitsInOrder(
            [
              EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.signIn,
                value: const AsyncLoading<void>(),
              ),
              EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.signIn,
                value: const AsyncData<void>(null),
              )
            ],
          ),
        );
        final result = await controller.submit(testEmail, testPassword);
        expect(result, true);
      },
    );

    test(
      ''' 
      Given formType is signIn
      When signInWithEmailAndPassword fails   
      then return false
      and state is AsyncError
    ''',
      () async {
        final authRepository = MockAuthRepository();
        final expection = Exception('Connection Failed');
        when(() => authRepository.signInWithEmailAndPassword(testEmail, testPassword))
            .thenThrow(expection);
        final controller = EmailPasswordSignInController(
          formType: EmailPasswordSignInFormType.signIn,
          authRepository: authRepository,
        );
        expectLater(
          controller.stream,
          emitsInOrder(
            [
              EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.signIn,
                value: const AsyncLoading<void>(),
              ),
              predicate<EmailPasswordSignInState>((state) {
                expect(state.formType, EmailPasswordSignInFormType.signIn);
                expect(state.value.hasError, true);
                return true;
              }),
            ],
          ),
        );
        final result = await controller.submit(testEmail, testPassword);
        expect(result, false);
      },
    );

    test(
      ''' 
      Given formType is signIn
      When createInWithEmailAndPassword succeeds   
      then return true
      and state is AsyncData      
    ''',
      () async {
        final authRepository = MockAuthRepository();
        when(() => authRepository.createUserWithEmailAndPassword(testEmail, testPassword))
            .thenAnswer(
          (_) => (Future.value()),
        );
        final controller = EmailPasswordSignInController(
          formType: EmailPasswordSignInFormType.register,
          authRepository: authRepository,
        );
        expectLater(
          controller.stream,
          emitsInOrder(
            [
              EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.register,
                value: const AsyncLoading<void>(),
              ),
              EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.register,
                value: const AsyncData<void>(null),
              )
            ],
          ),
        );
        final result = await controller.submit(testEmail, testPassword);
        expect(result, true);
      },
    );

    test(
      ''' 
      Given formType is signIn
      When creteUserWithEmailAndPassword fails   
      then return false
      and state is AsyncError
    ''',
      () async {
        final authRepository = MockAuthRepository();
        final expection = Exception('Connection Failed');
        when(() => authRepository.createUserWithEmailAndPassword(testEmail, testPassword))
            .thenThrow(expection);
        final controller = EmailPasswordSignInController(
          formType: EmailPasswordSignInFormType.register,
          authRepository: authRepository,
        );
        expectLater(
          controller.stream,
          emitsInOrder(
            [
              EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.register,
                value: const AsyncLoading<void>(),
              ),
              predicate<EmailPasswordSignInState>((state) {
                expect(state.formType, EmailPasswordSignInFormType.register);
                expect(state.value.hasError, true);
                return true;
              }),
            ],
          ),
        );
        final result = await controller.submit(testEmail, testPassword);
        expect(result, false);
      },
    );
  });
  group("updateFormType", () {
    test(''' 
      Given formType is signIn
      When called with register
      and state.formType is register
    ''', () async {
      final authRepository = MockAuthRepository();

      final controller = EmailPasswordSignInController(
        formType: EmailPasswordSignInFormType.register,
        authRepository: authRepository,
      );
      controller.updateFormType(EmailPasswordSignInFormType.register);
      expect(
        controller.debugState,
        EmailPasswordSignInState(
          formType: EmailPasswordSignInFormType.register,
          value: const AsyncData<void>(null),
        ),
      );
    });

    test(''' 
      Given formType is register
      When called with sign in
      and state.formType is sign in
    ''', () async {
      final authRepository = MockAuthRepository();

      final controller = EmailPasswordSignInController(
        formType: EmailPasswordSignInFormType.signIn,
        authRepository: authRepository,
      );
      controller.updateFormType(EmailPasswordSignInFormType.signIn);
      expect(
        controller.debugState,
        EmailPasswordSignInState(
          formType: EmailPasswordSignInFormType.signIn,
          value: const AsyncData<void>(null),
        ),
      );
    });
  });
}
