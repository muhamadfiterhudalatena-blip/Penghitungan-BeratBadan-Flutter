import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //controler
  final TextEditingController tinggiColl = TextEditingController();
  final TextEditingController beratController = TextEditingController();

  //variable
  double? bmi;
  String? kategori;
  Colors? warna;

  void reset() {
    setState(() {
      tinggiColl.clear();
      beratController.clear();
      kategori = "Masukan Nilai";
      bmi = null;
    });
  }

  void hitung() {
    double? tinggi = double.tryParse(tinggiColl.text);
    double? berat = double.tryParse(beratController.text);

    if (berat != null && tinggi != null) {
      setState(() {
        bmi = berat / ((tinggi / 100) * (tinggi / 100));
        if (bmi! < 18.5) {
          kategori = "Kekurangan Berat Badan";
        } else if (bmi! < 25) {
          kategori = "Berat Badan Ideal";
        } else if (bmi! < 30) {
          kategori = "Berat Badan Berlebih";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.amber,
          centerTitle: true,
          title: Text(
            'Penghitungan Berat Badan',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: tinggiColl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Tinggi Badan',
                  icon: Icon(Icons.height),
                ),
              ),
              SizedBox(height: 25),
              TextField(
                controller: beratController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Berat badan',
                  icon: Icon(Icons.fitness_center),
                ),
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: hitung,
                      child: Text('Hitung'),
                    ),
                  ),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: reset,
                      child: Text('Hapus'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              if (bmi != null) ...[
                Text(
                  bmi!.toStringAsFixed(1),
                  style: TextStyle(color: Colors.red, fontSize: 60),
                ),
                Text(
                  '$kategori',
                  style: TextStyle(color: Colors.red, fontSize: 60),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
