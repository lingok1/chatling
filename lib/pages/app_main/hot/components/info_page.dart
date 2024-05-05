import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoPage extends StatelessWidget {
  final String content;

  const InfoPage({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('详情')),
      body: Column(
        children: [
          // 展示发布的内容
          MarkdownBody(data: content),
          // 添加一个 ListView 来展示评论
          FutureBuilder<List<String>>(
            future: SharedPreferences.getInstance().then((prefs) {
              return prefs.getStringList('AIComment') ?? [];
            }),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final comment = snapshot.data![index];
                      return ListTile(
                        title: Text(comment),
                        // 您可以添加更多 ListTile 行来显示评论的详细信息
                      );
                    },
                  ),
                );
              } else {
                return const Text('暂时还没有评论哦~');
              }
            },
          ),
        ],
      ),
    );
  }
}