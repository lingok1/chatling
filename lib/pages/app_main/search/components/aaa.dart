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
      home: AIChatSearch(),
    );
  }
}

class AIChatSearch extends StatefulWidget {
  @override
   createState() => _ChatSearchState();
}

class _ChatSearchState extends State<AIChatSearch> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final List<String> tabs = ['GLM', 'ChatGPT', 'Qwen', 'Kimi', 'Spark', 'Hailuo'];
  late TabController _tabController;
  // 使用映射来存储每个标签页的消息列表
  final Map<String, List<Map<String, dynamic>>> messagesMap = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    // 初始化每个标签页的消息列表
    for (var tab in tabs) {
      messagesMap[tab] = [];
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _search(String currentTab) async {
    // 获取用户输入的内容
    String query = _searchController.text.trim();

    // 检查输入是否为空
    if (query.isNotEmpty) {

      // 模拟搜索逻辑，使用dio发送网络请求
      // 请自行处理token和dio初始化
      final dio = Dio();
      // 注意：以下代码仅为示例，您需要根据实际情况构建请求
      final response = await dio.post(
        'http://okgo.pro:8000/v1/chat/completions',
        data: {
          "model": currentTab.toLowerCase(), // 使用当前标签作为模型
          "messages": [
            {"role": "user", "content": query}
          ],
          "stream": false
        },
        options: Options(headers: {
          "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMzM0NTM5MiwianRpIjoiNGJkNjFkMWYtNWFmNy00YmRiLWE0YjItYThhOTc3ZDM1NGRhIiwidHlwZSI6InJlZnJlc2giLCJzdWIiOiI1YTE2MDFhZTc5NWE0NDYzOWY3MTVlNDc0MDdlZWRkMiIsIm5iZiI6MTcxMzM0NTM5MiwiZXhwIjoxNzI4ODk3MzkyLCJ1aWQiOiI2NWNiOGZkNzFlMjllYTNiNGZlZmY0NDMiLCJ1cGxhdGZvcm0iOiJwYyIsInJvbGVzIjpbInVuYXV0aGVkX3VzZXIiXX0.H26sLOvAIdcRMjr_Yds_WQhcBBHuVrsRzLIshT2-_Kg"
        }),
      );

      // 添加用户消息到对应标签页的消息列表
      setState(() {
        messagesMap[currentTab]!.add({'role': 'user', 'content': query});
      });
      // 清空搜索框
      _searchController.clear();
      // 添加接口响应消息到对应标签页的消息列表
      setState(() {
        // 假设我们得到了一个响应消息
        messagesMap[currentTab]!.add({
          'role': 'assistant',
          'content': response.data['choices'][0]['message']['content']
        });
      });
      print("_searchGML:${response.data}");

    }
  }

  void _searchKimi(String currentTab) async {
    // 获取用户输入的内容
    String query = _searchController.text.trim();

    // 检查输入是否为空
    if (query.isNotEmpty) {

      // 模拟搜索逻辑，使用dio发送网络请求
      // 请自行处理token和dio初始化
      final dio = Dio();
      // 注意：以下代码仅为示例，您需要根据实际情况构建请求
      final response = await dio.post(
        'http://okgo.pro:8001/v1/chat/completions',
        data: {
          "model": currentTab.toLowerCase(), // 使用当前标签作为模型
          "messages": [
            {"role": "user", "content": query}
          ],
          "stream": false
        },
        options: Options(headers: {
          "Authorization":
          "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1c2VyLWNlbnRlciIsImV4cCI6MTcyMjk0NDQzOCwiaWF0IjoxNzE1MTY4NDM4LCJqdGkiOiJjb3RtOWRpdWw3MjI3dHJyYW5vZyIsInR5cCI6InJlZnJlc2giLCJzdWIiOiJjbjUzNm1nM3IwN2FyZGljaGxvMCIsInNwYWNlX2lkIjoiY241MzZtZzNyMDdhcmRpY2hsbmciLCJhYnN0cmFjdF91c2VyX2lkIjoiY241MzZtZzNyMDdhcmRpY2hsbjAifQ.eeHiu5GpTdTAPrpYjx-QKr7SValVrbi6TiJtrTt1Fdmjv6oE1rs1ZMeI2ava8SxYhG7rFnE076t4WLNykUJsAg"
        }),
      );

      // 添加用户消息到对应标签页的消息列表
      setState(() {
        messagesMap[currentTab]!.add({'role': 'user', 'content': query});
      });
      // 清空搜索框
      _searchController.clear();
      // 添加接口响应消息到对应标签页的消息列表
      setState(() {
        // 假设我们得到了一个响应消息
        messagesMap[currentTab]!.add({
          'role': 'assistant',
          'content': response.data['choices'][0]['message']['content']
        });
      });
      print("_searchGML:${response.data}");

    }
  }

  void _searchQwen(String currentTab) async {
    // 获取用户输入的内容
    String query = _searchController.text.trim();

    // 检查输入是否为空
    if (query.isNotEmpty) {

      // 模拟搜索逻辑，使用dio发送网络请求
      // 请自行处理token和dio初始化
      final dio = Dio();
      // 注意：以下代码仅为示例，您需要根据实际情况构建请求
      final response = await dio.post(
        'http://okgo.pro:8002/v1/chat/completions',
        data: {
          "model": currentTab.toLowerCase(), // 使用当前标签作为模型
          "messages": [
            {"role": "user", "content": query}
          ],
          "stream": false
        },
        options: Options(headers: {
          "Authorization":
          "Bearer 0WmQLT8ZqpuGHwSl9ObH4*7INHqNlCJQZcHlO8ixLpHrMXUaIrrMUaL5WA5msOWQ0"
        }),
      );

      // 添加用户消息到对应标签页的消息列表
      setState(() {
        messagesMap[currentTab]!.add({'role': 'user', 'content': query});
      });
      // 清空搜索框
      _searchController.clear();
      // 添加接口响应消息到对应标签页的消息列表
      setState(() {
        // 假设我们得到了一个响应消息
        messagesMap[currentTab]!.add({
          'role': 'assistant',
          'content': response.data['choices'][0]['message']['content']
        });
      });
      print("_searchGML:${response.data}");

    }
  }



  void _searchSpark(String currentTab) async {
    // 获取用户输入的内容
    String query = _searchController.text.trim();

    // 检查输入是否为空
    if (query.isNotEmpty) {

      // 模拟搜索逻辑，使用dio发送网络请求
      // 请自行处理token和dio初始化
      final dio = Dio();
      // 注意：以下代码仅为示例，您需要根据实际情况构建请求
      final response = await dio.post(
        'http://okgo.pro:8004/v1/chat/completions',
        data: {
          "model": currentTab.toLowerCase(), // 使用当前标签作为模型
          "messages": [
            {"role": "user", "content": query}
          ],
          "stream": false
        },
        options: Options(headers: {
          "Authorization":
          "Bearer e6fa912d-0dfa-415d-afe4-dd0ba95a9541"
        }),
      );

      // 添加用户消息到对应标签页的消息列表
      setState(() {
        messagesMap[currentTab]!.add({'role': 'user', 'content': query});
      });
      // 清空搜索框
      _searchController.clear();
      // 添加接口响应消息到对应标签页的消息列表
      setState(() {
        // 假设我们得到了一个响应消息
        messagesMap[currentTab]!.add({
          'role': 'assistant',
          'content': response.data['choices'][0]['message']['content']
        });
      });
      print("_searchGML:${response.data}");

    }
  }

  void _searchHailuo(String currentTab) async {
    // 获取用户输入的内容
    String query = _searchController.text.trim();

    // 检查输入是否为空
    if (query.isNotEmpty) {

      // 模拟搜索逻辑，使用dio发送网络请求
      // 请自行处理token和dio初始化
      final dio = Dio();
      // 注意：以下代码仅为示例，您需要根据实际情况构建请求
      final response = await dio.post(
        'http://okgo.pro:8003/v1/chat/completions',
        data: {
          "model": currentTab.toLowerCase(), // 使用当前标签作为模型
          "messages": [
            {"role": "user", "content": query}
          ],
          "stream": false
        },
        options: Options(headers: {
          "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTg2MjQ1MjAsInVzZXIiOnsiaWQiOiIyNDE1ODczNzE5ODM2OTU4NzgiLCJuYW1lIjoi5bCP6J665bi9NTg3OCIsImF2YXRhciI6Imh0dHBzOi8vY2RuLnlpbmdzaGktYWkuY29tL3Byb2QvdXNlcl9hdmF0YXIvMTcwNjI2NzcxMTI4Mjc3MDg3Mi0xNzMxOTQ1NzA2Njg5NjU4OTZvdmVyc2l6ZS5wbmciLCJkZXZpY2VJRCI6IjI0NDU3OTQzOTg0MDUzMDQzNyIsImlzQW5vbnltb3VzIjpmYWxzZX19.sh8LBOha4OeQVj46-Z9UrV95UW4vSFMe7TP_dqp169I"
        }),
      );

      // 添加用户消息到对应标签页的消息列表
      setState(() {
        messagesMap[currentTab]!.add({'role': 'user', 'content': query});
      });
      // 清空搜索框
      _searchController.clear();
      // 添加接口响应消息到对应标签页的消息列表
      setState(() {
        // 假设我们得到了一个响应消息
        messagesMap[currentTab]!.add({
          'role': 'assistant',
          'content': response.data['choices'][0]['message']['content']
        });
      });
      print("_searchGML:${response.data}");

    }
  }

  void _searchGPT(String currentTab) async {
    // 获取用户输入的内容
    String query = _searchController.text.trim();

    // 检查输入是否为空
    if (query.isNotEmpty) {

      // 模拟搜索逻辑，使用dio发送网络请求
      // 请自行处理token和dio初始化
      final dio = Dio();
      // 注意：以下代码仅为示例，您需要根据实际情况构建请求
      final response = await dio.post(
        'https://api.chatanywhere.com.cn/v1/chat/completions',
        data: {
          "messages": [
            {"role": "user", "content": query}
          ],
          "temperature": 0.7,
          "stream": false
        },
        options: Options(headers: {
          "Authorization":
          "Bearer sk-fBAAi7ptJU3h839fNIl2SOBHQprJ5IYZ373cS1M178bqzlnF"
        }),
      );

      // 添加用户消息到对应标签页的消息列表
      setState(() {
        messagesMap[currentTab]!.add({'role': 'user', 'content': query});
      });
      // 清空搜索框
      _searchController.clear();
      // 添加接口响应消息到对应标签页的消息列表
      setState(() {
        // 假设我们得到了一个响应消息
        messagesMap[currentTab]!.add({
          'role': 'assistant',
          'content': response.data['choices'][0]['message']['content']
        });
      });
      print("_searchGPT:${response.data}");

    }
  }

  Widget _buildMessageList(String currentTab) {
    return Expanded(
      child: ListView.builder(
        itemCount: messagesMap[currentTab]!.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> message = messagesMap[currentTab]![index];
          // 为用户和助手的消息添加不同的背景颜色
          Color? backgroundColor = message['role'] == 'user' ? Colors.grey[200] : Colors.blue[100];

          // 为消息容器添加圆角和线边框
          BoxDecoration decoration = BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12.0), // 设置圆角大小
            border: Border.all(color: Colors.grey, width: 1.0), // 设置线边框颜色和宽度
          );

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: decoration,
            child: ListTile(
              title: Text(message['content']),
              leading: message['role'] == 'user' ? const Icon(Icons.person) : const Icon(Icons.computer),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: tabs.map((tab) => Tab(text: tab)).toList(),
      isScrollable: true,
      labelPadding: const EdgeInsets.only(left: 12.0),
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
                _buildMessageList(tab),
                // 输入框和发送按钮
                Row(
                  children: [
                    // 清空按钮
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        setState(() {
                          messagesMap[tab]!.clear();
                        });
                      },
                    ),
                    // 搜索框
                    Expanded(
                      child: TextFormField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: '请输入搜索内容',
                          border: InputBorder.none,
                        ),
                        onFieldSubmitted: (value) {
                          if (tab == 'ChatGPT') {
                            _searchGPT(tab);
                          } else {
                            _search(tab);
                          }
                        },
                      ),
                    ),
                    // 发送按钮
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        if (tab == 'ChatGPT') {
                          _searchGPT(tab);
                        } else {
                          _search(tab);
                        }
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
          preferredSize: const Size.fromHeight(kTextTabBarHeight),
          child: _buildTabBar(),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Expanded(
            child: TextFormField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: '请输入搜索内容',
                border: InputBorder.none,
              ),
              onFieldSubmitted: (value) {
                _search(tabs.first);
                _searchGPT(tabs[1].toString());
                _searchQwen(tabs[2].toString());
                _searchKimi(tabs[3].toString());
                _searchSpark(tabs[4].toString());
                _searchHailuo(tabs[5].toString());
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _search(tabs.first);
              _searchGPT(tabs[1].toString());
              _searchQwen(tabs[2].toString());
              _searchKimi(tabs[3].toString());
              _searchSpark(tabs[4].toString());
              _searchHailuo(tabs[5].toString());
            },
          ),
        ],
      ),
      body: _buildTabBarView(),
    );
  }
}
