import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String? title;
  final bool hasBackButton;
  final BuildContext context;

  const MainAppBar({
    super.key,
    required this.appBar,
    this.title,
    required this.hasBackButton,
    required this.context,
  });

  Widget _backButton(BuildContext context) {
    if (hasBackButton == false) {
      return Container();
    } else {
      return BackButton(onPressed: () {
        Navigator.pop(context);
      });
    }
  }

  Widget _title() {
    if (title == null) {
      return Container(
        margin: const EdgeInsets.all(10),
        child: Image.asset(
          'assets/images/logo2.png',
          alignment: Alignment.center,
          height: 45,
        ),
      );
    } else {
      return Text(
        title!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.w800,
        ),
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppBar(
          elevation: 3.0,
          backgroundColor: Color(0xff4baf96),
          foregroundColor: Colors.white,
          leading: _backButton(this.context),
          centerTitle: true,
          title: _title(),
          toolbarHeight: 75,
        ),
      ],
    );
  }
}
