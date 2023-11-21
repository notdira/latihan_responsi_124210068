import 'package:flutter/material.dart';

import 'Blogs.dart';
import 'News.dart';
import 'Reports.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}





class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Space Flight News',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // Jumlah kolom dalam grid

          ),
          itemCount: 3, // Jumlah item dalam grid
          itemBuilder: (context, index) {
            return buildCard(
              title: index == 0 ? 'NEWS' : (index == 1 ? 'BLOGS' : 'REPORTS'),
              description: getDescription(index),
              imageUrl: getImageUrl(index),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return getDestinationWidget(index);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String getDescription(int index) {
    switch (index) {
      case 0:
        return 'Get an overview of the latest Spaceflight news, from various sources! Easily link your users to the right websites';
      case 1:
        return 'Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast';
      case 2:
        return 'Space stations and other missions often publish their data. With SNAPI, you can include it in your app as well!';
      default:
        return '';
    }
  }

  String getImageUrl(int index) {
    switch (index) {
      case 0:
        return 'https://img.freepik.com/premium-vector/news-reporter-flat-design-illustration_188398-119.jpg?w=900';
      case 1:
        return 'https://img.freepik.com/free-vector/organic-flat-blog-post-illustration-with-people_23-2148955260.jpg?w=900&t=st=1700570852~exp=1700571452~hmac=417043ab683f4d490bf59d7a46b74fb6be1f279e1bf089f2130a8fc37943e75b';
      case 2:
        return 'https://img.freepik.com/premium-vector/teachers-students-are-studying-training_18660-98.jpg';
      default:
        return '';
    }
  }

  Widget getDestinationWidget(int index) {
    switch (index) {
      case 0:
        return const NewsFlight();
      case 1:
        return const BlogsFlight();
      case 2:
        return const FlightReports();
      default:
        return Container();
    }
  }

  Widget buildCard({
    required String title,
    required String description,
    String? imageUrl,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Image.network(
                  imageUrl!,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


