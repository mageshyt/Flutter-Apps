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
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CarouselSlider(
              items: widget.images
                  .map(
                    (file) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        margin: const EdgeInsets.all(5.0),
                        child: Image.network(file, fit: BoxFit.contain)),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 300,
                viewportFraction: 1,
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
