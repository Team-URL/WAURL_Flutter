import 'package:flutter/material.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.info_outline_rounded, color: Color(0xff2EC6F3)),
            label: '신고처 정보'),
        BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded, color: Color(0xff2EC6F3)),
            label: '홈'),
        BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: Color(0xff2EC6F3)),
            label: '피싱차트'),
      ],
      onTap: (index) {
        // 다른 페이지 추가 후 기능구현.
      },
    );
  }
}
