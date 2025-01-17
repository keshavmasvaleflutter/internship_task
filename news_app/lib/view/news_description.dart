import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsDescription extends StatefulWidget {
  const NewsDescription({super.key});

  @override
  State createState() => _NewsDescriptionState();
}

class _NewsDescriptionState extends State<NewsDescription> {
  String description =
      "From being tagged as a surprise pick in 2017 to becoming the BJP’s obvious choice in 2022, Yogi Adityanath took oath in March 2022 in Lucknow for a second straight term as Chief Minister of UP before a gathering of around 50,000 people \n including Prime Minister Narendra Modi, Union Ministers Amit Shah and Smriti Irani, chief ministers of NDA-ruled states — and former UP Governor Ram Naik, who had administered the oath to Adityanath in 2017."
      "\n From being tagged as a surprise pick in 2017 to becoming the BJP’s obvious choice in 2022, Yogi Adityanath took oath in March 2022 in Lucknow for a second straight term as Chief Minister of UP before a gathering of around 50,000 people\n including Prime Minister Narendra Modi, Union Ministers Amit Shah and Smriti Irani, chief ministers of NDA-ruled states — and former UP Governor Ram Naik, who had administered the oath to Adityanath in 2017."
      "\n From being tagged as a surprise pick in 2017 to becoming the BJP’s obvious choice in 2022, Yogi Adityanath took oath in March 2022 in Lucknow for a second straight term as Chief Minister of UP before a gathering of around 50,000 people\n including Prime Minister Narendra Modi, Union Ministers Amit Shah and Smriti Irani, chief ministers of NDA-ruled states — and former UP Governor Ram Naik, who had administered the oath to Adityanath in 2017.";

  // String description = articles.description!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: newsDescriptionFun(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuLMo9zdfv-6XKBewSTUw2zDDEe1jCm2-aVw&s",
            "Global Summit on Climate Change: Historic Agreement Reached",
            "Politics",
            description,
            "sep 15, 2024",
            context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromRGBO(30, 41, 59, 1.0),
        child: const Icon(
          Icons.share,
          color: Colors.white,
        ),
      ),
    );
  }
}

Widget newsDescriptionFun(String image, String title, String category,
    String description, String timeAndDate, BuildContext context) {
  return Stack(
    children: [
      Image.network(
        image,
        height: MediaQuery.sizeOf(context).height * 0.25,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      Positioned(
        top: MediaQuery.sizeOf(context).height * 0.055,
        left: MediaQuery.sizeOf(context).width * 0.04,
        child: IconButton(
          onPressed: () {
            Get.back();
          },
          style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Colors.black.withOpacity(0.4)),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Colors.pink, width: 1),
              ),
            ),
          ),
          icon: const Icon(Icons.arrow_back),
          color: Colors.pink,
          iconSize: 26,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.26,
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.sizeOf(context).height * 0.005,
              bottom: MediaQuery.sizeOf(context).height * 0.005,
              left: MediaQuery.sizeOf(context).width * 0.035,
              right: MediaQuery.sizeOf(context).width * 0.035,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.03,
                width: MediaQuery.sizeOf(context).width * 0.2,
                margin: EdgeInsets.only(
                    left: MediaQuery.sizeOf(context).width * 0.035,
                    top: MediaQuery.sizeOf(context).width * 0.015),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.pink,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Business",
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  right: MediaQuery.sizeOf(context).width * 0.035,
                  left: MediaQuery.sizeOf(context).width * 0.035,
                ),
                child: Text(
                  timeAndDate,
                  style: const TextStyle(),
                ),
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.only(
                left: MediaQuery.sizeOf(context).width * 0.035,
                right: MediaQuery.sizeOf(context).width * 0.035,
                top: MediaQuery.sizeOf(context).height * 0.015,
                bottom: MediaQuery.sizeOf(context).height * 0.02,
              ),
              child: Text(
                description,
                style: const TextStyle(),
                textAlign: TextAlign.justify,
              )),
        ],
      ),
    ],
  );
}
