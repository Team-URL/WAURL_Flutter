import 'package:flutter/material.dart';
import 'package:who_are_url/mainAppBar.dart';
import 'package:who_are_url/mainNavigationBar.dart';
import 'package:who_are_url/resultPage.dart';

class SearchingPage extends StatefulWidget {

  const SearchingPage({super.key});

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  final _domainController = TextEditingController();

  void _onPressed() {
    if(_domainController.text.isEmpty) {
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
      Navigator.push(context, MaterialPageRoute(
        builder: (context)
        =>ResultPage(
          url: _domainController.text,
        ),
      ));
    }
  }

  @override
  void dispose() {
    _domainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'WhoAreURL',
        home: Scaffold(
          appBar: MainAppBar(appBar: AppBar(), hasBackButton: false, context: context),
          body: Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(40, 60, 40, 60),
            width: double.infinity,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(   // 안내 메세지.
                  child: Text('아래에 검사할 사이트 주소를\n입력해주세요',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        height: 1.3
                    ),
                  ),
                ),
                Container(   // 검색 바.
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: TextField(
                      controller: _domainController,
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
                          borderSide: const BorderSide(width: 2, color: Color(0xff4baf96)),
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
                          icon: const Icon(
                              Icons.search,
                              color: Color(0xff4baf96),
                          ),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                        hintText: 'https://www.whoareurl.com',
                        hintStyle: const TextStyle(
                          color: Color(0xff868686),
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
          bottomNavigationBar: const MainNavigationBar(),
        )
    );
  }
}
