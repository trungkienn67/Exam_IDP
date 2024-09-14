import 'package:flutter/material.dart';
import '../models/song.dart';

class AddSongScreen extends StatelessWidget {
  final Function(Song) onAddSong;
  final _titleController = TextEditingController();
  final _artistController = TextEditingController();
  final _yearController = TextEditingController();

  AddSongScreen({required this.onAddSong});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Song'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Song Title'),
            ),
            TextField(
              controller: _artistController,
              decoration: InputDecoration(labelText: 'Artist'),
            ),
            TextField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Year'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final artist = _artistController.text;
                final year = int.tryParse(_yearController.text);

                if (title.isEmpty || artist.isEmpty || year == null) {
                  return;
                }

                onAddSong(Song(
                  title: title,
                  artist: artist,
                  year: year,
                ));

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Song added successfully!')),
                );
              },
              child: Text('Add Song'),
            ),
          ],
        ),
      ),
    );
  }
}
