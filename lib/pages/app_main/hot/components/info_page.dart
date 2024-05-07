import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ToggleIconButton.dart';

class InfoPage extends StatelessWidget {
  final String content;
  final bool isFilled; // 初始状态，是否为实心
  final Function(bool)? onToggle; // 点击时的回调函数

  const InfoPage(
      {Key? key, this.isFilled = false, this.onToggle, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('详情')),
      body: Column(
        children: [
          // 构建内容列表项
          _buildContentListTile(content),
          const Row(children: [
            SizedBox(width: 18),
            Icon(Icons.comment_bank_outlined),
            Text('评论'),
            Text('2'),
          ]),
          // 添加一个 ListView 来展示评论
            Expanded(
              child: FutureBuilder<List<String>>(
                future: SharedPreferences.getInstance().then((prefs) {
                  return prefs.getStringList('AIComment') ?? [];
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final comment = snapshot.data![index];
                        return _buildCommentCard(comment, index,context);
                      },
                    );
                  } else {
                    return const Text('暂时还没有评论哦~');
                  }
                },
              ), //行 显示评论icon，文字，数量
            ),
        ],
      ),
    );
  }

  Widget _buildContentListTile(String content) {
    // 尝试解析时间戳和文本内容，但要确保格式正确
    int openBracketIndex = content.indexOf('[');
    int closeBracketIndex = content.indexOf(']');
    if (openBracketIndex != -1 &&
        closeBracketIndex != -1 &&
        closeBracketIndex > openBracketIndex) {
      String dateTime =
          content.substring(openBracketIndex + 1, closeBracketIndex);
      String text = content.substring(closeBracketIndex + 1).trim();
      return ListTile(
        leading: Icon(Icons.person),
        title: Text(text),
        subtitle: Text(dateTime),
        // trailing: Text(dateTime),
      );
    } else {
      // 如果格式不正确，只显示文本内容
      return ListTile(
        title: Text(content),
      );
    }
  }

  Widget _buildCommentCard(String comment, int index,BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              // 这里可以添加头像图片
              backgroundImage: AssetImage('path/to/avatar.png'),
            ),
            title: const Text('用户名'),
            subtitle: Text('2022-01-01 12:34'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ToggleIconButton(
                  icon: Icons.favorite,
                  onChanged: (isActive) {
                    print('Icon button is active: $isActive');
                  },
                ),
                // _heart(),
                // IconButton(
                //   icon: const Icon(Icons.thumb_down),
                //   onPressed: () {},
                // ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(comment),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    // 弹出输入框和评论按钮
                    _showReplyDialog(context);
                  },
                  child: const Text('回复'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget _heart() {
    return IconButton(
      icon: Icon(isFilled ? Icons.favorite : Icons.favorite_border),
      onPressed: () => {
        if (onToggle != null) {onToggle!(isFilled)}
      },
    );
  }

  void _showReplyDialog(BuildContext context) {
    // 使用showDialog来显示弹框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // 返回一个对话框
        return AlertDialog(
          title: Text('回复'),
          content: TextField(
            controller: TextEditingController(),
            decoration: InputDecoration(hintText: '输入你的回复...'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('评论'),
              onPressed: () {
                // 在这里处理评论逻辑
                // 然后...
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
