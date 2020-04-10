import 'package:flutter/material.dart';

class CardMenu extends StatefulWidget {
  @override
  _CardMenuState createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  int selectedIndex = 0;

  final menusItems = [
    "Dashboard",
    "Messages",
    "Utility Bills",
    "Fund Transfer",
    "Brances"
  ];

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final translateTween = Tween<Offset>(
        begin: Offset(0, 0),
        end: Offset(MediaQuery.of(context).size.width * 1 / 2, 0));

    final scaleTween = Tween<double>(begin: 1.0, end: 0.7);

    final borderRadiusTween = Tween<double>(begin: 0, end: 24);

    final shadowTween =
    ColorTween(begin: Colors.transparent, end: Colors.black38);

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Stack(children: <Widget>[
          MenuList(
            menuItems: menusItems,
            selectedIndex: selectedIndex,
            onItemSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
              _toggleMenu();
            },
          ),
          Transform.translate(
            offset: translateTween.evaluate(CurvedAnimation(
                parent: controller,
                curve: Curves.fastLinearToSlowEaseIn,
                reverseCurve: Curves.fastOutSlowIn)),
            child: Transform.scale(
              scale: scaleTween.evaluate(CurvedAnimation(
                  parent: controller, curve: Curves.decelerate)),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: shadowTween.evaluate(controller),
                      blurRadius: 20,
                      offset: Offset(0, 10))
                ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      borderRadiusTween.evaluate(CurvedAnimation(
                          parent: controller, curve: Curves.decelerate))),
                  child: GestureDetector(
                    onTap: () {
                      if (controller.isCompleted) {
                        _hideMenu();
                      }
                    },
                    child: Container(
                      child: Page(
                        title: menusItems[selectedIndex],
                        onMenuButtonPressed: _toggleMenu,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]);
      },
    );
  }

  _toggleMenu() {
    if (controller.isDismissed) {
      _showMenu();
    } else {
      _hideMenu();
    }
  }

  _showMenu() {
    controller.duration = Duration(milliseconds: 250);
    controller.forward();
  }

  _hideMenu() {
    controller.duration = Duration(milliseconds: 150);
    controller.reverse();
  }
}

class MenuList extends StatelessWidget {
  final List<String> menuItems;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const MenuList(
      {Key key, this.menuItems, this.selectedIndex, this.onItemSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Container(
        margin: EdgeInsets.only(left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(
              menuItems.length,
                  (i) => Container(
                margin: EdgeInsets.only(bottom: 32),
                child: MenuItem(
                  title: menuItems[i],
                  isSelected: i == selectedIndex,
                  onTap: () {
                    onItemSelected(i);
                  },
                ),
              )),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function onTap;

  const MenuItem({Key key, this.title, this.isSelected = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}

class Page extends StatelessWidget {
  final String title;

  final VoidCallback onMenuButtonPressed;

  const Page({Key key, this.onMenuButtonPressed, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white,
          onPressed: onMenuButtonPressed,
        ),
      ),
      body: Container(),
    );
  }
}
