import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      // Change the UI using Themes
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
}

// Create a minimal state class
class RandomWordsState extends State<RandomWords> {
  // Add build() method
  @override
  Widget build(BuildContext context) {
    // update the build() method to use _buildSuggestions()
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),

        // Navigate to a new screen
        // Add the icon and its corresponding action to the build method:
        actions: <Widget>[
          // Add 3 lines from here...
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  // Create an infinite scrolling ListView

  // Add a _suggestions list and _biggerFont variable for making the font size larger.
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  //  _buildSuggestions() function to the RandomWordsState class
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  // Add a _buildRow() function to RandomWordsState:
  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      // Add the icons,
      trailing: Icon(
        // Add the lines from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      // Add onTap, as shown below:
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  // Add a _pushSaved() function to the RandomWordsState class.
  void _pushSaved() {
    // Call Navigator.push, as shown below, which pushes the route to the Navigator's stack.
    Navigator.of(context).push(
      // Next, you'll add the MaterialPageRoute and its builder. For now, add the code that generates the ListTile rows.
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          // The divideTiles() method of ListTile adds horizontal spacing between each ListTile.
          // The divided variable holds the final rows, converted to a list by the convenience function, toList().
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          // Add horizontal dividers, as shown below
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}

// The RandomWords widget does little else beside creating its State class
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
