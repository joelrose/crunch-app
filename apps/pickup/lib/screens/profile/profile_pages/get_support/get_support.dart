import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickup/global.dart';
import 'package:pickup/screens/profile/profile.dart';
import 'package:pickup/screens/profile/profile_pages/get_support/get_support_pages/contact_support.dart';
import 'package:pickup/screens/profile/profile_pages/placeholder.dart';
import 'package:pickup/shared/page_wrapper.dart';

class GetSupport extends StatelessWidget {
  const GetSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              'Get support',
              style: Theme.of(context).textTheme.headline1!.merge(
                    const TextStyle(
                      color: AlpacaColor.blackColor,
                    ),
                  ),
            ),
          ),
          const GetSupportBody()
        ],
      ),
    );
  }
}

class GetSupportBody extends StatelessWidget {
  const GetSupportBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [FAQContainer(), Divider(), GetEmailSupport(), Divider()],
    );
  }
}

class FAQContainer extends StatelessWidget {
  const FAQContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProfileTile(
      title: 'Go to FAQ',
      icon: Icons.book,
      link: PlaceholderSide(),
    );
  }
}

class GetEmailSupport extends StatelessWidget {
  const GetEmailSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProfileTile(
      title: 'Contact Support',
      icon: Icons.question_answer_outlined,
      link: EmailSender(),
    );
  }
}
