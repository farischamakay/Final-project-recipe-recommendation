import 'package:cooking_tutorial_application/screens/recipe_view/fav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../animation/animation.dart';
import '../../models/recipe_recommendation.dart';

class RecipeAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final RecipeRecom info;
  RecipeAppBar({
    required this.expandedHeight,
    required this.info,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = maxExtent - shrinkOffset;
    final proportion = 2 - (maxExtent / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: maxExtent),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        //overflow: Overflow.visible,
        children: [
          Positioned(
              child: Container(
            color: Colors.white,
            child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child: Stack(
                children: [
                  const SizedBox(
                    height: 300,
                  ),
                  Positioned(
                    child: Image.asset(
                      "assets/bg.jpg",
                      height: 270,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          )),
          AppBarWidget(
            expandedHeight: expandedHeight,
            shrinkOffset: shrinkOffset,
            info: info,
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Opacity(
                opacity: (1 - shrinkOffset / expandedHeight),
                child: DelayedDisplay(
                  delay: const Duration(microseconds: 600),
                  child: Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      // children: [FavoriteBtn(info: info)],
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration(
        stretchTriggerOffset: maxExtent,
      );
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    Key? key,
    required this.expandedHeight,
    required this.shrinkOffset,
    required this.info,
  }) : super(key: key);

  final double expandedHeight;
  final double shrinkOffset;
  final RecipeRecom info;

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              // padding: EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
        title: Opacity(
          opacity: (0 + widget.shrinkOffset / widget.expandedHeight),
          child: const Text(
            "EasyCook",
            style: TextStyle(
              fontFamily: 'Satisfy',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xfff1bb274),
            ),
          ),
        ));
  }
}
