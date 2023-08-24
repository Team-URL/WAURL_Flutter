import 'package:flutter/material.dart';
import 'package:who_are_url/mainAppBar.dart';
import 'package:who_are_url/mainNavigationBar.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:who_are_url/mainAppBar.dart';
import 'package:who_are_url/mainNavigationBar.dart';

class JurisdictionInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(appBar: AppBar(), hasBackButton: true, context: context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      '관할서에 도움을 요청하세요 ',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.local_police,
                    color: Color(0xff2EC6F3),
                    size: 20,
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  _buildDepartment(
                    '사이버수사기획과',
                    [
                      '- 사이버수사연구분석계',
                      '- 사이버수사기획계',
                      '- 사이버국제공조협력계',
                    ],
                    [
                      '(02) 3150 - 1759',
                      '(02) 3150 - 2759',
                      '(0 2) 3150 - 0233',
                    ],
                    [
                      ' 사이버수사 정책 종합계획 수립 및 운영 기획, 조직‧인력‧예산‧장비 관리, 법제 총괄',
                      ' 사이버수사 연구 분석, 사이버수사지원시스템 관리, 사이버범죄 일반 예방 및 통계',
                      ' 국제행사 및 회의, 국외출장 등 대외협력 기획, 현장수사관 대상 국제공조 지원',
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildDepartment(
                    '사이버범죄수사과',
                    [
                      '- 사이버범죄수사계',
                      '- 사이버성폭력수사계',
                    ],
                    [
                      '(02) 3150 - 2657',
                      '(02) 3150 - 0238',
                    ],
                    [
                      ' 사이버사기, 사이버금융범죄, 사이버도박, 사이버명예훼손 등에 대한 수사 기획·지휘',
                      ' 디지털 성폭력, 위장수사 관련 수사 기획·지휘',
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildDepartment(
                    '사이버테러대응과',
                    [
                      '- 사이버테러대응계',
                      '- 사이버테러수사대',
                    ],
                    [
                      '(02) 3150 - 0243',
                      '(02) 3150 - 1086',
                    ],
                    [
                      ' 해킹, DDoS 공격, 랜섬웨어 등 사이버테러에 대한 수사 기획·지휘',
                      ' 해킹, DDoS 공격, 랜섬웨어 관련 국가 사이버안보 사건 수사',
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildDepartment(
                    '디지털포렌식센터',
                    [
                      '- 디지털포렌식기획계',
                      '- 디지털포렌식연구개발계',
                      '- 디지털증거획득계',
                      '- 디지털증거분석계',
                    ],
                    [
                      '(02) 3150 - 2711',
                      '(02) 3150 - 1083',
                      '(02) 3150 - 1105',
                      '(02) 3150 - 1104',
                    ],
                    [
                      ' 디지털포렌식 정책 기획 및 관련 법령, 예산, 장비보급 업무',
                      ' 디지털포렌식 기법 연구개발, R&D 등',
                      ' 디지털증거획득기법개발',
                      ' 디지털증거분석기법개발',
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainNavigationBar(),
    );
  }

  Widget _buildDepartment(String title, List<String> divisions, List<String> phoneNumbers, List<String> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff2EC6F3)),
        ),
        SizedBox(height: 8),
        for (int i = 0; i < divisions.length; i++) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Text(
                divisions[i],
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.call,
                    color: Colors.green,
                    size: 12,
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: Text(phoneNumbers[i]),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.task,
                    color: Colors.amberAccent,
                    size: 12,
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      tasks[i],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
          SizedBox(height: 10),
        ],
      ],
    );
  }
}
