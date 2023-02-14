import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'option_model.dart';

class CarouselOptionWidget extends StatelessWidget {
  final OptionModel? option;
  final GestureTapCallback? onTap;

  const CarouselOptionWidget({Key? key, this.onTap, this.option})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 60,
      margin: const EdgeInsetsDirectional.only(start: 2, end: 2),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          width: option!.checked! ? 3 : 1,
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.secondary.withOpacity(0.08),
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (option!.icon != null)
                    ? Icon(option!.icon)
                    : Text(option!.title ?? '',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.subtitle2!.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 10)))
                        .visible(option!.title != null),
                Text(option!.subtitle ?? '',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .merge(const TextStyle(fontSize: 10)))
                    .visible(option!.subtitle != null),
              ]),
        ),
      ),
    );
  }
}
