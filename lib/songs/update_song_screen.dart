import 'package:flutter/material.dart';
import '../models/song.dart';

class UpdateSongScreen extends StatefulWidget {
  final Song song;
  final Function(Song) onUpdateSong;

  UpdateSongScreen({required this.song, required this.onUpdateSong});

  @override
  _UpdateSongScreenState createState() => _UpdateSongScreenState();
}

class _UpdateSongScreenState extends State<UpdateSongScreen> {
  late TextEditingController _titleController;
  late TextEditingController _artistController;
  late TextEditingController _yearController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.song.title);
    _artistController = TextEditingController(text: widget.song.artist);
    _yearController = TextEditingController(text: widget.song.year.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Song'),
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

                final updatedSong = Song(
                  title: title,
                  artist: artist,
                  year: year,
                );
                widget.onUpdateSong(updatedSong);

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Song updated successfully!')),
                );
              },
              child: Text('Update Song'),
            ),
          ],
        ),
      ),
    );
  }
}
