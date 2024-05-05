import 'package:flutter/material.dart';
import '../../../utils/index.dart';
// 导入需要的包
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../search/components/aaa.dart';
import './components/info_page.dart';

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

  @override
  void dispose() {
    super.dispose();
  }

  // 跳转到编辑页面
  void _navToEditor() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const EditorPage()));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('hot页面'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          // 添加一个照相机按钮
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: _navToEditor,
          ),
        ],
      ),
      body: ListView(
        children: List.generate(1, (index) {
          return  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   'hot页面',
                //   style: TextStyle(fontSize: 32),
                // ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
