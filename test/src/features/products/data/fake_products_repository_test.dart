import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FakeProductsRepository makeProductsRepository() => FakeProductsRepository(addDelay: false);
  group(
    "FakeProductsRepository",
    () {
      test('getProductsList returns global list', () {
        final productsRepository = makeProductsRepository();
        expect(
          productsRepository.getProductsList(),
          kTestProducts,
        );
      });

      test(
        'getProduct(1) returns first item',
        () {
          final productRepository = makeProductsRepository();
          expect(
            productRepository.getProduct("1"),
            kTestProducts[0],
          );
        },
      );

      test(
        'getProduct(100) returns first item',
        () {
          final productRepository = makeProductsRepository();
          expect(
            productRepository.getProduct("100"),
            null,
          );
        },
      );

      test(
        'fetchProductsList returns global list',
        () async {
          final productRepository = makeProductsRepository();
          expect(
            await productRepository.fetchProductsList(),
            kTestProducts,
          );
        },
      );

      test(
        "watchProductsList emits global list",
        () {
          final productRepository = makeProductsRepository();
          expect(
            productRepository.watchProductsList(),
            emits(kTestProducts),
          );
        },
      );

      test('watchProduct(1) emits first item', () {
        final productRepository = makeProductsRepository();
        expect(
          productRepository.watchProduct('1'),
          emits(kTestProducts[0]),
        );
      });

      test('watchProduct(100) emits null', () {
        final productRepository = makeProductsRepository();
        expect(
          productRepository.watchProduct('100'),
          emits(null),
        );
      });
    },
  );
}
