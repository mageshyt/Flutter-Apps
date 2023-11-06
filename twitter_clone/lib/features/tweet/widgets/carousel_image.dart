import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselImage extends StatefulWidget {
  final List<String> images;
  const CarouselImage({Key? key, required this.images}) : super(key: key);

  @override
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int _current = 0;
  double _aspectRatio = 1.0; // Initialize the aspect ratio to 1.0

  @override
  Widget build(BuildContext context) {
    // Calculate the aspect ratio of the first image in the widget.images list
    if (widget.images.isNotEmpty) {
      ImageProvider imageProvider = NetworkImage(widget.images.first);
      imageProvider.resolve(ImageConfiguration()).addListener(
        ImageStreamListener(
          (ImageInfo info, bool synchronousCall) {
            if (mounted) {
              setState(() {
                _aspectRatio =
                    info.image.width.toDouble() / info.image.height.toDouble();
              });
            }
          },
        ),
      );
    }

    return Stack(
      children: [
        Column(
          children: [
            CarouselSlider(
              items: widget.images
                  .map(
                    (file) => Container(
                      // rounder corner
                      margin: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          file,
                          fit: BoxFit.contain,
                          // rounded image
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                // Set the height of the CarouselSlider based on the aspect ratio
                height: MediaQuery.of(context).size.height / 2,

                autoPlay: false,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            // * Carousel Indicator
            if (widget.images.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.images.map((url) {
                  int index = widget.images.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Colors.blueAccent
                          : Colors.grey.shade400,
                    ),
                  );
                }).toList(),
              ),
          ],
        )
      ],
    );
  }
}
