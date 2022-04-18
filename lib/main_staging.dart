import 'package:pickup/bootstrap.dart';
import 'package:pickup/main_app.dart';
import 'package:pickup/shared/enum/enviroment.dart';

void main() {
  bootstrap(() => const App(), Enviroment.staging);
}
