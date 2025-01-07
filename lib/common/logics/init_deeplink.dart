import 'package:my_deep_link/my_deep_link_method.dart';
import 'package:my_utils/my_utils.dart';

Future<void> initDeepLink() async {
  await MyDeepLink.getDeepLink(
    onSuccess: (data) async {
      await commonDeepLink(data);
    }
  );
}

Future<void> commonDeepLink(String data) async {
  MyLogger.w('DeepLink Success: $data');
}