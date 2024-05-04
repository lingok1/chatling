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
      home: ChatSearch(),
    );
  }
}

class ChatSearch extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<ChatSearch> with SingleTickerProviderStateMixin {
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
    // 获取用户输入的内容
    String query = _searchController.text.trim();

    // 检查输入是否为空
    if (query.isNotEmpty) {
      // 模拟搜索逻辑，使用dio发送网络请求
      // 请自行处理token和dio初始化
      final dio = Dio();
      // 这里应该是您发送请求的代码，以下代码仅作示例
      final response =
          await dio.post('http://okgo.pro:8000/v1/chat/completions',
              data: {
                // ...构建请求的JSON数据
                "model": "glm4",
                // "conversation_id": "663094b7e9b6f0caae621992",
                "messages": [
                  // ...之前的messages
                  {"role": "user", "content": _searchController.text}
                ],
                "stream": false
              },
              options: Options(headers: {
                "Authorization":
                    "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMzM0NTM5MiwianRpIjoiNGJkNjFkMWYtNWFmNy00YmRiLWE0YjItYThhOTc3ZDM1NGRhIiwidHlwZSI6InJlZnJlc2giLCJzdWIiOiI1YTE2MDFhZTc5NWE0NDYzOWY3MTVlNDc0MDdlZWRkMiIsIm5iZiI6MTcxMzM0NTM5MiwiZXhwIjoxNzI4ODk3MzkyLCJ1aWQiOiI2NWNiOGZkNzFlMjllYTNiNGZlZmY0NDMiLCJ1cGxhdGZvcm0iOiJwYyIsInJvbGVzIjpbInVuYXV0aGVkX3VzZXIiXX0.H26sLOvAIdcRMjr_Yds_WQhcBBHuVrsRzLIshT2-_Kg"
              }) // 替换YOUR_TOKEN为实际的token

              );

      // 添加用户消息到消息列表
      setState(() {
        messages.add({'role': 'user', 'content': _searchController.text});
      });

      // 清空搜索框
      _searchController.clear();

      // 假设我们得到了一个响应消息
      // 这里应该处理真实的响应数据
      // 为了示例，我们直接添加一个模拟的系统消息
      // Future.delayed(Duration(seconds: 1), () {
      //   setState(() {
      //     messages.add({
      //       'role': 'assistant',
      //       'content': 'This is a response from the system.'
      //     });
      //   });
      // });
      // 添加接口想消息到消息列表
      setState(() {
        messages.add({
          'role': 'assistant',
          'content': response.data['choices'][0]['message']['content']
        });
      });
    }
  }

  Widget _buildMessageItem(Map<String, dynamic> message) {
    // 根据消息的角色显示不同的图标
    Widget icon;
    if (message['role'] == 'user') {
      icon = Icon(Icons.person);
    } else if (message['role'] == 'assistant') {
      icon = Icon(Icons.computer);
    } else {
      icon = SizedBox.shrink(); // 如果没有角色，不显示图标
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(message['content']),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageList() {
    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return _buildMessageItem(messages[index]);
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: tabs.map((tab) => Tab(text: tab)).toList(),
      isScrollable: true,
      labelPadding: EdgeInsets.only(left: 12.0),
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.black,
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: tabs.map((tab) {
        return Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                _buildMessageList(),
                // 输入框和发送按钮
                Row(
                  children: [
                    // 清空按钮
                    IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: () {
                        setState(() {
                          messages.clear();
                        });
                      },
                    ),
                    // 搜索框
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
                    // 发送按钮
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
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
