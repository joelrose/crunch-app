import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:pickup/screens/store/widgets/store_image_navbar.dart';

import 'widgets/store_menue_list.dart';

class StoreProductOverview extends StatefulWidget {
  StoreProductOverview({Key? key, required this.data}) : super(key: key);
  ProductDetailsData data;

  @override
  _StoreProductOverviewState createState() => _StoreProductOverviewState();
}

class _StoreProductOverviewState extends State<StoreProductOverview> {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.white100Color,
      child: SingleChildScrollView(
        child: Column(
          children: [
            StoreImageNavbar(
              image: widget.data.restaurantImage,
              showButtons: false,
            ),
            ProductBasicDetails(
              title: widget.data.item.title.english,
            ),
            ProductRadioCheckbox()
          ],
        ),
      ),
    );
  }
}

class ProductBasicDetails extends StatelessWidget {
  ProductBasicDetails({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline2!
                .merge(const TextStyle(fontSize: 22)),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Example description! Should be changed when basic details are available',
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
    );
  }
}

class ProductRadioCheckbox extends StatefulWidget {
  ProductRadioCheckbox({Key? key}) : super(key: key);
  List<Map<String, Object>> itemData = [
    {
      'Topic': 'Size',
      'Choices': [
        ['Medium', ''],
        ['Large', '+1.10€'],
      ]
    },
    {
      'Topic': 'Hot sauce',
      'Choices': [
        ['No', ''],
        ['Yes', ''],
      ]
    }
  ];

  @override
  _ProductRadioCheckboxState createState() => _ProductRadioCheckboxState();
}

class _ProductRadioCheckboxState extends State<ProductRadioCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.itemData.length,
        itemBuilder: (context, i) {
          final Map<dynamic, dynamic> item = widget.itemData[i];
          final String itemTopic = item['Topic'] as String;
          final List<dynamic> itemChoices = item['Choices'] as List;
          String initialChoice = itemChoices[0].toString();
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemTopic,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: AlpacaColor.greyColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView.separated(
                        itemCount: itemChoices.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 0,
                          );
                        },
                        itemBuilder: (context, index) => GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            final value = itemChoices[index];
                            setState(() {
                              initialChoice = value.toString();
                            });
                          },
                          child: Row(
                            children: [
                              Radio(
                                value: itemChoices[index].toString(),
                                groupValue: initialChoice,
                                onChanged: (value) {
                                  setState(() {
                                    initialChoice = value.toString();
                                  });
                                },
                                activeColor: AlpacaColor.primary100,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 17),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        itemChoices[index][0].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .merge(
                                              const TextStyle(
                                                color:
                                                    AlpacaColor.darkNavyColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                              ),
                                            ),
                                      ),
                                      Text(
                                        itemChoices[index][1].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .merge(
                                              const TextStyle(
                                                color: AlpacaColor.primary100,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
