import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flexible/pages/app_main/hot/hot.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/prompt.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key}) : super(key: key);

  @override
  createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles;
  List<String> content = [];
  static Dio dio = Dio();
  final chatService = ChatService(dio);

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

  Future<void> _onPublishPressed() async {
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
    //评论
    String prompt = "现在你是财神爷，你的朋友发布了一条朋友圈,请你做出评论，简短点不要超过20字。";
    String currentTab = _textEditingController.text;

    String prompt2 = "现在你是道格拉斯·麦克阿瑟，你的朋友发布了一条朋友圈,请你做出评论，简短点不要超过20字。";
    String currentTab2 = _textEditingController.text;
    // 页面跳转
    _onHotPagePressed();
    try {
      String aiResponse = await chatService.sendMessage(prompt, currentTab);
      print(aiResponse);
      String aiResponse2 = await chatService.sendMessage(prompt2, currentTab2);
      print(aiResponse2);
    } catch (e) {
      print('Error: $e');
    }

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
                  SizedBox(
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