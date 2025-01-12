import 'package:my_flutter_basic/common/common.dart';
import 'package:my_utils/utils/utils.dart';

Future<void> getEnvironment() async {
  showMyLoading();
  final environment = await MyEnvironment.initialize();
  switch (environment){
    case Environment.rel:
      await getOptions(urls: MyConfig.urls.relUrls);
      break;
    case Environment.pre:
      await getOptions(urls: MyConfig.urls.preUrls);
      break;
    case Environment.grey:
      await getOptions(urls: MyConfig.urls.greyUrls);
      break;
    default:
      await getOptions(urls: MyConfig.urls.testUrls);
      break;
  }
  hideMyLoading();
}