import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_bytes/models/category_model.dart';
import 'package:news_bytes/singeltons/selectedcategory.dart';
import 'package:news_bytes/Screens/categories_types.dart';

class CategoryList{

  List<dynamic> categoryDynamic=[];
  List<CategoryModel> categoryListFinal = [];
  String _title;
  String _url;
  String _urlImage;
  String _date;
  String _publishedDate;
  String _source;


  Future<List> getCategoryList() async {
    var response = await http.get(Uri.parse(''
        'https://newsapi.org/v2/top-headlines?country=us&category='+appData.text+'&apiKey=c1a2aaa4e01e40d7bd72abc472528dc1'));
    Map body = await jsonDecode(response.body);
    categoryDynamic= body["articles"];
    print(categoryDynamic.length);

    for(int i=0;i< categoryDynamic.length;i++){

      _title = categoryDynamic[i]["title"].toString();
      _url = categoryDynamic[i]["url"].toString();
      _urlImage=categoryDynamic[i]["urlToImage"].toString();
      _date=categoryDynamic[i]["publishedAt"];
      _source = categoryDynamic[i]["source"]["name"].toString();
      _publishedDate = _date.substring(0,10);

      categoryListFinal.add(CategoryModel(_title,_url,_urlImage,_publishedDate,_source));
    }

    return categoryListFinal;

  }
  
  
  
  
}