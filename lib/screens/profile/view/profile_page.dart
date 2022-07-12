import 'package:alpaca/alpaca.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onesignal_repository/onesignal_repository.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/app/cubit/language/language_cubit.dart';
import 'package:pickup/screens/app/cubit/user/user_cubit.dart';
import 'package:pickup/screens/onboarding_welcome/onboarding_welcome.dart';
import 'package:pickup/screens/profile/cubit/profile_cubit.dart';
import 'package:pickup/screens/profile/widgets/profile_tile.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfilePage extends StatelessWidget {
  static const route = '/profile';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        authenticationRepository: context.read<AuthenticationRepository>(),
        oneSignalRepository: context.read<OneSignalRepository>(),
      ),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: const EdgeInsets.symmetric(vertical: 30),
      backgroundColor: AlpacaColor.white100Color,
      statusBarStyle: SystemUiOverlayStyle.dark,
      child: Column(
        children: const [
          _Header(),
          SizedBox(
            height: 20,
          ),
          _SignOut(),
        ],
      ),
    );
  }
}

class _SignOut extends StatelessWidget {
  const _SignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.loggedOut) {
          Navigator.of(context).pushAndRemoveUntil(
            OnboardingWelcomePage.route(),
            (route) => false,
          );
        }
      },
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _Tiles(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18.0),
              child: ActionButton(
                key: const Key('logout_button'),
                buttonText: context.l10n.logout,
                isPrimaryButton: false,
                textColor: AlpacaColor.redColor,
                onPressed: () => context.read<ProfileCubit>().logoutUser(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state.status.isSuccessful) {
          return Stack(
            alignment: Alignment.centerRight,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AlpacaColor.primary20,
                      child: Text(
                        state.user!.firstName!.substring(0, 1) +
                            state.user!.lastName!.substring(0, 1),
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: const Color(0xff33047B),
                            ),
                      ),
                    ),
                    Container(
                      height: 15,
                    ),
                    Text(
                      '${state.user!.firstName!} ${state.user!.lastName!}',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: AlpacaColor.darkNavyColor,
                          ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                top: 10,
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
          );
        } else {
          return Container();
        }
      },
    );
  }
}

const double _kItemExtent = 32.0;

class _Tiles extends StatelessWidget {
  const _Tiles({Key? key}) : super(key: key);

  void _showDialog(Widget child, BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final externalLink = _externalLink();

    return Column(
      children: [
        Container(
          height: 20,
        ),
        ProfileTile(
          title: context.l10n.language,
          onPressed: () {
            _showDialog(
              CupertinoPicker(
                magnification: 1.22,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: _kItemExtent,
                // This is called when selected item is changed.
                onSelectedItemChanged: (int selectedItem) {
                  // Change the language of the application.
                  context.read<LanguageCubit>().setLocale(
                        AppLocalizations.supportedLocales[selectedItem],
                      );
                },

                children: List<Widget>.generate(
                    AppLocalizations.supportedLocales.length, (int index) {
                  return Center(
                    child: Text(
                      AppLocalizations.supportedLocales[index].languageCode,
                    ),
                  );
                }),
              ),
              context,
            );
          },
          imagePath: 'assets/icons/sliders.svg',
        ),
        ProfileTile(
          title: context.l10n.termsAndConditions,
          imagePath: 'assets/icons/book.svg',
          onPressed: () => launchUrlString(
            'https://crunch-app.notion.site/Imprint-e6703f9d44be4d0f9ee0992953056d74',
          ),
          suffixWidget: externalLink,
        ),
        ProfileTile(
          title: context.l10n.dataPrivacy,
          onPressed: () => launchUrlString(
            'https://crunch-app.notion.site/Imprint-e6703f9d44be4d0f9ee0992953056d74',
          ),
          imagePath: 'assets/icons/shield.svg',
          suffixWidget: externalLink,
        ),
        ProfileTile(
          title: context.l10n.contactUs,
          onPressed: () => launchUrlString('mailto:joel@getcrunch.tech'),
          imagePath: 'assets/icons/message-square.svg',
          suffixWidget: externalLink,
        ),
        ProfileTile(
          title: context.l10n.visitOurWebsite,
          imagePath: 'assets/icons/layout.svg',
          onPressed: () => launchUrlString('https://getcrunch.tech'),
          suffixWidget: externalLink,
        ),
        const AlpacaDivider(),
      ],
    );
  }

  Widget _externalLink() {
    return SvgPicture.asset(
      'assets/icons/external-link.svg',
      color: AlpacaColor.lightGreyColor100,
      height: 20,
      fit: BoxFit.fitHeight,
    );
  }
}
