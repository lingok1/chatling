import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';

class TabsPage extends StatelessWidget {
  final List<String> tabs = ['kimi', 'qwen', 'ChatGPT', 'gml', 'spark', 'ChatGPT', 'gml'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              isScrollable: true,
              tabs: tabs.map((tab) => Tab(text: tab)).toList(),
            ),
            Expanded(
              child: TabBarView(
                children: tabs.map((tab) => createPage(tab)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createPage(String label) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item $index from tab $label'),
              );
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Type your message here...",
                ),
              ),
            ),
            GFButton(
              onPressed: (){
                Get.snackbar(
                  "Success",
                  "Message sent successfully!",
                  duration: const Duration(seconds: 1),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
              text: "Send",
            ),
          ],
        ),
      ],
    );
  }
}