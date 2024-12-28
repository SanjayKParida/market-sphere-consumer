import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CategoryHeaderWidget extends StatelessWidget {
  const CategoryHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return SizedBox(
      width: size.width,
      height: size.height * 0.1445,
      child: Stack(
        children: [
          Image.asset(
            'assets/icons/searchBanner.jpeg',
            width: size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
              left: 0.05,
              top: size.height * 0.06,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    IconlyLight.arrow_left_2,
                    color: Colors.white,
                  ))),
          Positioned(
              left: size.width * 0.15,
              top: size.height * 0.06,
              child: const SizedBox(
                width: 200,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "hintText",
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    filled: true,
                  ),
                ),
              )),
          Positioned(
              left: 275,
              top: 57,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () {},
                  child: Ink(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/icons/bell.png'),
                    )),
                  ),
                ),
              )),
          Positioned(
            left: 320,
            top: 57,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                child: Ink(
                  width: 25,
                  height: 25,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/icons/message.png'),
                  )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
