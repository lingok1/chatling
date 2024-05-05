// 新页面的代码
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class InfoPage extends StatelessWidget {
  final String content;

  const InfoPage({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('详情')),
      body: Column(
        children: [
          // 展示发布的内容
          MarkdownBody(data: content),
          // 添加一个 ListView 来展示评论
          // ... 评论列表代码
        ],
      ),
    );
  }
}