import 'package:flutter/material.dart';

import '../api/api_source.dart';
import '../constants/Space_Flight_News.dart';
import '../detail/Detail_News.dart';


class NewsFlight extends StatefulWidget {
  const NewsFlight({super.key});

  @override
  State<NewsFlight> createState() => _NewsFlightState();
}

class _NewsFlightState extends State<NewsFlight> {
  late Future<List<Results>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = ApiSource().getNews();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Space Flight News',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
          centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<Results>>(
                future: futureNews,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return DetailNews(
                                          results: snapshot.data![index]);
                                    }));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 120,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          snapshot.data![index].imageUrl
                                              .toString(),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index].title,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Expanded(
                                            child: Text(
                                              snapshot.data![index].summary!,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error');
                  }
                  return Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}