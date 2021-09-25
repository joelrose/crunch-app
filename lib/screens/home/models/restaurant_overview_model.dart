import 'package:alpaca/sanity/model.dart';
import 'package:alpaca/sanity/sanity.dart';
import 'package:alpaca/services/service_locator.dart';
import 'package:alpaca/shared/base_model.dart';
import 'package:alpaca/shared/viewstate.dart';

class RestaurantScreenModel extends BaseModel {
  final SanityCms cmsClient = locator<SanityCms>();
  late List<RestaurantModel> _restaurants;

  List<RestaurantModel> get restaurants => _restaurants;

  Future fetchRestaurants() async {
    setState(ViewState.busy);

    _restaurants = await cmsClient.getRestaurants();

    setState(ViewState.idle);
  }
}
