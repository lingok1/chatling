import 'package:flutter/material.dart';
import 'package:flutter_flexible/pages/app_main/search/components/a.dart';
import './components/aaa.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // 创建一个TextEditingController来获取输入框的内容
  final TextEditingController _searchController = TextEditingController();

  // 搜索函数，在这里你可以添加你的搜索逻辑
  void _search() {
    // 使用_searchController.text获取输入框中的内容
    print('搜索内容: ${_searchController.text}');
    // 在这里添加你的搜索逻辑
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search页面'),
        automaticallyImplyLeading: false,
        // 使用actions属性来添加搜索按钮
        actions: [
          // 使用Expanded来使输入框填满AppBar的剩余空间
          Expanded(
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '请输入搜索内容',
                border: InputBorder.none, // 去除下划线
              ),
              onFieldSubmitted: (value) {
                // 当用户提交搜索内容时调用搜索函数
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
      body: Container(
        color: Colors.green,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('搜索内容'),
            AIChatSearch(),
          ],
        ),
      ),
    );
  }
}