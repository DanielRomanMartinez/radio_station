import 'package:injectable/injectable.dart';
import 'package:radio_station/ui/screens/home_screen/home_screen.dart';

@injectable
class SplashService {
  const SplashService();

  Future<String> getNextPage() async {
    await Future<void>.delayed(const Duration(milliseconds: 2000));
    return HomeScreen.routeName;
  }
}
