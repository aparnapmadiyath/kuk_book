import 'package:flutter/material.dart';

import '../../../core/common/widgets/custom_text_widget.dart';
import '../../../main.dart';

class NewsListingPage extends StatefulWidget {
  const NewsListingPage({super.key});

  @override
  State<NewsListingPage> createState() => _NewsListingPageState();
}

class _NewsListingPageState extends State<NewsListingPage> {
  final List<Map<String, String>> newsList = [
    {
      'title': 'Breaking News: Flutter 3.10 Released!',
      'date': 'Feb 27, 2025',
      'description': 'Flutter 3.10 brings performance improvements and new widgets.',
    },
    {
      'title': 'Tech Giants Invest in AI',
      'date': 'Feb 26, 2025',
      'description': 'Big companies are pushing AI to the next level in 2025. '
          'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
          'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
    },
  ];

  // Track expansion state for each news item
  final Map<int, bool> isExpandedMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const CustomTextWidget(
          text: "Bank Details",
          color: Colors.white,
          weight: FontWeight.w700,
          fontSizeMultiplier: 0.05,
        ),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(w*0.03),
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return NewsCard(
            news: newsList[index],
            isExpanded: isExpandedMap[index] ?? false,
            onExpandToggle: () {
              setState(() {
                isExpandedMap[index] = !(isExpandedMap[index] ?? false);
              });
            },
          );
        },
      ),
    );
  }
}

class NewsCard extends StatefulWidget {
  final Map<String, String> news;
  final bool isExpanded;
  final VoidCallback onExpandToggle;

  const NewsCard({
    Key? key,
    required this.news,
    required this.isExpanded,
    required this.onExpandToggle,
  }) : super(key: key);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool isOverflowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  void _checkOverflow() {
    final textSpan = TextSpan(
      text: widget.news['description'],
      style: TextStyle(),
    );

    final textPainter = TextPainter(
      text: textSpan,
      maxLines: 2,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: w * 0.9);
    setState(() {
      isOverflowing = textPainter.didExceedMaxLines;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: w*0.025),
      child: ListTile(
        contentPadding: EdgeInsets.all(w*0.03),
        title: Text(
          widget.news['title']!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.news['date']!,
              style: TextStyle(fontSize: w*0.033, color: Colors.grey),
            ),
            SizedBox(height: w*0.02),
            SizedBox(
              width: w * 0.9,
              child: Text(
                widget.news['description']!,
                maxLines: widget.isExpanded ? null : 2,
                overflow: widget.isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
            ),
            if (isOverflowing)
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: widget.onExpandToggle,
                  child: Text(
                    widget.isExpanded ? "Read Less" : "Read More",
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
