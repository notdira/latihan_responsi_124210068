import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/Space_Flight_Report.dart';

class DetailReports extends StatefulWidget {
  const DetailReports({super.key, required this.report});

  final FlightReport report;

  @override
  State<DetailReports> createState() => _DetailReportsState();
}

class _DetailReportsState extends State<DetailReports> {
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
                    widget.report.imageUrl,
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
                            widget.report.title!,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.report.summary!,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.report.publishedAt!,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.report.newsSite!,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.report.url!,
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
            '${widget.report.url}',
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