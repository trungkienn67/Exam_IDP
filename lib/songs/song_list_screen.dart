import 'package:flutter/material.dart';
import '../models/song.dart';
import 'add_song_screen.dart';
import 'update_song_screen.dart';


class SongListScreen extends StatefulWidget {
  @override
  _SongListScreenState createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  final List<Song> _songs = [];

  void _navigateToAddSongScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSongScreen(onAddSong: _addSong),
      ),
    );
  }

  void _navigateToUpdateSongScreen(Song song) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateSongScreen(
          song: song,
          onUpdateSong: (updatedSong) {
            setState(() {
              final index = _songs.indexOf(song);
              if (index != -1) {
                _songs[index] = updatedSong;
              }
            });
          },
        ),
      ),
    );
  }

  void _addSong(Song song) {
    setState(() {
      _songs.add(song);
    });
  }

  void _deleteSong(Song song) {
    setState(() {
      _songs.remove(song);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Manager'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _songs.isEmpty
            ? Center(child: Text('No songs available, add some!', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)))
            : ListView.builder(
                itemCount: _songs.length,
                itemBuilder: (context, index) {
                  final song = _songs[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(song.title, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${song.artist} - ${song.year}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () => _navigateToUpdateSongScreen(song),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteSong(song),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddSongScreen,
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
