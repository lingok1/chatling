import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_flexible/pages/app_main/hot/hot.dart';
import 'package:flutter_flexible/pages/app_main/search/components/tabs_page.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key}) : super(key: key);

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles;
  List<String> content = [];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFiles ??= [];
        _imageFiles!.add(image);
      });
    }
  }
  // 跳转到hot页面
  void _onHotPagePressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Hot()));
  }

  void _onPublishPressed() {
   //为空判断
    if (_textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('内容不能为空')));
      return;
    }
    // 保存文本内容
    SharedPreferences.getInstance().then((prefs) {
      // 获取现有列表或创建一个新的
      List<String>? existingContent = prefs.getStringList('publishedContent');
      existingContent ??= [];
      existingContent.add(_textEditingController.text);
      prefs.setStringList('publishedContent', existingContent);
    });

    // 保存图片路径
    if (_imageFiles != null) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setStringList('imagePaths', _imageFiles!.map((e) => e.path).toList());
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('发布成功')));
    _onHotPagePressed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('编辑内容'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _onPublishPressed,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true, // 设置为 true 以允许 ListView 根据内容调整大小
              children: [
                // 使用 TextField 允许多行输入
                Expanded( // 使用 Expanded 来允许 TextField 占据更多空间
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: '输入内容（支持Markdown格式）...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: null,
                  ),
                ),
                // 使用 Markdown 渲染文本
                MarkdownBody(
                  data: _textEditingController.text,
                ),
                // 显示选择的图片
                if (_imageFiles != null)
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _imageFiles!.length,
                      itemBuilder: (context, index) {
                        return Image.file(File(_imageFiles![index].path));
                      },
                    ),
                  ),
              ],
            ),
          ),
          // 底部按钮区域
          BottomAppBar(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.photo_camera),
                  onPressed: _pickImage,
                ),
                const Text('添加图片'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}