import 'package:flutter/material.dart';

// api 연동위한 import.
import 'package:http/http.dart' as http;
import 'package:who_are_url/mainAppBar.dart';
import 'dart:async';
import 'dart:convert';

import 'package:who_are_url/mainNavigationBar.dart';

class UnknownPage {
  final String id;
  final String url;
  final int reportCount;

  UnknownPage({
    required this.id,
    required this.url,
    required this.reportCount,
  });
}

class RankingPage extends StatelessWidget {
  final List<UnknownPage> exampleList = [
    UnknownPage(
      id: 'asdfadf',
      url: 'www.dangeroussite.com',
      reportCount: 51151,
    ),
    UnknownPage(
      id: 'asdfadf',
      url: 'www.upsetsite.com',
      reportCount: 21451,
    ),
    UnknownPage(
      id: 'asdfadf',
      url: 'www.badguysite.com',
      reportCount: 12523,
    ),
    UnknownPage(
      id: 'asdfadf',
      url: 'www.parisphishing.com',
      reportCount: 9111,
    ),
    UnknownPage(
      id: 'asdfadf',
      url: 'www.ohmyphishing.com',
      reportCount: 7109,
    ),
    UnknownPage(
      id: 'asdfadf',
      url: 'www.dangeroussite.com',
      reportCount: 4105,
    ),
    UnknownPage(
      id: 'asdfadf',
      url: 'www.upsetsite.com',
      reportCount: 2102,
    ),
    UnknownPage(
      id: 'asdfadf',
      url: 'www.badguysite.com',
      reportCount: 2100,
    ),
    UnknownPage(
      id: 'asdfadf',
      url: 'www.parisphishing.com',
      reportCount: 1898,
    ),
    UnknownPage(id: 'asdfadf', url: 'www.ohmyphishing.com', reportCount: 84),
    UnknownPage(
      id: 'asdfadf',
      url: 'www.dangeroussite.com',
      reportCount: 1751,
    ),
    UnknownPage(
      id: 'asdfadf',
      url: 'www.upsetsite.com',
      reportCount: 1621,
    ),
    UnknownPage(
      id: 'asdfadf',
      url: 'www.badguysite.com',
      reportCount: 912,
    ),
    UnknownPage(
      id: 'asdfadf',
      url: 'www.parisphishing.com',
      reportCount: 811,
    ),
    UnknownPage(
      id: 'asdfadf',
      url: 'www.ohmyphishing.com',
      reportCount: 374,
    ),
  ];
  Color rankingColor = const Color(0xff0069df);

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
                  child: DataTable(
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
                    rows: _makeRankingTable(list: exampleList),
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: const MainNavigationBar(),
        ));
  }
}
