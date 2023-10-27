

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:bennu_app/viewmodels/media_viewmodel.dart';

class MediaItemView extends StatefulWidget {
  final MediaViewModel viewModel;

  const MediaItemView({required this.viewModel, Key? key, required caption, required itemlimit, required postDate, required likes, required comments, required shares, required purchases, required media, required boxin}) : super(key: key);

  @override
  MediaItemViewState createState() => MediaItemViewState();
}

class MediaItemViewState extends State<MediaItemView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network(widget.viewModel.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void play() {
    if (!_controller.value.isInitialized) return;
    _controller.play();
  }

  void pause() {
    if (!_controller.value.isInitialized) return;
    _controller.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Video Player
        Positioned.fill(
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        ),
        
        // Caption Area
        Positioned(
          top: MediaQuery.of(context).size.height / 3,
          left: MediaQuery.of(context).size.width * 0.1,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.66,
            child: Text(
              widget.viewModel.caption,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        
        // Right Side Icons
        Positioned(
          top: 50,
          right: 10,
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.viewModel.userIcon),
              ),
              const Icon(Icons.add, color: Colors.white),
              const SizedBox(height: 10),
              const Icon(Icons.thumb_up, color: Colors.white),
              Text('${widget.viewModel.likes}', style: const TextStyle(color: Colors.white)),
              const Icon(Icons.comment, color: Colors.white),
              Text('${widget.viewModel.comments}', style: const TextStyle(color: Colors.white)),
              const Icon(Icons.more_horiz, color: Colors.white),
              ElevatedButton(onPressed: () {}, child: const Text('Buy')),
              const Icon(Icons.shopping_cart, color: Colors.white),
              Text('${widget.viewModel.incart}', style: const TextStyle(color: Colors.white)),
              const Icon(Icons.add_shopping_cart, color: Colors.white),
              Text('${widget.viewModel.shares}', style: const TextStyle(color: Colors.white)),
              const Icon(Icons.share, color: Colors.white),
            ],
          ),
        ),
        
        // Bottom Icons and Info
        Positioned(
          bottom: 10,
          left: 10,
          child: Row(
            children: [
              Text('${widget.viewModel.stock}', style: const TextStyle(color: Colors.white)),
              const SizedBox(width: 10),
              Text('\$${widget.viewModel.price}', style: const TextStyle(color: Colors.white)),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }
}

class MediaReel extends StatefulWidget {
  final List<MediaViewModel> viewModels;

  const MediaReel({Key? key, required this.viewModels}) : super(key: key);

  @override
  MediaReelState createState() => MediaReelState();
}

class MediaReelState extends State<MediaReel> {
  final List<GlobalKey<MediaItemViewState>> _keys = [];

  @override
  void initState() {
    super.initState();
    for (var _ in widget.viewModels) {
      _keys.add(GlobalKey<MediaItemViewState>());
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.viewModels.length,
      itemBuilder: (context, index) {
        return VisibilityDetector(
          key: Key('video-$index'),
          onVisibilityChanged: (visibilityInfo) {
            final visiblePercentage = visibilityInfo.visibleFraction * 100;
            if (visiblePercentage > 50) {
              _keys[index].currentState?.play();
            } else {
              _keys[index].currentState?.pause();
            }
          },
          child: MediaItemView(viewModel: widget.viewModels[index], key: _keys[index], caption: null, itemlimit: null, postDate: null, likes: null, comments: null, shares: null, purchases: null, media: null, boxin: null,),
        );
      },
    );
  }
}
