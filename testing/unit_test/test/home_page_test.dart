// import 'package:flutter_getx/app/controller/home_controller/home_page_controller.dart';
// import 'package:flutter_getx/app/ui/home/home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unit_test/app/controller/home_page_controller.dart';
import 'package:unit_test/app/view/home_page.dart';

class MockHomePageController extends GetxController with Mock implements HomePageController {}

void main() {
  // late HomePageController mockController;

  setUp(() {
    Get.testMode = true;
    // mockController = MockHomePageController();

    // กำหนดเส้นทางปลอม
    // when(() => mockController.title).thenReturn('Flutter Demo Home Page');
    // when(() => mockController.text).thenReturn('You have pushed the button this many times:');
    // when(() => mockController.counter).thenReturn(0.obs);
    // when(() => mockController.counterAdd()).thenAnswer((_) => mockController.counter.value++);
    // when(() => mockController.counterRemove()).thenAnswer((_) => mockController.counter.value--);

    // Get.put(mockController);
  });
  group('Test Widget HomePageController ', () {
    testWidgets('Displays initial values correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: HomePage(),
        ),
      );

      expect(find.text('Flutter Demo Home Page'), findsOneWidget);
      expect(find.text('You have pushed the button this many times:'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('Increments counter when + button is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: HomePage(),
        ),
      );

      final homePageController = Get.find<HomePageController>();
      homePageController.counter.value = 0;

      await tester.tap(find.text('+'));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('Decrements counter when - button is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: HomePage(),
        ),
      );

      final homePageController = Get.find<HomePageController>();
      homePageController.counter.value = 0;

      await tester.tap(find.text('-'));
      await tester.pump();

      expect(find.text('-1'), findsOneWidget);
    });
  });
}
