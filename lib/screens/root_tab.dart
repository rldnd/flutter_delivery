import 'package:delivery/components/layout/default_layout.dart';
import 'package:delivery/styles/colors.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '딜리버리',
      child: Center(
        child: Text('Root Tab'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: C_PRIMARY,
        unselectedItemColor: C_BODY_TEXT,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => this.index = index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
