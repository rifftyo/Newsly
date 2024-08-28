import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/data/model/news_new_cnn.dart';

class ApiService {
  static const String _baseUrl = 'https://api-berita-indonesia.vercel.app/';

  Future<NewsNewCnn> getListNewsNewCnn() async {
    final response = await http.get(Uri.parse("${_baseUrl}cnn/terbaru"));
    if (response.statusCode == 200) {
      return NewsNewCnn.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list News Cnn');
    }
  }

  Future<NewsNewCnn> getListNewsEconomyCnn() async {
    final response = await http.get(Uri.parse("${_baseUrl}cnn/ekonomi"));
    if (response.statusCode == 200) {
      return NewsNewCnn.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list News Cnn');
    }
  }
  
  Future<NewsNewCnn> getListNewsNasionalCnn() async {
    final response = await http.get(Uri.parse("${_baseUrl}cnn/nasional"));
    if (response.statusCode == 200) {
      return NewsNewCnn.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list News Cnn');
    }
  }

  Future<NewsNewCnn> getListNewsInternasionalCnn() async {
    final response = await http.get(Uri.parse("${_baseUrl}cnn/internasional"));
    if (response.statusCode == 200) {
      return NewsNewCnn.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list News Cnn');
    }
  }

  Future<NewsNewCnn> getListNewsSportCnn() async {
    final response = await http.get(Uri.parse("${_baseUrl}cnn/olahraga"));
    if (response.statusCode == 200) {
      return NewsNewCnn.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list News Cnn');
    }
  }

  Future<NewsNewCnn> getListNewsTechnologyCnn() async {
    final response = await http.get(Uri.parse("${_baseUrl}cnn/teknologi"));
    if (response.statusCode == 200) {
      return NewsNewCnn.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list News Cnn');
    }
  }

  Future<NewsNewCnn> getListNewsEntertainCnn() async {
    final response = await http.get(Uri.parse("${_baseUrl}cnn/hiburan"));
    if (response.statusCode == 200) {
      return NewsNewCnn.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list News Cnn');
    }
  }

}