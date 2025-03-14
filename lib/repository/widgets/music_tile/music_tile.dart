import 'package:flutter/material.dart';

class MusicTile extends StatelessWidget {
  const MusicTile({super.key});

 

  @override
  Widget build(BuildContext context) {
    return ListTile(
     
      title: Text("Song name", style: Theme.of(context).textTheme.bodySmall),
      tileColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}
