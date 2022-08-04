import 'package:alpaca/alpaca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay_repository/loading_overlay_repository.dart';
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
        ),
        BlocProvider(
          create: (context) => FeedbackCubit(),
        ),
      ],
      child: BlocListener<FeedbackCubit, FeedbackState>(
        listener: (context, state) {
          if (state.status.isLoading) {
            context.read<LoadingOverlayRepository>().show();
          } else if (state.status.isSubmitted) {
            context.read<LoadingOverlayRepository>().hide();
            Navigator.of(context).pop();
          } else if (state.status.isFailed) {
            context.read<LoadingOverlayRepository>().hide();
            Navigator.of(context).pop();
          }
        },
        child: const _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _BackButton(),
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
              const _Slider(),
              Container(height: 20),
              const _TextField(),
              Container(height: 25),
              const _SubmitButton(),
            ],
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasChanged = context.select(
      (FeedbackSliderCubit cubit) => cubit.state.hasChanged,
    );

    return ActionButton(
      onPressed: hasChanged ? () => submit(context) : null,
      buttonText: context.l10n.submit,
    );
  }

  void submit(BuildContext context) {
    final sliderValue = context.read<FeedbackSliderCubit>();

    final feedbackCubit = context.read<FeedbackCubit>();

    feedbackCubit.submitFeedback(
      value: sliderValue.state.value,
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        onChanged: (text) => context.read<FeedbackCubit>().updateText(text),
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
