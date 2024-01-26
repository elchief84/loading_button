# loading_button

**loading_button** is a flutter loading/progress animated button.

![](https://github.com/elchief84/loading_button/blob/master/example/sample.gif) ![](https://github.com/elchief84/loading_button/blob/master/example/theme.gif)

**loading_button** is implemented using native flutter buttons type (ElevatedButton, FilledButton, OutlinedButton at this moment). For this reason it is customizable throught your app theme

Try at [demo on DartPad](https://dartpad.dev/?id=c1eabfeb0bf1a2474d1249be07a2c468)

## Getting Started
Follow these steps to use this package

### Add dependency

```yaml
dependencies:
  loading_button: ^1.0.0
```

### Add import package

```dart
import 'package:loading_button/loading_button.dart';
```

### Easy to use
Simple example of use LoadingButton<br>
Put this code in your project at an screen and learn how it works 😊

```dart
// set initial button state
LoadingButtonState _currentState = LoadingButtonState.idle;

LoadingButton(
  type: LoadingButtonType.elevated,
  state: _currentState,
  onPressed: () {
    // change button state to loading
    setState(() => _currentState = LoadingButtonState.loading);
    
    // wait 3 seconds and set button state to idle
    Future.delayed(const Duration(seconds: 3), () => setState(() => _currentState = LoadingButtonState.idle));
    },
  child: const Text('Tap me!')
)
```

### Parameters
You can define button sizes in loading and idle state simply adding 'expandedSize' and 'loadingSize' parameters.

```dart
LoadingButton(
    type: LoadingButtonType.elevated,
    state: _currentState,
    expandedSize: const Size(250.0, 80.0),
    loadingSize: const Size(30.0, 30.0),
    onPressed: () {
      // TODO your actions
    },
    child: const Text('Tap me!')
)
```

## Contributions
All contributions are welcome!
Contributions are what make the open source community such an amazing place to be learned, inspire, and create. Any contributions you make are greatly appreciated.
