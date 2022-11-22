import 'package:call_wave_animation/call_wave_wdiget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Call Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final CallWaveController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = CallWaveController(this);
    _waveController.startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            const Icon(
              Icons.rocket,
              color: Colors.purple,
              size: 32,
            ),
            const SizedBox(
              height: 24 * 2,
            ),
            const Text(
              "What would you like to say today",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Each conversation brings you closer to fluency",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 32,
            ),
             SizedBox(
              height: 150,
              width: 150,
              child: RecordWaveWidget(controller: _waveController,),
            ),
            const SizedBox(height: 32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32,),
                 IconButton(onPressed: (){
                   _waveController.startAnimation();
                 }, icon: const Icon(Icons.play_circle, size: 32,),),
                 const SizedBox(width: 32,),
                 IconButton(onPressed: (){_waveController.stopAnimation();}, icon: const Icon(Icons.pause_circle_outline, size: 32,),),
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
