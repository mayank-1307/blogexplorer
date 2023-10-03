import 'package:flutter/material.dart';

class Model{
  late String id;
  late String image_url;
  late String title;

  Model({this.id="id", this.image_url="url", this.title="title"});

  factory Model.fromMap(Map blog)
  {
    return Model(
      id: blog["id"],
      image_url:blog['image_url'],
      title: blog["title"]
    );
  }

}