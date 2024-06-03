import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double weight = 0;
  double height_meters = 0;
  TextEditingController weightController = TextEditingController();
  TextEditingController heightFeetController = TextEditingController();
  TextEditingController heightInchesController = TextEditingController();
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator', style: TextStyle(fontSize: 21),),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xfffef9d7),
              Color(0xffd299c2),
            ],
            begin: FractionalOffset(0.5, 0),
            end: FractionalOffset(0.5, 1.0),
            stops: [0.5, 1],
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Enter Your Details: ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 60,
                child: TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    label: Text('Weight', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,)),
                    hintText: 'Enter your weight in Kgs',
                    prefixIcon: Icon(FontAwesomeIcons.weight, size: 25, color: Colors.deepPurple),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 60,
                child: TextField(
                  controller: heightFeetController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    label: Text('Height(feet)', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,)),
                    hintText: 'Enter your height in feets',
                    prefixIcon: Icon(FontAwesomeIcons.rulerVertical, size: 25, color: Colors.deepPurple, weight: 40,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                child: TextField(
                  controller: heightInchesController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    label: Text('Height(inches)', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,)),
                    hintText: 'Enter extra height in inches',
                    prefixIcon: Icon(FontAwesomeIcons.plus, size: 25, color: Colors.deepPurple,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: (){
                if(weightController.text.isEmpty || heightFeetController.text.isEmpty || heightInchesController.text.isEmpty){
                  setState(() {
                    error = "Please enter all the details";
                  });
                } else {
                  setState(() {
                    error = "";
                  });
                  weight = double.parse(weightController.text);
                  height_meters = (double.parse(heightFeetController.text)) * 0.3048 + (double.parse(heightInchesController.text)) * 0.0254;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BMIPage(bmi: (weight/(height_meters*height_meters)))));
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.white, width: 2)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                backgroundColor: Colors.blue,
                elevation: 5,
                ),
              child: const Text('Calculate BMI', style: TextStyle(fontSize: 20, color: Colors.white),)
              ),
              const SizedBox(height: 20,),
              Text(error, style: const TextStyle(fontSize: 20, color: Colors.red),)
          ],),
      )
      );
  }
}

class BMIPage extends StatelessWidget {
  final double bmi;
  const BMIPage({super.key, required this.bmi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Result', style: TextStyle(fontSize: 21),),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xfffddb92),
              Color(0xfffed6e3),
            ],
            radius: 0.4,
            center: Alignment.center
            )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Your Body Mass Index is-\n ${bmi.toStringAsFixed(2)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              const SizedBox(height: 20,),
              if(bmi < 18.5)
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.8,
                  color: Colors.red.shade300,
                  child: const Center(child: Text('Underweight!', style: TextStyle(fontSize: 24, color: Colors.black),))
                )
              else if(bmi >= 18.5 && bmi < 24.9)
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.8,
                  color: Colors.green.shade300,
                  child: const Center(child: Text('Healthy', style: TextStyle(fontSize: 24, color: Colors.black),)))
              else if(bmi >= 24.9 && bmi < 29.9)
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.8,
                  color: Colors.red.shade300,
                  child: const Center(child: Text('Overweight!', style: TextStyle(fontSize: 24, color: Colors.black),)))
              else
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.8,
                  color: Colors.red.shade800,
                  child: const Center(child: Text('Obese!!!', style: TextStyle(fontSize: 24, color: Colors.white),)))
            ],
          ),
        ),
      ),
    );
  }
}
