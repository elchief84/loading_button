library loading_button;

import 'package:flutter/material.dart';
import 'package:circular_loading_button/loading_button_state.dart';
import 'loading_button_type.dart';

export 'loading_button_type.dart';

/// A wrapoer to Flutter Buttons ([ElevatedButton], [FilledButton],
/// [FilledButton.tonal], [OutlinedButton]) to introduce a loading
/// animation in any async context (ex: disable button during
/// an http call)
class LoadingButton extends StatefulWidget {
  final LoadingButtonType type;
  final bool animated;
  final LoadingButtonState state;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final WidgetStatesController? statesController;
  final Widget? child;
  final Size? expandedSize;
  final Size? loadingSize;

  /// Create a LoadingButton.
  ///
  /// The [state] and [animated] arguments must not be null.
  /// The [animated] field is currently unused, but reserved
  /// for next implementations (es: enable/disable button animation)
  ///
  /// Other parameters are the same of [ElevatedButton], [FilledButton],
  /// [FilledButton.tonal] and [OutlinedButton]
  const LoadingButton({
    super.key,
    required this.type,
    this.animated = false,
    required this.onPressed,
    this.state = LoadingButtonState.idle,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.statesController,
    this.expandedSize,
    this.loadingSize,
    required this.child,
  });

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController labelAnimationController;
  late Animation opacityAnimation;
  late Animation labelOpacityAnimation;
  late Animation widthAnimation;
  late Animation heightAnimation;
  Size currentSize = Size.zero;

  Size? _expandedSize;
  Size? _loadingSize;

  @override
  void initState() {
    super.initState();

    _expandedSize = widget.expandedSize ?? const Size(200.0, 40.0);
    _loadingSize = widget.loadingSize ?? const Size(40.0, 40.0);

    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    widthAnimation =
        Tween(begin: 1, end: _loadingSize!.width / _expandedSize!.width)
            .animate(CurvedAnimation(
                parent: animationController, curve: Curves.elasticInOut))
          ..addListener(() {
            setState(() {});
          });
    heightAnimation =
        Tween(begin: 1, end: _loadingSize!.height / _expandedSize!.height)
            .animate(CurvedAnimation(
                parent: animationController, curve: Curves.elasticInOut))
          ..addListener(() {
            setState(() {});
          });
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear))
      ..addListener(() {
        setState(() {});
      });
    labelOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(
            parent: animationController, curve: Curves.fastEaseInToSlowEaseOut))
      ..addListener(() {
        setState(() {});
      });

    if (widget.state == LoadingButtonState.loading) {
      animationController.forward(from: 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    _expandedSize = widget.expandedSize ?? const Size(200.0, 40.0);
    _loadingSize = widget.loadingSize ?? const Size(40.0, 40.0);
    _expandedSize ??= Size(Theme.of(context).buttonTheme.minWidth,
        Theme.of(context).buttonTheme.height);
    _loadingSize ??= Size(Theme.of(context).buttonTheme.height,
        Theme.of(context).buttonTheme.height);

    widthAnimation =
        Tween(begin: 1, end: _loadingSize!.width / _expandedSize!.width)
            .animate(CurvedAnimation(
                parent: animationController, curve: Curves.elasticInOut))
          ..addListener(() {
            setState(() {});
          });
    heightAnimation =
        Tween(begin: 1, end: _loadingSize!.height / _expandedSize!.height)
            .animate(CurvedAnimation(
                parent: animationController, curve: Curves.elasticInOut))
          ..addListener(() {
            setState(() {});
          });
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear))
      ..addListener(() {
        setState(() {});
      });
    labelOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(
            parent: animationController, curve: Curves.fastEaseInToSlowEaseOut))
      ..addListener(() {
        setState(() {});
      });

    if (widget.state == LoadingButtonState.loading) {
      animationController.forward();
    } else {
      animationController.reverse();
    }

    var childWrapper = Opacity(
        opacity: double.parse(labelOpacityAnimation.value.toString()),
        child: widget.child ?? Container());

    double currentWidth = widthAnimation.value * _expandedSize!.width;
    double currentHeight = heightAnimation.value * _expandedSize!.height;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
            width: currentWidth > 0 ? currentWidth : 0,
            height: currentHeight > 0 ? currentHeight : 0,
            child: _buildButton(widget.type, child: childWrapper)),
        if (widget.state == LoadingButtonState.loading) ...[
          IgnorePointer(
              child: SizedBox(
            width: _loadingSize!.width - 10.0,
            height: _loadingSize!.height - 10.0,
            child: Opacity(
                opacity: double.parse(opacityAnimation.value.toString()),
                child: CircularProgressIndicator(
                    color: widget.type == LoadingButtonType.filled
                        ? Theme.of(context).colorScheme.onPrimary
                        : null)),
          ))
        ]
      ],
    );
  }

  Widget _buildButton(LoadingButtonType type, {required Widget child}) {
    switch (type) {
      case LoadingButtonType.elevated:
        return ElevatedButton(
            onPressed: widget.state == LoadingButtonState.idle
                ? widget.onPressed
                : () {},
            onLongPress: widget.state == LoadingButtonState.idle
                ? widget.onLongPress
                : () {},
            onHover: widget.state == LoadingButtonState.idle
                ? widget.onHover
                : (_) {},
            onFocusChange: widget.state == LoadingButtonState.idle
                ? widget.onFocusChange
                : (_) {},
            style: widget.style,
            focusNode: widget.focusNode,
            statesController: widget.statesController,
            child: child);
      case LoadingButtonType.outlined:
        return OutlinedButton(
            onPressed: widget.state == LoadingButtonState.idle
                ? widget.onPressed
                : () {},
            onLongPress: widget.state == LoadingButtonState.idle
                ? widget.onLongPress
                : () {},
            onHover: widget.state == LoadingButtonState.idle
                ? widget.onHover
                : (_) {},
            onFocusChange: widget.state == LoadingButtonState.idle
                ? widget.onFocusChange
                : (_) {},
            style: widget.style,
            focusNode: widget.focusNode,
            statesController: widget.statesController,
            child: child);
      case LoadingButtonType.filled:
        return FilledButton(
            onPressed: widget.state == LoadingButtonState.idle
                ? widget.onPressed
                : () {},
            onLongPress: widget.state == LoadingButtonState.idle
                ? widget.onLongPress
                : () {},
            onHover: widget.state == LoadingButtonState.idle
                ? widget.onHover
                : (_) {},
            onFocusChange: widget.state == LoadingButtonState.idle
                ? widget.onFocusChange
                : (_) {},
            style: widget.style,
            focusNode: widget.focusNode,
            statesController: widget.statesController,
            child: child);
      case LoadingButtonType.filledTonal:
        return FilledButton.tonal(
            onPressed: widget.state == LoadingButtonState.idle
                ? widget.onPressed
                : () {},
            onLongPress: widget.state == LoadingButtonState.idle
                ? widget.onLongPress
                : () {},
            onHover: widget.state == LoadingButtonState.idle
                ? widget.onHover
                : (_) {},
            onFocusChange: widget.state == LoadingButtonState.idle
                ? widget.onFocusChange
                : (_) {},
            style: widget.style,
            focusNode: widget.focusNode,
            statesController: widget.statesController,
            child: child);
    }
  }
}
