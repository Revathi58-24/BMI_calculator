import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark().copyWith(
          primary: Color(0xFF0A0E21),
          onPrimary: Colors.white,
          surface: Color(0xFF0A0E21),
          onSurface: Colors.white,
          secondary: Colors.purple,
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  double height = 180;
  double weight = 70;
  double bmi = 0;
  String bmiResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Height',
            style: TextStyle(fontSize: 18),
          ),
          Slider(
            value: height,
            min: 120,
            max: 220,
            onChanged: (double value) {
              setState(() {
                height = value;
              });
            },
          ),
          Text(
            '${height.toStringAsFixed(2)} cm',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Weight',
            style: TextStyle(fontSize: 18),
          ),
          Slider(
            value: weight,
            min: 20,
            max: 150,
            onChanged: (double value) {
              setState(() {
                weight = value;
              });
            },
          ),
          Text(
            '${weight.toStringAsFixed(2)} kg',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              calculateBMI();
            },
            child: Text('Calculate BMI'),
          ),
          SizedBox(height: 20),
          Text(
            'BMI: ${bmi.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            '$bmiResult',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: bmiResult == 'Underweight'
                  ? Colors.blue
                  : bmiResult == 'Normal'
                  ? Colors.green
                  : bmiResult == 'Overweight'
                  ? Colors.orange
                  : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void calculateBMI() {
    double heightInMeters = height / 100;
    bmi = weight / (heightInMeters * heightInMeters);
    setState(() {
      bmiResult = getBMIResult(bmi);
    });
    showWeightInfo(bmiResult);
  }


  String getBMIResult(double bmiValue) {
    if (bmiValue < 18.5) {
      return 'Underweight';
    } else if (bmiValue >= 18.5 && bmiValue < 24.9) {
      return 'Normal';
    } else if (bmiValue >= 25.0 && bmiValue < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }
  void showWeightInfo(String result) {
    String message = '';

    switch (result) {
      case 'Underweight':
        message = 'You might want to consider gaining some weight for better health.';
        break;
      case 'Normal':
        message = 'Great job! Your weight is within the healthy range.';
        break;
      case 'Overweight':
        message = 'Consider focusing on a balanced diet and regular exercise for a healthier weight.';
        break;
      case 'Obese':
        message = 'Consult a healthcare professional for advice on weight management.';
        break;
      default:
        message = 'Invalid BMI result.';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
          title: Text('Weight Information'),
          content: Text(message,
            style: TextStyle(
              color: Colors.pink,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

