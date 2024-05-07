class HotList {
  int? id;
  int? sort;
  String? name;
  String? sourceKey;
  String? iconColor;
  List<Data>? data;
  String? createTime;

  HotList(
      {this.id,
      this.sort,
      this.name,
      this.sourceKey,
      this.iconColor,
      this.data,
      this.createTime});

  HotList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sort = json['sort'];
    name = json['name'];
    sourceKey = json['source_key'];
    iconColor = json['icon_color'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    createTime = json['create_time'];
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

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    extra = json['extra'];
    link = json['link'];
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
