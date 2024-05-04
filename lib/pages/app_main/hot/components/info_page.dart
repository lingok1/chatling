import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_flexible/pages/app_main/search/components/tabs_page.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key}) : super(key: key);

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFiles ??= [];
        _imageFiles!.add(image);
      });
    }
  }

  void _onPublishPressed() {
    // 这里可以添加发布逻辑
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('发布成功'),duration: const Duration(seconds: 1),));
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
            icon: const Icon(Icons.published_with_changes),
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