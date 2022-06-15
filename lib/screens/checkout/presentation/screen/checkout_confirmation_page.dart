import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/checkout/checkout.dart';
import 'package:pickup/screens/checkout_navbar/checkout_navbar.dart';
import 'package:pickup/screens/checkout_row_header/checkout_row_header.dart';
import 'package:pickup/screens/home/home.dart';

class CheckoutConfirmationPage extends StatelessWidget {
  const CheckoutConfirmationPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const CheckoutConfirmationPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: EdgeInsets.zero,
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
      child: Column(
        children: [
          CheckoutNavbar(
            pageOverviewName: context.l10n.orderStatus,
            showBackButton: false,
          ),
          const _Content(),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 230,
                    child: Text(
                      context.l10n.orderInPreperation,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
              ),
              const LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                color: AlpacaColor.primary100,
              ),
              Container(
                color: AlpacaColor.primary100.withOpacity(0.03),
                height: 151,
                child: const Center(
                  child: CheckoutConfirmationTime(),
                ),
              ),
              CheckoutRowHeader(
                header: context.l10n.orderDetails,
                onPressed: () {},
                buttonText: '',
                disableButton: true,
              ),
              const ItemsOverview(),
              const AddressDirection(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: ActionButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      HomePage.route,
                      (Route<dynamic> route) => false,
                    );
                  },
                  buttonText: context.l10n.next,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
