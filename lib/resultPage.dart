import 'package:flutter/material.dart';

// api 연동위한 import.
import 'package:http/http.dart' as http;
import 'package:who_are_url/jurisdictionInfoPage.dart';
import 'package:who_are_url/mainAppBar.dart';
import 'package:who_are_url/mainNavigationBar.dart';
import 'dart:async';
import 'dart:convert';

import 'package:who_are_url/rankingPage.dart';
import 'package:who_are_url/reportPage.dart';

Future<ResultPage> fetchInfo(String URL) async {
  var url = Uri.http('13.124.151.213:8080', '/result/get', {'url': URL});
  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
  });

  if (response.statusCode == 200) {
    //만약 서버가 ok응답을 반환하면, json을 파싱합니다
    print('응답했다');
    print(json.decode(response.body));
    return ResultPage.fromJson(json.decode(response.body));
  } else {
    //만약 응답이 ok가 아니면 에러를 던집니다.
    throw Exception('API를 불러오는데 실패했습니다');
  }
}

class Status {
  final String imogeAddress;
  final String? resultInfo;
  final String additionalInfo;
  final Color backgroundColor;
  final String directionText;
  final String directionButtonText;

  Status({
    required this.imogeAddress,
    this.resultInfo,
    required this.additionalInfo,
    required this.backgroundColor,
    required this.directionText,
    required this.directionButtonText,
  });
}

class ResultPage extends StatefulWidget {
  final List<Status> statuses = [   // 검색결과에 따른 메시지, 이모지, 배경
    Status( // 안전함.
      imogeAddress: 'assets/images/imoge_safe.png',
      resultInfo: '안전한 사이트로\n등록되어 안전해요',
      additionalInfo: '안심하고 이 사이트로 떠나도 돼요',
      backgroundColor: Color(0xff8EFFBB),
      directionText: '위험한 사이트를 미리 확인해봐요',
      directionButtonText: '피싱 차트',
    ),
    Status( // 위험.
      imogeAddress: 'assets/images/imoge_warnning.png',
      resultInfo: '피싱으로 확인된\n위험한 사이트에요',
      additionalInfo: '클릭 전에 위험을 확인해서 다행이에요',
      backgroundColor: Color(0xffFDF28E),
      directionText: '피해를 입었다면 이렇게 신고해요',
      directionButtonText: '신고처 정보',
    ),
    Status( // 알 수 없음.
      imogeAddress: 'assets/images/imoge_unknown.png',
      additionalInfo: '안전을 확인할 수 없으니 클릭에 주의하세요!',
      backgroundColor: Color(0xffe8e8e8),
      directionText: '피싱사이트로 의심되면 신고해요',
      directionButtonText: '이 사이트 신고',
    ),
  ];
  final int phishingCount;
  final bool isSafe;
  final bool isDangerous;
  final String url;
  Status? status;
  Widget? nextPage;

  ResultPage({
    super.key,
    this.phishingCount = -1,
    this.isSafe = false,
    this.isDangerous = false,
    required this.url,
  }) {
    if(phishingCount == -1) {
      return;
    }

    if(isSafe == true) {
      status = statuses[0]; // safe.
      nextPage = RankingPage();
    }
    else if(isDangerous == true) {
      status = statuses[1];   // dangerous.
      nextPage = JurisdictionInfoPage();
    }
    else {
      status = statuses[2];   // unknown.
      nextPage = ReportPage(domain: url);
    }
  }

  String get result {
    if(status!.resultInfo == null) {
      return '이 사이트는 지금까지\n$phishingCount번 신고되었어요';
    }
    else {
      return status!.resultInfo!;
    }
  }

  factory ResultPage.fromJson(Map<String, dynamic> json) {
    return ResultPage(
      phishingCount: json["reportCount"],
      isSafe: json["safe"],
      isDangerous: json["dangerous"],
      url: json["url"],
    );
  }

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late Future<ResultPage> futureResultPage;

  @override
  void initState() {
    super.initState();
    futureResultPage = fetchInfo(widget.url);
  }

  Widget nextPagePart({     // 결과부분 아레 페이지 이동 부분.
    required String directionText,
    required String buttonText,
    required Widget nextPage,
  }) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: Text(directionText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20,),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
          decoration: BoxDecoration(
              color: const Color(0xff0069DF),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  blurRadius: 3.0,
                  spreadRadius: 0.0,
                  offset: const Offset(1,2),
                )
              ]
          ),
          child: TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>nextPage));
            },
            child: Text(buttonText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'WhoAreURL',
        home: Scaffold(
          appBar: MainAppBar(
            appBar: AppBar(),
            hasBackButton: true,
            context: context,
            title: '검색결과',
          ),
          body: FutureBuilder<ResultPage>(
            future: futureResultPage,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: Color(0xff0069df),
                    )); // 로딩 중 표시
              } else if (snapshot.hasError) {
                return Text('데이터 가져오기 실패: ${snapshot.error}');
              } else {
                // 데이터 가져오기 성공한 경우
                return buildContent(snapshot.data!);
              }
            },
          ),
          bottomNavigationBar: const MainNavigationBar(),
        )
    );
  }
  Widget buildContent(ResultPage resultPage) {
    return Container(    // 결과 표시창
      color: resultPage.status!.backgroundColor,
      child: ListView(    // 결과 표시 / 하단 안내 메세지와 키워드 분리,
        padding: const EdgeInsets.all(25),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: SizedBox(   // 사이트 주소 표시 부분
              width: 200,
              child: Text(resultPage.url,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.1,
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Container(    // 결과 표시 이모티콘
            alignment: Alignment.center,
            margin: const EdgeInsets.all(40),
            child: Image.asset(resultPage.status!.imogeAddress,
              height: 150, width: 150,
              alignment: Alignment.topCenter,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 40),
            child: Column(
              children: [
                SizedBox(   // 검색결과
                  width: 250,
                  child: Text(resultPage.result,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      height: 1.3,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),   // 안내메세지
                Container(    // 하단 안내 메세지
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  alignment: Alignment.center,
                  child: Text(resultPage.status!.additionalInfo,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)
            ),
            child: nextPagePart(
              directionText: resultPage.status!.directionText,
              buttonText: resultPage.status!.directionButtonText,
              nextPage: resultPage.nextPage!,
            ),
          ),
        ],
      ),
    );
  }
}


