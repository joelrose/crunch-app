import 'dart:math';
import 'dart:ui';

import 'package:alpaca/global.dart';
import 'package:alpaca/screens/store/store_screen_model.dart';
import 'package:alpaca/shared/base_screen.dart';
import 'package:alpaca/shared/page_wrapper.dart';
import 'package:alpaca/shared/viewstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alpaca/shared/buttons.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key, required this.storeId}) : super(key: key);

  final String storeId;

  @override
  Widget build(BuildContext context) {
    return BaseScreen<StoreScreenModel>(
      onModelReady: (model) {
        model.fetchRestaurant(storeId);
      },
      builder: (context, model, child) => model.state == ViewState.busy
          ? Container(color: AlpacaColor.white100Color)
          : PageWrapper(
              padding: EdgeInsets.zero,
              backgroundColor: AlpacaColor.white100Color,
              statusBarStyle: SystemUiOverlayStyle.dark,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(
                      model.restaurant.image,
                    ).image,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Positioned(
                  top: 0,
                  child: Row(
                    children: [
                      Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: IconButton(
                              onPressed: () {},
                              color: AlpacaColor.white100Color,
                              icon: const Icon(Icons.star_border_outlined),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: IconButton(
                              onPressed: () {},
                              color: AlpacaColor.white100Color,
                              icon: const Icon(Icons.info_outline),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
