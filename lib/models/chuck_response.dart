class ChuckResponse {
  List<String> categories;
  String created_at;
  String icon_url;
  String id;
  String updated_at;
  String url;
  String value;

  ChuckResponse(
      {this.categories,
      this.created_at,
      this.icon_url,
      this.id,
      this.updated_at,
      this.url,
      this.value});

  factory ChuckResponse.fromJson(Map<String, dynamic> json) {
    return ChuckResponse(
      categories: json['categories'] != null
          ? new List<String>.from(json['categories'])
          : null,
      created_at: json['created_at'],
      icon_url: json['icon_url'],
      id: json['id'],
      updated_at: json['updated_at'],
      url: json['url'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.created_at;
    data['icon_url'] = this.icon_url;
    data['id'] = this.id;
    data['updated_at'] = this.updated_at;
    data['url'] = this.url;
    data['value'] = this.value;
    if (this.categories != null) {
      data['categories'] = this.categories;
    }
    return data;
  }
}
