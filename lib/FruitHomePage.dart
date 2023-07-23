import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:google_fonts/google_fonts.dart';

import 'FruitModel.dart';

class FruitHomePage extends StatefulWidget {
  const FruitHomePage({super.key});

  @override
  State<FruitHomePage> createState() => _FruitHomePageState();
}

class _FruitHomePageState extends State<FruitHomePage> with SingleTickerProviderStateMixin{

  final ScrollController _scrollController = ScrollController();

  late Animation animation;
  late AnimationController controller;

  String selectedFruit = "Apple";
  int _activeIndex = 0;
  List<FruitModel> fruitList = [FruitModel("Apple", "assets/apple.png"),FruitModel("Banana", "assets/banana.png"),FruitModel("Orange", "assets/orange.png"),FruitModel("Strawberry", "assets/strawberry.png"),FruitModel("Tamarind", "assets/temarind.png")];

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    animation = Tween(begin: 0.0, end: 430.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    animation.addListener(() {
      setState(() {
        print("Animation Value ${animation.value}");
      });
    });

    controller.forward();

    super.initState();

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// List Animation
  void _animateToMiddle(int index) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    const double itemWidth = 120.0;
    final double middleScreen = screenWidth / 2;
    final double targetPosition = index * itemWidth - middleScreen + itemWidth;

    _scrollController.animateTo(targetPosition, duration: const Duration(milliseconds: 900), curve: Curves.easeInOut);
  }

  /// Change Bottom Image
  void _changeBottomImage(int index) {
    controller.reset();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(top:0,bottom:0,left:0,right:0,child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text("F R U I T K A",
                          style: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w800,
                            wordSpacing: 5,
                            fontSize: 30,
                          )),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0,bottom: 50.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text("F R U I T  S H O P",
                        style: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 255, 128, 0),
                          fontWeight: FontWeight.w800,
                          wordSpacing: 5,
                          fontSize: 12,
                        )),
                  ),
                ),
                SizedBox(
                  height: 150.0,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: fruitList.length, // Replace this with the actual number of items in your list
                    itemBuilder: (context, index) => _buildListItem(index),
                  ),
                ),
                const SizedBox(height: 50.0,),
                Flash(
                  delay: const Duration(seconds: 2),
                  child: Text(
                    selectedFruit,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Pick Your Fruit",
                  style: GoogleFonts.publicSans(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      "assets/arrow.png",
                      color: Colors.grey,
                    )),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 400,
                    child: Image.asset(
                      "assets/plate.png",
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          "assets/minus.png",
                          color: Colors.grey,
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      "0",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w900,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          "assets/plus.png",
                          color: Colors.grey,
                        )),
                  ],
                ),
              ],
            )),
            Positioned(bottom: - 250.0 + animation.value,left:0,right:0,child: Image.asset(fruitList[_activeIndex].fruitImage,height: 220.0,width: 220.0,),)
          ],
        ),
      ),
    );
  }

  ///List Item
  Widget _buildListItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFruit = fruitList[index].fruitName;
          _activeIndex = index;
          _animateToMiddle(index);
          _changeBottomImage(index);
        });
      },
      child: Container(
        width: 100.0, // Adjust this to the width of your list item
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: _activeIndex == index ? Colors.blue : Colors.grey,)
          //color: _activeIndex == index ? Colors.blue : Colors.grey,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(fruitList[index].fruitImage,height: 64.0,width: 64.0,),
            Text(fruitList[index].fruitName, style: GoogleFonts.roboto(
              color: const Color.fromARGB(255, 255, 128, 0),
              fontWeight: FontWeight.w800,
              wordSpacing: 2,
              fontSize: 18,
            )),
          ],
        ),
      ),
    );
  }

}
