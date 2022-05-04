import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/checkout/widgets/divider_widget.dart';

class CheckoutNavbar extends StatelessWidget {
  const CheckoutNavbar({
    Key? key,
    this.storeName,
    required this.pageOverviewName,
    this.showBackButton = true,
  }) : super(key: key);

  final String? storeName;
  final String pageOverviewName;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
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
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        if (storeName != null) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              storeName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: AlpacaColor.darkGreyColor,
                                  ),
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                  if (showBackButton)
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
