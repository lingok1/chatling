import 'package:flutter/material.dart';
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

  // 提取方法以获取发布内容
  Future<Object> _fetchPublishedContent() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('publishedContent') ?? '';
  }

// 提取方法以构建内容列表项
  ListTile _buildContentListTile(String content) {
    return ListTile(
      title: Text(content),
      onTap: () {
        // 跳转到新页面，传递内容数据
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InfoPage(content: content)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('hot页面'),
        automaticallyImplyLeading: false,
        actions: [
          const IconButton(
            icon: Icon(Icons.search),
            onPressed: null,
          ),
          const IconButton(
            icon: Icon(Icons.notifications_none_sharp),
            onPressed: null,
          ),
// 添加一个照相机按钮
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: _navToEditor,
          ),
        ],
      ),
      body:  FutureBuilder(
        future: _fetchPublishedContent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // 显示加载指示器
          } else if (snapshot.hasData && snapshot.data != null&&snapshot.data!='') {
            final contentList = snapshot.data as List<String>;
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
        },
      ),
    );
  }
}
