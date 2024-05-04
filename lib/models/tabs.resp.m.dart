class TabsResp {
  List<Tabs>? tabs;

  TabsResp({this.tabs});

  TabsResp.fromJson(Map<String, dynamic> json) {
    if (json['tabs'] != null) {
      tabs = <Tabs>[];
      json['tabs'].forEach((v) {
        tabs!.add(new Tabs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tabs != null) {
      data['tabs'] = this.tabs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tabs {
  String? id;
  String? name;

  Tabs({this.id, this.name});

  Tabs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}