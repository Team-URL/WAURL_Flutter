import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:who_are_url/mainAppBar.dart';
import 'package:who_are_url/mainNavigationBar.dart';

class ReportPage extends StatefulWidget {
  String url;
  ReportPage({
    super.key,
    required this.url,
  });

  @override
  _ReportPageState createState() => _ReportPageState();
}

void fetchInfo(String reportPage, String reason) async {

  var url = Uri.http('13.124.151.213:8080', '/report/new',
      {'url': reportPage, 'report_body': reason});
  final response = await http.post(url, headers: {
    'Content-Type': 'application/json',
  });

  if (response.statusCode == 200) {
    //만약 서버가 ok응답을 반환하면, json을 파싱합니다
    print('응답했다');
    print(json.decode(response.body));
  } else {
    //만약 응답이 ok가 아니면 에러를 던집니다.
    throw Exception('API를 불러오는데 실패했습니다');
  }
}
class _ReportPageState extends State<ReportPage> {
  TextEditingController reasonController = TextEditingController();
  bool agreedToTerms = false;

  void _submitForm() {
    if (reasonController.text.isEmpty) {  // 신고 사유 미기입 시 팝업창
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('안내'),
          content: Text('신고사유를 작성해주세요.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('확인'),
            ),
          ],
        ),
      );
    }
    else if (!agreedToTerms) {  // 주의사항 동의 체크박스 동의하지 않았을 때 팝업창
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('안내'),
          content: Text('신고하기 전에 주의사항에 동의해주세요.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('확인'),
            ),
          ],
        ),
      );
    } else {   // 조건을 충족시켰을 때 신고 접수를 진행시킨 후 신고완료를 확인시켜주는 팝업창
      String reason = reasonController.text;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('신고 완료'),
          content: Text('신고가 성공적으로 접수되었습니다.\n\n URL: ${widget.url}\n\n 신고사유: $reason'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                fetchInfo((widget.url),reason);
              },
              child: Text('확인'),
            ),
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: MainAppBar(appBar: AppBar(), hasBackButton: true, context: context),

      body: Container(

        color: Colors.white,
        padding: EdgeInsets.all(16.0),

        child: ListView(

          children: [

            SizedBox(height: 3),

            Text(
              '의심스러운 URL을 신고해주세요',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            Divider(),

            Row(  // 신고할 url 및 icon 나열
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Icon(
                  Icons.warning,
                  color: Colors.amberAccent,
                  size: 18,
                ),
                Text(
                  '${widget.url}',
                  style: TextStyle(fontSize: 18, color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
                Icon(
                  Icons.warning,
                  color: Colors.amberAccent,
                  size: 18,
                ),
              ],
            ),

            SizedBox(height: 15),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '신고사유',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: reasonController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: '예시: 금전 피해를 입었습니다',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Icon(
                      Icons.beenhere_outlined,
                      color: Colors.deepOrangeAccent,
                      size: 18,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '주의사항',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  '개인 정보 노출 - 타인의 개인정보가 포함되지 않도록 주의해주세요.',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '허위 정보 - 정확하지 않거나 올바르지 않은 정보가 포함되지 않도록 주의해주세요.',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '불필요한 신고 - 가벼운 이유나 악의적인 목적이 아닌 경우 신고하지 않도록 주의해주세요.',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '이외에 타인에게 혼란을 야기하거나 피해를 입힐 수 있는 내용이 담겨있다면 신고가 정상 접수 되지 않고 어플 이용이 제한될 수 있습니다.',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: agreedToTerms,
                  onChanged: (value) {
                    setState(() {
                      agreedToTerms = value!;
                    });
                  },
                ),
                Text('위 주의사항에 동의합니다.'),
              ],
            ),
            Container(
              alignment: Alignment.center,
              width: 150,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Color(0xff2EC6F3), // 버튼 배경색
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
                child: Text('신고하기', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              ),
            )

          ],
        ),
      ),
      bottomNavigationBar: MainNavigationBar(),
    );
  }
}

