import 'package:flutter/material.dart';
import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/data/model/news_new_cnn.dart';

enum ResultState { loading, noData, hasData, error }

class CnnNewsProvider extends ChangeNotifier {
  final ApiService apiService;

  CnnNewsProvider({required this.apiService});

  final Map<String, NewsNewCnn> _cacheNews = {};
  late NewsNewCnn _newsList;
  ResultState _state = ResultState.noData;
  String _message = '';

  String get message => _message;

  ResultState get state => _state;

  NewsNewCnn get result => _newsList;

  Future<dynamic> fetchListCnn(String category) async {
    try {
      if (_cacheNews.containsKey(category)) {
        _newsList = _cacheNews[category]!;
        _state = ResultState.hasData;
        notifyListeners();
        return _newsList;
      } else {
        _state = ResultState.loading;
        notifyListeners();
        final NewsNewCnn newsData;

        switch (category) {
          case 'Ekonomi':
            newsData = await apiService.getListNewsEconomyCnn();
            break;
          case 'Nasional':
            newsData = await apiService.getListNewsNasionalCnn();
            break;
          case 'Internasional':
            newsData = await apiService.getListNewsInternasionalCnn();
            break;
          case 'Olahraga':
            newsData = await apiService.getListNewsSportCnn();
            break;
          case 'Teknologi':
            newsData = await apiService.getListNewsTechnologyCnn();
            break;
          case 'Hiburan':
            newsData = await apiService.getListNewsEntertainCnn();
            break;
          default:
            newsData = await apiService.getListNewsNewCnn();
            break;
        }

        if (newsData.data.posts.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = ResultState.hasData;
          _newsList = newsData;
          _cacheNews[category] = newsData;
          notifyListeners();
          return _newsList;
        }
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
