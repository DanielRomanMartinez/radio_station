import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:radio_station/application/bloc/splash_screen/splash_screen_bloc.dart';
import 'package:radio_station/ui/screens/home_screen/home_screen.dart';
import 'package:radio_station/ui/screens/splash_screen/splash_screen.dart';

import 'onboarding_screen_test.mocks.dart';

@GenerateMocks([SplashScreenBloc])
void main() {
  late SplashScreenBloc splashScreenBloc;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    splashScreenBloc = MockSplashScreenBloc();

    final getIt = GetIt.instance;
    getIt.registerSingleton<SplashScreenBloc>(splashScreenBloc);
  });

  group('Splash Screen Test', () {
    testWidgets('Pump and test widget - Initial', (WidgetTester tester) async {
      const SplashScreenState state = SplashScreenInitial();

      when(splashScreenBloc.stream).thenAnswer((_) {
        when(splashScreenBloc.state).thenAnswer((_) => state);
        return Stream.value(state);
      });

      await tester.pumpWidget(
        const MaterialApp(
          home: SplashScreen(),
        ),
      );

      expect(
          find.image(
              const AssetImage('assets/splash_screen/radio_station_logo.png')),
          findsOneWidget);

      Finder textFinder = find.text('TheHiddenPanda');
      expect(textFinder, findsOneWidget);

      Text text = tester.firstWidget(textFinder);
      expect(text.style?.fontFamily, 'KuaiLe');

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('../../goldens/splash_screen_1.png'),
      );
    });

    testWidgets('Pump and test widget - Goes to Home',
        (WidgetTester tester) async {
      const SplashScreenState state =
          SplashScreenGotNextPage(nextPage: HomeScreen.routeName);

      when(splashScreenBloc.stream).thenAnswer((_) {
        when(splashScreenBloc.state).thenAnswer((_) => state);
        return Stream.value(state);
      });

      await tester.pumpWidget(
        const MaterialApp(
          home: SplashScreen(),
        ),
      );

      expect(
          find.image(
              const AssetImage('assets/splash_screen/radio_station_logo.png')),
          findsOneWidget);

      Finder textFinder = find.text('TheHiddenPanda');
      expect(textFinder, findsOneWidget);

      Text text = tester.firstWidget(textFinder);
      expect(text.style?.fontFamily, 'KuaiLe');

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('../../goldens/splash_screen_2.png'),
      );

      await tester.pumpAndSettle();

      textFinder = find.text('Home');
      expect(textFinder, findsOneWidget);

      textFinder = find.text('RadioStation con timer');
      expect(textFinder, findsOneWidget);

      textFinder = find.text('RadioStation sin timer');
      expect(textFinder, findsOneWidget);

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('../../goldens/splash_screen_2.png'),
      );
    });
  });
}
