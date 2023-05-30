import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/page1': (context) => Ricerca(),
        '/page2': (context) => Page2(),
      },
      
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ciao',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/page1');
              },
              child: Text('Pagina 1'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/page2');
              },
              child: Text('Pagina 2'),
            ),
          ],
        ),
      ),
    );
  }
}

class Ricerca extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Ricerca> {
  String _result = '';

  void fetchData(String input) async {
    try {
      final response = await Dio().get('https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$input');
      setState(() {
        _result = response.data.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Errore nella richiesta API';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                // Aggiorna la stringa in base all'input nel campo di testo
                // Puoi eseguire ulteriori validazioni o manipolazioni dell'input qui
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Effettua la chiamata API quando il pulsante viene premuto
                String input = ''; // Recupera la stringa dall'input del campo di testo
                fetchData(input);
              },
              child: Text('Effettua chiamata API'),
            ),
            SizedBox(height: 10),
            Text(
              'Risultato JSON:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _result,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina 2'),
      ),
      body: Center(
        child: Text(
          'Contenuto pagina 2',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}