import 'package:alpaca/sanity/model.dart';
import 'package:alpaca/sanity/sanity.dart';
import 'package:alpaca/services/service_locator.dart';
import 'package:alpaca/shared/base_model.dart';
import 'package:alpaca/shared/viewstate.dart';

class StoreScreenModel extends BaseModel {
  final SanityCms cmsClient = locator<SanityCms>();
  late RestaurantStoreModel _restaurant;

  RestaurantStoreModel get restaurant => _restaurant;

  Future fetchRestaurant(String storeId) async {
    setState(ViewState.busy);

    _restaurant = await cmsClient.getRestaurant(storeId);

    setState(ViewState.idle);
  }
}
