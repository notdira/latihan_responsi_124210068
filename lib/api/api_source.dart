import 'package:latihankuis_prakpam/constants/Space_Flight_Blog.dart';
import 'package:latihankuis_prakpam/constants/Space_Flight_News.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:latihankuis_prakpam/constants/Space_Flight_Report.dart';

class ApiSource {
  static const _News =
      'https://api.spaceflightnewsapi.net/v4/articles/?format=json';

  static const _Blogs =
      'https://api.spaceflightnewsapi.net/v4/blogs/?format=json';

  static const _Reports =
      'https://api.spaceflightnewsapi.net/v4/reports/?format=json';

  Future<List<Results>> getNews() async {
    final response = await http.get(Uri.parse(_News));

    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['results'] as List;
      print(decodeData);
      return decodeData.map((movie) => Results.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<FlightBlogs>> getBlogs() async {
    final response = await http.get(Uri.parse(_Blogs));

    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['results'] as List;
      print(decodeData);
      return decodeData.map((movie) => FlightBlogs.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<FlightReport>> getReports() async {
    final response = await http.get(Uri.parse(_Reports));

    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['results'] as List;
      print(decodeData);
      return decodeData.map((movie) => FlightReport.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}