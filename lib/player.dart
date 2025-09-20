import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final String trailerUrl;
  final List backdrop;
  const VideoPlayerPage({
    super.key,
    required this.trailerUrl,
    required this.backdrop,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(widget.trailerUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(title: const Text("Trailer")),
          body: Column(
            children: [
              player,
              Align(
                alignment: Alignment.topLeft,
                child: Text("BackDrop",style: TextStyle(
                  fontSize: 20, color: Colors.black, 
                  fontWeight: FontWeight.bold
                ),)),
                SizedBox(height: 10,),
              SizedBox(
                height: 400,
                child: Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.backdrop.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          Image.network(
                            widget.backdrop[index],
                            fit: BoxFit.contain,
                            height: 250,
                            width: 450,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Review",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.reviews),
                  ],
                ),
              ),
              SizedBox(height: 26),
            ],
          ),
        );
      },
    );
  }
}
