import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../constants/Space_Flight_Blog.dart';

class DetailBlogs extends StatefulWidget {
  const DetailBlogs({Key? key, required this.flightBlogs}) : super(key: key);

  final FlightBlogs flightBlogs;

  @override
  State<DetailBlogs> createState() => _DetailBlogsState();
}

class _DetailBlogsState extends State<DetailBlogs> {
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
                    widget.flightBlogs.imageUrl!,
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
                            widget.flightBlogs.title!,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.flightBlogs.summary!,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.flightBlogs.publishedAt!,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.flightBlogs.newsSite!,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.flightBlogs.url!,
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
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _launchInBrowser('${widget.flightBlogs.url}');
        },
        child: const Icon(Icons.open_in_browser),
        backgroundColor: Colors.purple,
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    final Uri _url = Uri.parse(url);
    try {
      await launch(_url.toString());
    } catch (e) {
      throw Exception('Failed to open link: $_url');
    }
  }
}