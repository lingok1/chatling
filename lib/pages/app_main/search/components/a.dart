import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // 确保已经添加dio依赖

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Example',
      home: Search(),
    );
  }
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final List<String> tabs = ['kimi', 'qwen', 'ChatGPT', 'gml', 'spark', 'qwen'];
  late TabController _tabController;
  List<Map<String, dynamic>> messages = []; // 存储消息列表

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _search() async {
    // 搜索逻辑，使用dio发送网络请求
    // 请自行处理token和dio初始化
    final dio = Dio();
    final response = await dio.post(
        'http://okgo.pro:8000/v1/chat/completions',
        data: {
          // ...构建请求的JSON数据
          "model": "glm4",
          // "conversation_id": "663094b7e9b6f0caae621992",
          "messages": [
            // ...之前的messages
            {
              "role": "user",
              "content": _searchController.text
            }
          ],
          "stream": false
        },
        options: Options(headers: {"Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMzM0NTM5MiwianRpIjoiNGJkNjFkMWYtNWFmNy00YmRiLWE0YjItYThhOTc3ZDM1NGRhIiwidHlwZSI6InJlZnJlc2giLCJzdWIiOiI1YTE2MDFhZTc5NWE0NDYzOWY3MTVlNDc0MDdlZWRkMiIsIm5iZiI6MTcxMzM0NTM5MiwiZXhwIjoxNzI4ODk3MzkyLCJ1aWQiOiI2NWNiOGZkNzFlMjllYTNiNGZlZmY0NDMiLCJ1cGxhdGZvcm0iOiJwYyIsInJvbGVzIjpbInVuYXV0aGVkX3VzZXIiXX0.H26sLOvAIdcRMjr_Yds_WQhcBBHuVrsRzLIshT2-_Kg"}) // 替换YOUR_TOKEN为实际的token

    );

    // 处理响应
    // 这里仅是示例，实际中你需要根据业务逻辑处理响应数据
    // 并更新对应Tab页面的状态
    print(response.data);
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: tabs.map((tab) => Tab(text: tab)).toList(),
      isScrollable: true,
      labelPadding: EdgeInsets.only(left: 12.0),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: tabs.map((tab) {
        return Container(
          color: Colors.grey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 显示消息内容的滚动组件
                Expanded(
                  child: SingleChildScrollView(
                      child:null // 这里放置消息内容的Widget
                  ),
                ),
                // 输入框和发送按钮
                Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                          // controller: _searchController,
                          decoration: InputDecoration(
                            hintText: '请输入搜索内容',
                            hintStyle: TextStyle(color: Colors.grey), // 提示文本样式
                            fillColor: Colors.white, // 输入框背景颜色
                            filled: true, // 是否填充输入框背景
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // 输入框内边距
                            border: OutlineInputBorder( // 边框样式
                              borderRadius: BorderRadius.circular(30.0), // 边框圆角
                              borderSide: BorderSide.none, // 去除边框线
                            ),
                            focusedBorder: OutlineInputBorder( // 聚焦时的边框样式
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Colors.blue, width: 2.0), // 聚焦时边框颜色和宽度
                            ),
                            enabledBorder: OutlineInputBorder( // 非聚焦时的边框样式
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Colors.grey, width: 1.0), // 非聚焦时边框颜色和宽度
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            _search();
                          },
                        ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        // 发送按钮逻辑，调用搜索函数
                        _search();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search页面'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kTextTabBarHeight),
          child: _buildTabBar(),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Expanded(
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '请输入搜索内容',
                border: InputBorder.none,
              ),
              onFieldSubmitted: (value) {
                _search();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _search,
          ),
        ],
      ),
      body: _buildTabBarView(),
    );
  }
}