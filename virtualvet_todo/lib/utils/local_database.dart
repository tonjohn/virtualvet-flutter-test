import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalDataBase {
  // initialization
  static Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive..init(appDocumentDir.path);
  }
}
