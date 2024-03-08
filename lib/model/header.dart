import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.deviceWidth,
    required this.deviceHeight,
  });

  final double deviceWidth;
  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth,
      height: deviceHeight / 3,
      decoration: const BoxDecoration(
        color: Colors.purple,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('lib/assets/images/header.png'),
        ),
      ),
      child: const Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'October 20, 2022',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'My Todo List',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
