import 'package:flutter/material.dart';

import '../api/api_source.dart';
import '../constants/Space_Flight_Blog.dart';
import '../detail/Detail_Blog.dart';


class BlogsFlight extends StatefulWidget {
  const BlogsFlight({super.key});

  @override
  State<BlogsFlight> createState() => _BlogsFlightState();
}

class _BlogsFlightState extends State<BlogsFlight> {
  late Future<List<FlightBlogs>> futureBlogs;

  @override
  void initState() {
    super.initState();
    futureBlogs = ApiSource().getBlogs();
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
              'Space Flight Blogs',
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
                FutureBuilder<List<FlightBlogs>>(
                  future: futureBlogs,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 5,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                              child: InkWell(
                                onTap: () {
                                  //detail blogs
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return DetailBlogs(
                                            flightBlogs: snapshot.data![index]);
                                      }));
                                },
                                child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
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
                                              snapshot.data![index].imageUrl!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data![index].title ??
                                                    'No Title',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Expanded(
                                                child: Text(
                                                  snapshot
                                                      .data![index].summary!,
                                                  maxLines: 3,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
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
                )
              ],
            ),
          ),
        ));
  }
}