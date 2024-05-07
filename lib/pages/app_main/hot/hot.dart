import 'package:flutter/material.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/index.dart';
import './components/editor_page.dart';
import 'components/info_page.dart';

class Hot extends StatefulWidget {
  const Hot({Key? key, this.params}) : super(key: key);
  final dynamic params;

  @override
  State<Hot> createState() => _HotState();
}

class _HotState extends State<Hot> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    LogUtil.d(widget.params);
  }

  // 新增方法用于清除Shared Preferences
  Future<void> _clearSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear(); // 清除所有的键值对
  }

  @override
  void dispose() {
    super.dispose();
    _clearSharedPreferences(); // 添加此行代码来清除Shared Preferences
  }

  // 跳转到编辑页面
  void _navToEditor() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const EditorPage()));
  }

  Future<List<String>> _fetchPublishedContent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? content = prefs.getStringList('publishedContent');
    // 返回一个空列表而不是 null，以避免在 FutureBuilder 中出现 null
    return content ?? [];
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
        // leading: Text(dateTime),
        title: Text(text),
        // subtitle: Text(dateTime),
        trailing: Text(dateTime),
        onTap: () {
          // 跳转到新页面，传递内容数据
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InfoPage(content: content)));
        },
      );
    } else {
      // 如果格式不正确，只显示文本内容
      return ListTile(
        title: Text(content),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('hot页面'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => GFToast.showToast("111", context)),
          IconButton(
              icon: Icon(Icons.notifications_none_sharp),
              onPressed: () => GFToast.showToast("222", context)),
          // 添加一个照相机按钮
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: _navToEditor,
          ),
        ],
      ),
      body: FutureBuilder(
        future: _fetchPublishedContent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // 显示加载指示器
          } else if (snapshot.hasData) {
            final contentList = snapshot.data as List<String>?; // 假定数据是字符串列表
            if (contentList != null && contentList.isNotEmpty) {
              return ListView.builder(
                itemCount: contentList.length,
                itemBuilder: (context, index) {
                  final content = contentList[index];
                  return _buildContentListTile(content);
                },
              );
            } else {
              return Container(
                padding: const EdgeInsets.all(2.0),
                child: const Text('暂无发布内容'),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text('加载发布内容时出错: ${snapshot.error}'),
            );
          } else {
            return Container(
              padding: const EdgeInsets.all(2.0),
              child: const Text('暂无发布内容'),
            );
          }
        },
      ),
    );
  }
}
