import 'package:example/provider_theme.dart';
import 'package:example/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:circular_loading_button/loading_button.dart';
import 'package:circular_loading_button/loading_button_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
          builder: (context, ThemeProvider provider, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: provider.currentTheme,
          home: const MyHomePage(title: 'LoadingButton Demo'),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<LoadingButtonType> types = [
    LoadingButtonType.elevated,
    LoadingButtonType.filled,
    LoadingButtonType.filledTonal,
    LoadingButtonType.outlined
  ];
  List<LoadingButtonState> currentStates = [
    LoadingButtonState.idle,
    LoadingButtonState.idle,
    LoadingButtonState.idle,
    LoadingButtonState.idle
  ];

  int _currentIndex = 0;
  List<ThemeData> themes = [
    CustomTheme.purple,
    CustomTheme.purpleSquared,
    CustomTheme.orange,
    CustomTheme.orangeSquared
  ];

  void _changeState(int index) {
    setState(() {
      currentStates[index] = (currentStates[index] == LoadingButtonState.idle)
          ? LoadingButtonState.loading
          : LoadingButtonState.idle;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SegmentedButton<int>(
                showSelectedIcon: false,
                segments: const <ButtonSegment<int>>[
                  ButtonSegment<int>(value: 0, label: Text('Purple')),
                  ButtonSegment<int>(value: 1, label: Text('Purple SQ')),
                  ButtonSegment<int>(value: 2, label: Text('Orange')),
                  ButtonSegment<int>(value: 3, label: Text('Orange SQ')),
                ],
                selected: <int>{_currentIndex},
                onSelectionChanged: (Set<int> newSelection) {
                  setState(() {
                    _currentIndex = newSelection.first;
                  });
                  provider.currentTheme = themes[_currentIndex];
                },
              ),
              ...List.generate(
                types.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: LoadingButton(
                      type: types[index],
                      state: currentStates[index],
                      expandedSize: const Size(250.0, 80.0),
                      loadingSize: const Size(30.0, 30.0),
                      onPressed: () {
                        _changeState(index);
                        Future.delayed(const Duration(seconds: 3),
                            () => _changeState(index));
                      },
                      child: const Text('Tap me!')),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
