import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> with SingleTickerProviderStateMixin{
  final ScrollController _scrollController = ScrollController();
  int _activeIndex = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _animateToMiddle(int index) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const double itemWidth = 120.0; //
    final double middleScreen = screenWidth / 2;
    final double targetPosition = index * itemWidth - middleScreen + itemWidth;

    _scrollController.animateTo(targetPosition, duration: const Duration(milliseconds: 900), curve: Curves.easeInOut);
  }

  Widget _buildListItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeIndex = index;
          _animateToMiddle(index);
        });
      },
      child: Container(
        width: 100.0, // Adjust this to the width of your list item
        margin: const EdgeInsets.all(10.0),
        color: _activeIndex == index ? Colors.blue : Colors.grey,
        alignment: Alignment.center,
        child: Text('Item $index', style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Horizontal List Animation')),
      body: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 10, // Replace this with the actual number of items in your list
        itemBuilder: (context, index) => _buildListItem(index),
      ),
    );
  }
}
