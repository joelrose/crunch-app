import 'package:alpaca/services/service_locator.dart';
import 'package:alpaca/shared/base_model.dart';
import 'package:alpaca/shared/viewstate.dart';
import 'package:sanity/sanity.dart';

class RestaurantScreenModel extends BaseModel {
  final SanityCms cmsClient = locator<SanityCms>();
  late List<RestaurantOverviewModel> _restaurants;

  List<RestaurantOverviewModel> get restaurants => _restaurants;

  Future fetchRestaurants() async {
    setState(ViewState.busy);

    _restaurants = await cmsClient.getRestaurants();

    setState(ViewState.idle);
  }
}
