// To parse this JSON data, do
//
//     final paginationModel = paginationModelFromJson(jsonString);

import 'dart:convert';

List<PaginationModel> paginationModelFromJson(String str) => List<PaginationModel>.from(json.decode(str).map((x) => PaginationModel.fromJson(x)));

String paginationModelToJson(List<PaginationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaginationModel {
    PaginationModel({
        this.id,
        this.author,
        this.width,
        this.height,
        this.url,
        this.downloadUrl,
    });

    String? id;
    String? author;
    int? width;
    int? height;
    String? url;
    String? downloadUrl;

    factory PaginationModel.fromJson(Map<String, dynamic> json) => PaginationModel(
        id: json["id"],
        author: json["author"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        downloadUrl: json["download_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "width": width,
        "height": height,
        "url": url,
        "download_url": downloadUrl,
    };
}
