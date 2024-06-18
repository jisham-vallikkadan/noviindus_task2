import 'package:flutter/material.dart';
import 'package:flutter_task/provider/task_provder.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../models/homw_model.dart';

class videoPlayer extends StatefulWidget {
  final Result? result;
  const videoPlayer({super.key, this.result});

  @override
  State<videoPlayer> createState() => _videoPlayerState();
}

class _videoPlayerState extends State<videoPlayer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TasKProvider>(context, listen: false).controller =
        VideoPlayerController.networkUrl(
            Uri.parse('https://frijo.noviindus.in/${widget.result?.video}'))
          ..initialize().then((_) {
            setState(() {});
          });
  }

  Widget build(BuildContext context) {
    return Consumer<TasKProvider>(builder: (context, home, _) {
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 350,
          // decoration: BoxDecoration(
          //     color: Colors.black12,
          //     image: DecorationImage(
          //         image:
          //             NetworkImage('https://frijo.noviindus.in/${widget.result?.image}'),
          //         fit: BoxFit.fill)),
          child: Center(
            child: VideoPlayer(home.controller),
          ));
    });
  }
}
