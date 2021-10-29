import 'package:alpaca/global.dart';
import 'package:alpaca/screens/checkout/widgets/divider_widget.dart';
import 'package:flutter/material.dart';

class CheckoutOrderNavbarWidget extends StatelessWidget {
  CheckoutOrderNavbarWidget({
    Key? key,
    this.storeName,
    required this.pageOverviewName,
    this.disableEditButton = false,
  }) : super(key: key);

  final String? storeName;
  final String pageOverviewName;
  final bool disableEditButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 15),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          pageOverviewName,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        if (storeName != null) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              storeName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: AlpacaColor.darkGreyColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: AlpacaColor.blackColor,
                      ),
                    ),
                  ),
                  if (!disableEditButton)
                    Positioned(
                      right: 0,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Edit',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
        const DividerWidget(),
      ],
    );
  }
}
