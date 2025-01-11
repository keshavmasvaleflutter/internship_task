import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  final dynamic movie;

  const DetailsScreen({super.key, required this.movie});

  Future<void> _launchUrl(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Error","Could not open $url",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // final name = movie['name'] ?? {};
    final schedule = movie['schedule'] ?? {};
    final network = movie['network'] ?? {};
    final country = network['country'] ?? {};
    final rating = movie['rating'] ?? {};
    final externals = movie['externals'] ?? {};
    final links = movie['_links'] ?? {};

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          movie['name'] ?? 'No Title',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              movie['image']?['original'] ?? '',
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Text(
                  'Failed to load image',
                  style: TextStyle(color: Colors.red),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(screenHeight*0.01),
              child: Row(
                children: [
                  Text(
                    movie['name'] ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                  SizedBox(
                    width: screenWidth*0.30,
                  ),
                  Text(
                    '${movie['language'] ?? 'N/A'}',
                    style: TextStyle(fontSize: 22),
                    softWrap: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
              child: Text(
                movie['summary']?.replaceAll(RegExp('<[^>]*>'), '') ??
                    'No Summary',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Text(
                'Official Site:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
              child: GestureDetector(
                onTap: () {
                  final url = movie['officialSite'];
                  if (url != null) {
                    _launchUrl(url, context);
                  }
                },
                child: Text(
                  movie['officialSite'] ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12,3,0,0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        'Type: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                            softWrap: true,
                      ),
                      Text(
                        '${movie['type'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        softWrap: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: screenWidth*0.15,
                  ),
                  Row(
                    children: [
                      Text(
                        'Language: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${movie['language'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 0, 0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        'Genres: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${movie['genres']?.join(', ') ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: screenWidth*0.01,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15,8,0,0),
              child: Row(
                      children: [
                        Text(
                          'Status: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${movie['status'] ?? 'N/A'}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 0, 0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        'Premiered: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${movie['premiered'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: screenWidth*0.08,
                  ),
                  Row(
                    children: [
                      Text(
                        'Runtime: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${movie['runtime'] ?? 'N/A'} mins',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        'IMDb: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${externals['imdb'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: screenWidth*0.3,
                  ),
                  Row(
                    children: [
                      Text(
                        'Rating: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${rating['average'] ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                      'Network: ',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 200.0,
                        ),
                        child: Text(
                          '${network['name'] ?? 'N/A'} (${country['name'] ?? ''})',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
              child: Row(
                children: [
                  Text(
                    'Schedule: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${schedule['days']?.join(', ') ?? 'N/A'} at ${schedule['time'] ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
              child: Row(
                children: [
                  Text(
                    'Next Episode: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${links['nextepisode']?['name'] ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
              child: Expanded(
                child: Row(
                  children: [
                    Text(
                      'Previous Episode: ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.5, // 80% of screen width
                      ),
                      child: Text(
                        '${links['previousepisode']?['name'] ?? 'N/A'}',
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
