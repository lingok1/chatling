import 'package:dio/dio.dart';

class Message {
  final String role;
  final String content;

  Message({required this.role, required this.content});

  Map<String, dynamic> toJson() {
    return {'role': role, 'content': content};
  }
}
void _searchCSY(String currentTab) async {
  // 检查输入是否为空
  if (currentTab.isNotEmpty) {
    // 模拟搜索逻辑，使用dio发送网络请求
    // 请自行处理token和dio初始化
    final dio = Dio();
    // 注意：以下代码仅为示例，您需要根据实际情况构建请求
    // 创建一个初始的 messages 列表
    String prompt = "现在你是财神爷，你的朋友发布了一条朋友圈，$currentTab请你做出评论，简短点不要超过20字。";
    final messages = <Message>[
      Message(role: 'system', content: prompt),
    ];
    messages.add(Message(role: 'user', content: currentTab));

    // 发送请求
    final response = await dio.post(
      'http://okgo.pro:8000/v1/chat/completions',
      data: {
        "model": "glm4", // 使用当前标签作为模型
        "messages": [
          messages.map((msg) => msg.toJson()).toList(),
        ],
        "stream": false
      },
      options: Options(headers: {
        "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMzM0NTM5MiwianRpIjoiNGJkNjFkMWYtNWFmNy00YmRiLWE0YjItYThhOTc3ZDM1NGRhIiwidHlwZSI6InJlZnJlc2giLCJzdWIiOiI1YTE2MDFhZTc5NWE0NDYzOWY3MTVlNDc0MDdlZWRkMiIsIm5iZiI6MTcxMzM0NTM5MiwiZXhwIjoxNzI4ODk3MzkyLCJ1aWQiOiI2NWNiOGZkNzFlMjllYTNiNGZlZmY0NDMiLCJ1cGxhdGZvcm0iOiJwYyIsInJvbGVzIjpbInVuYXV0aGVkX3VzZXIiXX0.H26sLOvAIdcRMjr_Yds_WQhcBBHuVrsRzLIshT2-_Kg"
      }),
    );

    // 添加用户消息到对应标签页的消息列表
    // setState(() {
    //   messagesMap[currentTab]!.add({'role': 'user', 'content': currentTab});
    // });

    print("_searchLYY:" + response.data.toString());
  }
}

void _searchYL(String currentTab) async {
  // 检查输入是否为空
  if (currentTab.isNotEmpty) {
    // 模拟搜索逻辑，使用dio发送网络请求
    // 请自行处理token和dio初始化
    final dio = Dio();
    // 注意：以下代码仅为示例，您需要根据实际情况构建请求
    // 创建一个初始的 messages 列表
    String prompt = "现在你是月老，你的朋友发布了一条朋友圈，$currentTab请你做出评论，简短点不要超过20字。";
    final messages = <Message>[
      Message(role: 'system', content: prompt),
    ];
    messages.add(Message(role: 'user', content: currentTab));

    // 发送请求
    final response = await dio.post(
      'http://okgo.pro:8000/v1/chat/completions',
      data: {
        "model": "glm4", // 使用当前标签作为模型
        "messages": [
          messages.map((msg) => msg.toJson()).toList(),
        ],
        "stream": false
      },
      options: Options(headers: {
        "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMzM0NTM5MiwianRpIjoiNGJkNjFkMWYtNWFmNy00YmRiLWE0YjItYThhOTc3ZDM1NGRhIiwidHlwZSI6InJlZnJlc2giLCJzdWIiOiI1YTE2MDFhZTc5NWE0NDYzOWY3MTVlNDc0MDdlZWRkMiIsIm5iZiI6MTcxMzM0NTM5MiwiZXhwIjoxNzI4ODk3MzkyLCJ1aWQiOiI2NWNiOGZkNzFlMjllYTNiNGZlZmY0NDMiLCJ1cGxhdGZvcm0iOiJwYyIsInJvbGVzIjpbInVuYXV0aGVkX3VzZXIiXX0.H26sLOvAIdcRMjr_Yds_WQhcBBHuVrsRzLIshT2-_Kg"
      }),
    );

    // 添加用户消息到对应标签页的消息列表
    // setState(() {
    //   messagesMap[currentTab]!.add({'role': 'user', 'content': currentTab});
    // });

    print("_searchLYY:" + response.data.toString());
  }
}

void _searchLYY(String currentTab) async {
  // 检查输入是否为空
  if (currentTab.isNotEmpty) {
    // 模拟搜索逻辑，使用dio发送网络请求
    // 请自行处理token和dio初始化
    final dio = Dio();
    // 注意：以下代码仅为示例，您需要根据实际情况构建请求
    // 创建一个初始的 messages 列表
    String prompt =
        "现在你是动画片中的懒洋洋，你的朋友喜洋洋发布了一条朋友圈，$currentTab请你做出评论，简短点不要超过20字。";
    final messages = <Message>[
      Message(role: 'system', content: prompt),
    ];
    messages.add(Message(role: 'user', content: currentTab));

    // 发送请求
    final response = await dio.post(
      'http://okgo.pro:8000/v1/chat/completions',
      data: {
        "model": "glm4", // 使用当前标签作为模型
        "messages": [
          messages.map((msg) => msg.toJson()).toList(),
        ],
        "stream": false
      },
      options: Options(headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMzM0NTM5MiwianRpIjoiNGJkNjFkMWYtNWFmNy00YmRiLWE0YjItYThhOTc3ZDM1NGRhIiwidHlwZSI6InJlZnJlc2giLCJzdWIiOiI1YTE2MDFhZTc5NWE0NDYzOWY3MTVlNDc0MDdlZWRkMiIsIm5iZiI6MTcxMzM0NTM5MiwiZXhwIjoxNzI4ODk3MzkyLCJ1aWQiOiI2NWNiOGZkNzFlMjllYTNiNGZlZmY0NDMiLCJ1cGxhdGZvcm0iOiJwYyIsInJvbGVzIjpbInVuYXV0aGVkX3VzZXIiXX0.H26sLOvAIdcRMjr_Yds_WQhcBBHuVrsRzLIshT2-_Kg"
      }),
    );

    // 添加用户消息到对应标签页的消息列表
    // setState(() {
    //   messagesMap[currentTab]!.add({'role': 'user', 'content': currentTab});
    // });

    print("_searchLYY:" + response.data.toString());
  }
}

void _searchMKAS(String currentTab) async {
  // 检查输入是否为空
  if (currentTab.isNotEmpty) {
    // 模拟搜索逻辑，使用dio发送网络请求
    // 请自行处理token和dio初始化
    final dio = Dio();
    // 注意：以下代码仅为示例，您需要根据实际情况构建请求
    // 创建一个初始的 messages 列表
    String prompt = "现在你是道格拉斯·麦克阿瑟，你的朋友发布了一条朋友圈，$currentTab请你做出评论，简短点不要超过20字。";
    final messages = <Message>[
      Message(role: 'system', content: prompt),
    ];
    messages.add(Message(role: 'user', content: currentTab));

    // 发送请求
    final response = await dio.post(
      'http://okgo.pro:8000/v1/chat/completions',
      data: {
        "model": "glm4", // 使用当前标签作为模型
        "messages": [
          messages.map((msg) => msg.toJson()).toList(),
        ],
        "stream": false
      },
      options: Options(headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxMzM0NTM5MiwianRpIjoiNGJkNjFkMWYtNWFmNy00YmRiLWE0YjItYThhOTc3ZDM1NGRhIiwidHlwZSI6InJlZnJlc2giLCJzdWIiOiI1YTE2MDFhZTc5NWE0NDYzOWY3MTVlNDc0MDdlZWRkMiIsIm5iZiI6MTcxMzM0NTM5MiwiZXhwIjoxNzI4ODk3MzkyLCJ1aWQiOiI2NWNiOGZkNzFlMjllYTNiNGZlZmY0NDMiLCJ1cGxhdGZvcm0iOiJwYyIsInJvbGVzIjpbInVuYXV0aGVkX3VzZXIiXX0.H26sLOvAIdcRMjr_Yds_WQhcBBHuVrsRzLIshT2-_Kg"
      }),
    );

    // 添加用户消息到对应标签页的消息列表
    // setState(() {
    //   messagesMap[currentTab]!.add({'role': 'user', 'content': currentTab});
    // });

    print("_searchLYY:" + response.data.toString());
  }
}
