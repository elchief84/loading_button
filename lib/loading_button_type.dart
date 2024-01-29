import 'package:flutter/material.dart';

/// Configures a [LoadingButton] to wrap a native Flutter button.
///
/// When [LoadingButtonType.elevated] the button is created
/// with an [ElevatedButton]
///
/// When [LoadingButtonType.filled] the button is created
/// with an [FilledButton]
///
/// When [LoadingButtonType.filledTonal] the button is created
/// with an [FilledButton.tonal]
///
/// When [LoadingButtonType.outlined] the button is created
/// with an [OutlinedButton]
enum LoadingButtonType {
  elevated,
  filled,
  filledTonal,
  outlined
}
