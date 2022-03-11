import 'package:hermes_api/hermes_api.dart';
import 'package:pickup/services/hermes_service.dart';
import 'package:pickup/services/service_locator.dart';
import 'package:pickup/shared/base_model.dart';
import 'package:pickup/shared/enum/viewstate.dart';

class StoreScreenModel extends BaseModel {
  final HermesService _hermesService = locator<HermesService>();
  late GetMenuResponseDto _store;

  GetMenuResponseDto get store => _store;

  Future fetchRestaurant(String storeId) async {
    setState(ViewState.busy);

    final response = await _hermesService.client.apiMenuMenuIdGet(
      menuId: storeId,
    );

    if (response.isSuccessful) {
      _store = response.body!;
    }

    setState(ViewState.idle);
  }
}
