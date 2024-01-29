import 'package:flutter/material.dart';

/// Configures how an [LoadingButton] behaves when a specific
/// state is assigned.
///
/// When [LoadingButtonState.loading] the button maintain visible
/// only a [CircularProgressIndicator] disabling gestures
///
/// When [LoadingButtonState.idle] the button is active
/// and any gesture event are fired
enum LoadingButtonState { loading, idle }
