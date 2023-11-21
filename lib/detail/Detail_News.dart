import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/Space_Flight_News.dart';

class DetailNews extends StatefulWidget {
  const DetailNews({super.key, required this.results});

  final Results results;

  @override
  State<DetailNews> createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 350,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    widget.results.imageUrl!,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.results.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.results.summary!,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.results.publishedAt!,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.results.newsSite!,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.results.url!,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _launchInBrowser(
            '${widget.results.url ?? 'https://www.google.com/'}',
          );
        },
        child: Icon(Icons.open_in_browser),
        backgroundColor: Colors.purple,
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    final Uri _url = Uri.parse(url);
    try {
      await launch(_url.toString());
    } catch (e) {
      print('Error launching URL: $_url');
      print('Error details: $e');
      throw Exception('Failed to open link: $_url');
    }
  }
}