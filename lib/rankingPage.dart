import 'package:flutter/material.dart';
import 'package:who_are_url/mainAppBar.dart';
// api 연동위한 import.
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:who_are_url/mainNavigationBar.dart';

Future<List<UnknownPage>> fetchInfo() async {
  var url = Uri.http('13.124.151.213:8080', '/result/chart');
  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
  });

  if (response.statusCode == 200) {
    //만약 서버가 ok응답을 반환하면, json을 파싱합니다
    print('응답했다');
    print(json.decode(response.body));
    List<dynamic> body = json.decode(response.body);
    List<UnknownPage> chart =
    body.map((dynamic item) => UnknownPage.fromJson(item)).toList();

    return chart;
  } else {
    //만약 응답이 ok가 아니면 에러를 던집니다.
    throw Exception('API를 불러오는데 실패했습니다');
  }
}

class UnknownPage {
  final String url;
  final int reportCount;

  UnknownPage({
    required this.url,
    required this.reportCount,
  });

  factory UnknownPage.fromJson(Map<String, dynamic> json) {
    return UnknownPage(
      url: json["url"],
      reportCount: json["reportCount"],
    );
  }
}

class RankingPage extends StatefulWidget {
  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  late Future<List<UnknownPage>> futureResultPage;

  @override
  void initState() {
    super.initState();
    futureResultPage = fetchInfo();
  }

  Color rankingColor = const Color(0xff6BE9CB);

  DataRow _rankingElem({
    required Color rankingColor,
    required int ranking,
    required String url,
    required int reportCount,
  }) =>
      DataRow(cells: [
        DataCell(Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.fromLTRB(0, 15, 5, 15),
          decoration: BoxDecoration(
            color: rankingColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            '$ranking',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              height: 1,
            ),
          ),
        )),
        DataCell(Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            url,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              height: 1,
            ),
          ),
        )),
        DataCell( Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(10),
          child: Text(
            '$reportCount 건',
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: Color(0xff0069df),
              fontWeight: FontWeight.w700,
              fontSize: 12,
              height: 1,
            ),
          ),
        )),
      ]);

  List<DataRow> _makeRankingTable({
    required List<UnknownPage> list,
  }) {
    List<DataRow> phishingList = [];
    for (int i = 0; i < list.length; i++) {
      phishingList.add(_rankingElem(
        rankingColor: rankingColor,
        ranking: i + 1,
        url: list[i].url,
        reportCount: list[i].reportCount,
      ));
    }

    return phishingList;
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
          ),
          body: Column(
            children: [
              Container(
                // 상단 버튼 부분.
                margin: const EdgeInsets.all(15),
                alignment: Alignment.center,
                height: 35,
                child: const Text(
                  '이런 사이트가 많이 신고되었어요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: SingleChildScrollView(
                  child: FutureBuilder<List<UnknownPage>>(
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
                ),
              )
            ],
          ),
          bottomNavigationBar: const MainNavigationBar(),
        ));
  }

  Widget buildContent(List<UnknownPage> list) {
    return DataTable(
      showBottomBorder: true,
      headingRowHeight: 0,
      dataRowHeight: 65,
      dividerThickness: 2,
      horizontalMargin: 0,
      columnSpacing: 5,
      columns: const <DataColumn>[
        DataColumn(label: Text('순위')),
        DataColumn(label: Text('사이트 주소')),
        DataColumn(label: Text('신고횟수')),
      ],
      rows: _makeRankingTable(list: list),
    );
  }
}
