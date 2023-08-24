import 'package:flutter/material.dart';
import 'package:who_are_url/jurisdictionInfoPage.dart';
import 'package:who_are_url/rankingPage.dart';
import 'package:who_are_url/searchingPage.dart';

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
            icon: Icon(Icons.home_rounded, color: Color(0xff2EC6F3)),
            label: '홈'),
        BottomNavigationBarItem(
            icon: Icon(Icons.info_outline_rounded, color: Color(0xff2EC6F3)),
            label: '신고처 정보'),
      ],
      onTap: (index) {
        if(index == 0) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SearchingPage()), (route) => false);
        }
        else if(index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>JurisdictionInfoPage()));
        }
      },
    );
  }
}
