import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'WebViewPage.dart';

class HotList {
  int? id;
  int? sort;
  String? name;
  String? sourceKey;
  String? iconColor;
  List<Data>? data;
  String? createTime;

  HotList({
    this.id,
    this.sort,
    this.name,
    this.sourceKey,
    this.iconColor,
    this.data,
    this.createTime,
  });

  factory HotList.fromJson(Map<String, dynamic> json) {
    List<Data>? data =
        (json['data'] as List?)?.map((i) => Data.fromJson(i)).toList();
    return HotList(
      id: json['id'],
      sort: json['sort'],
      name: json['name'],
      sourceKey: json['source_key'],
      iconColor: json['icon_color'],
      data: data,
      createTime: json['create_time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sort'] = this.sort;
    data['name'] = this.name;
    data['source_key'] = this.sourceKey;
    data['icon_color'] = this.iconColor;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['create_time'] = this.createTime;
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? extra;
  String? link;

  Data({this.id, this.title, this.extra, this.link});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      title: json['title'],
      extra: json['extra'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['extra'] = this.extra;
    data['link'] = this.link;
    return data;
  }
}

void main() {
  runApp(HotListPage());
}

class HotListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Hot List')),
        body: FutureBuilder<List<HotList>>(
          future: _fetchHotList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CustomAppBar(hotLists: snapshot.data);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

Future<List<HotList>> _fetchHotList() async {
  try {
    Dio dio = Dio();
    Response response = await dio.get('https://okgo.pro/api/hot/list?type=0');
    if (response.statusCode == 200) {
      // 获取响应数据中的"data"部分
      List<dynamic> dataList = response.data['data'];
      // 将每个数据映射转换为HotList对象
      List<HotList> hotLists =
          dataList.map((item) => HotList.fromJson(item)).toList();
      return hotLists;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}

class CustomAppBar extends StatefulWidget {
  final List<HotList>? hotLists;

  const CustomAppBar({Key? key, this.hotLists}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 创建TabController
    _tabController =
        TabController(length: widget.hotLists!.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          isScrollable: true,
          //设置文字颜色为黑色
          indicatorColor: Colors.black,
          //设置文字大小
          labelStyle: TextStyle(fontSize: 16.0),
          //设置文字颜色为黑色
          labelColor: Colors.black,
          //设置未选中文字颜色为灰色
          unselectedLabelColor: Colors.grey,
          controller: _tabController,
          tabs: widget.hotLists!.map((hotList) {
            return Tab(
              //添加样式
              child: Text(
                hotList.name!,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.hotLists!.map((hotList) {
          return ListView.builder(
            itemCount: hotList.data?.length,
            itemBuilder: (context, index) {
              Data? data = hotList?.data?[index];
              // 检查数据是否为空
              if (data == null) {
                return const ListTile(title: Text('Invalid data'));
              }

              return ListTile(
                title: GestureDetector(
                  onTap: () {
                    // 使用导航器打开WebView页面
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPage(url: data!.link.toString())));
                  },
                  child: Text(data!.title.toString()),
                ),
                subtitle: Text(data.extra.toString()),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
