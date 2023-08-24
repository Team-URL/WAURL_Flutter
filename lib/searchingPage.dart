import 'package:flutter/material.dart';

class SearchingPage extends StatefulWidget {

  SearchingPage({super.key});

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  final _urlController = TextEditingController();

  void _onPressed() {
    if(_urlController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('빈 URL 주소'),
          content: const Text('검사를 위해 URL을 입력해주세요'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('확인'),
            ),
          ],
        ),
      );
    }
    else {
      // 검사결과 페이지로 이동.
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(),
          TextField(
          controller: _urlController,
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: Colors.grey,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1,
          ),

          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hoverColor: const Color(0xffffffff),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Color(0xff2ec6f3)),
              borderRadius: BorderRadius.circular(15),
              gapPadding: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              gapPadding: 15,
            ),
            suffixIcon: IconButton(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              onPressed: _onPressed,
              icon: const Icon(Icons.search),
            ),
            contentPadding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
            hintText: 'https://www.whoareurl.com',
            hintStyle: const TextStyle(
              color: Color(0xff868686),
            ),
          ),
        ),
        ],
      ),
    );
  }
}
