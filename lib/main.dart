import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_fitz/models.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<IndexChangeNotifier>(
          create: (context) => IndexChangeNotifier(0),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('the whole app rebuild');

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyInstantProvider(),
                Consumer(
                  builder: (context, text, child) {
                    return MyText(
                        'Value: ${context.watch<IndexChangeNotifier>().index}');
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<IndexChangeNotifier>().increment();
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

// Create and using the value of the provider instantly
// & using consumer so can testing for error purpose
class MyInstantProvider extends StatelessWidget {
  const MyInstantProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => StringModel('_title'),
      child: Container(
        height: 50,
        color: Colors.yellow,
        child: Consumer<StringModel>(
          builder: (_, stringModel, __) => Text(stringModel.title),
        ),
      ),
    );

    /// This code will throw an error
    /// This usually happens when you are creating a provider and trying to read it immediately.

    /// ```
    ///   return Provider(
    ///   create: (_) => StringModel('_title'),
    ///   child: Container(
    ///     height: 50,
    ///     color: Colors.yellow,
    ///     child: Text(Provider.of<StringModel>(context).title),
    ///   ),
    /// );
    /// ```
  }
}

// Testing for Consumer reduce rebuild cost
class MyText extends StatelessWidget {
  const MyText(this.text, {Key? key}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    print('my text had rebuild');
    return Text(text);
  }
}
