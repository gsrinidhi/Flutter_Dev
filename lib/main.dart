import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

//Weekly challenge 1
/*class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {



    void incrementCounter(){
      setState(() {
        counter++;
      });
      print("The button was pressed $counter times");
    }
    final wordPair = WordPair.random();

    return Scaffold(
      appBar: AppBar(
        title: Text("App Bar"),
      ),
      body: Center(
        child: Container(
          child: Table(
            border: TableBorder(
              top: BorderSide(width: 5,color: Colors.red),
              bottom: BorderSide(width: 5,color: Colors.red),
              right: BorderSide(width: 5,color: Colors.red),
              left: BorderSide(width: 5,color: Colors.blue),
            ),
              children: [
                TableRow(
                  children: [
                    Text(wordPair.asPascalCase),
                    Text("Row 1 Col 2"),
                    Text("Row 1 Col 2"),
                  ]
                ),
                TableRow(
                    children: [
                      Text("Row 2 Col 1"),
                      Text("Row 2 Col 2"),
                      Text("Row 2 Col 2"),
                    ]
                ),
              ]
          ),
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: incrementCounter,
      ),
    );
  }
}*/

//Weekly challenge 2
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
      theme: ThemeData(
          primaryColor: Colors.amberAccent
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(onPressed: _pushSaved, icon: Icon(Icons.list))
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if(i.isOdd) return const Divider();

        final index = i ~/ 2;
        if(index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          alreadySaved ? _saved.remove(pair) : _saved.add(pair);
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (BuildContext context) {
              final tiles = _saved.map(
                      (WordPair pair) {
                    return ListTile(
                      title: Text(
                        pair.asPascalCase,
                        style: _biggerFont,
                      ),
                    );
                  }
              );
              final divided = tiles.isNotEmpty ? ListTile.divideTiles(context: context, tiles: tiles).toList() : <Widget>[];

              return Scaffold(
                appBar: AppBar(
                  title: Text('Saved Suggestions'),
                ),
                body: ListView(children: divided),
              );
            }
        )
    );
  }
}
