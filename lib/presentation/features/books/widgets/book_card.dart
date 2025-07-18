import 'package:books/components/shared_widgets/app_text.dart';
import 'package:books/core/constants/app_constants.dart';
import 'package:books/core/constants/app_strings.dart';
import 'package:books/core/utils/image_utils.dart';
import 'package:books/data/models/book.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class BookCard extends StatefulWidget {
  final Book book;
  final String heroId; // Optional hero ID for custom animations
  final GlobalKey<BookCardState>? globalKey; // Add global key parameter

  const BookCard({
    super.key,
    required this.book,
    required this.heroId,
    this.globalKey,
  });

  @override
  BookCardState createState() => BookCardState();
}

class BookCardState extends State<BookCard> {
  bool _isVideoMode = false;
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  // Public method to be called via GlobalKey
  Future<void> enableVideoMode() async {
    if (_isVideoMode) return; // Already in video mode

    setState(() {
      _isLoading = true;
    });

    try {
      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(AppConstants.bunnyVideoUrl),
      );

      await _videoController!.initialize();

      setState(() {
        _isVideoMode = true;
        _isVideoInitialized = true;
        _isLoading = false;
      });

      // Auto-play the video
      _videoController!.play();

      // Optional: Loop the video
      _videoController!.setLooping(true);
    } catch (e) {
      print('Error initializing video: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Method to disable video mode and return to normal book card
  void disableVideoMode() {
    _videoController?.pause();
    _videoController?.dispose();
    _videoController = null;

    setState(() {
      _isVideoMode = false;
      _isVideoInitialized = false;
      _isLoading = false;
    });
  }

  // Method to toggle between modes
  void toggleMode() {
    if (_isVideoMode) {
      disableVideoMode();
    } else {
      enableVideoMode();
    }
  }

  Widget _buildVideoPlayer() {
    if (!_isVideoInitialized || _videoController == null) {
      return Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    }

    return Stack(
      children: [
        // Video Player
        SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _videoController!.value.size.width,
              height: _videoController!.value.size.height,
              child: VideoPlayer(_videoController!),
            ),
          ),
        ),

        // Video Controls Overlay
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Play/Pause button
                IconButton(
                  icon: Icon(
                    _videoController!.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_videoController!.value.isPlaying) {
                        _videoController!.pause();
                      } else {
                        _videoController!.play();
                      }
                    });
                  },
                ),

                // Close video button
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: disableVideoMode,
                ),
              ],
            ),
          ),
        ),

        // Video title overlay (optional)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  '${widget.book.title} - Preview',
                  kind: TextKind.heading,
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookCard() {
    return InkWell(
      onTap: () async {
        context.push(
          '/book/${widget.book.id}',
          extra: {"book": widget.book, "heroId": widget.heroId},
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Book Poster - Hero Widget (will animate to small poster in details)
            Hero(
              tag:
                  widget.heroId ?? widget.book.id, // Same tag as details screen
              child: Image.network(
                ImageUtils.getBookCoverImagePath(widget.book.coverImageUrlId),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: Icon(Icons.book, size: 50, color: Colors.white),
                  );
                },
              ),
            ),

            // Dark overlay for text readability
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(1)],
                ),
              ),
            ),

            // Book Info at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      widget.book.title,
                      kind: TextKind.heading,
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 15),
                    AppText(
                      '${AppStrings.by} ${widget.book.author}',
                      kind: TextKind.caption,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    SizedBox(height: 5),
                    AppText(
                      '${AppStrings.year} ${widget.book.publishYear}',
                      kind: TextKind.caption,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Conditional layout based on video mode
            if (_isVideoMode) _buildVideoPlayer() else _buildBookCard(),

            // Loading overlay
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
