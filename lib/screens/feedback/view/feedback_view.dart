import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/l10n/l10n.dart';
import 'package:pickup/screens/feedback/cubit/cubit.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeedbackSliderCubit(0),
        )
      ],
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 10,
              right: 5,
            ),
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const CircleBorder(),
                primary: AlpacaColor.lightGreyColor90,
              ),
              child: const Icon(
                Icons.close,
                color: AlpacaColor.lightGreyColor100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                Text(
                  context.l10n.feedbackTitle,
                  style: Theme.of(context).textTheme.headline1!.merge(
                        const TextStyle(
                          color: AlpacaColor.blackColor,
                        ),
                      ),
                  textAlign: TextAlign.center,
                ),
                Container(height: 10),
                Text(
                  context.l10n.feedbackSubtitle,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                Container(height: 25),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.l10n.feedbackQuestion,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 16,
                        ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const _Slider(),
                Container(height: 20),
                const _TextField(),
                Container(height: 25),
                ActionButton(
                  onPressed: () => Navigator.of(context).pop(),
                  buttonText: context.l10n.submit,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AlpacaColor.lightGreyColor80,
        ),
      ),
      child: TextField(
        maxLines: 3,
        cursorColor: Colors.black,
        style: Theme.of(context).textTheme.headline5,
        decoration: InputDecoration(
          hintText: context.l10n.feedbackTextfieldHint,
          fillColor: AlpacaColor.lightGreyColor90,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  const _Slider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sliderValue = context.select(
      (FeedbackSliderCubit cubit) => cubit.state.value,
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 10),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 8,
              tickMarkShape: SliderTickMarkShape.noTickMark,
              valueIndicatorShape: SliderComponentShape.noOverlay,
              overlayShape: SliderComponentShape.noOverlay,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14.0),
              rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
            ),
            child: Slider(
              onChangeStart: (_) => HapticFeedback.mediumImpact(),
              onChangeEnd: (_) => HapticFeedback.mediumImpact(),
              value: sliderValue,
              max: 10,
              divisions: 10,
              activeColor: AlpacaColor.primary100,
              label: sliderValue.round().toString(),
              onChanged: (double value) {
                context.read<FeedbackSliderCubit>().updateValue(value);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.feedbackSliderUnlikely,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                context.l10n.feedbackSliderLikely,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        )
      ],
    );
  }
}