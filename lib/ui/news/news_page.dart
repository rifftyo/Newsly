import 'package:flutter/material.dart';
import 'package:news_app/provider/cnn_news_provider.dart';
import 'package:news_app/ui/news/detail_page.dart';
import 'package:news_app/widgets/container_menu.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String _selectedCategory = 'Terbaru';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadNews();
    });
  }

  void _loadNews() {
    Provider.of<CnnNewsProvider>(context, listen: false)
        .fetchListCnn(_selectedCategory);
  }

  void _onMenuTap(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _loadNews();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> menuTitles = [
      'Terbaru',
      'Nasional',
      'Internasional',
      'Ekonomi',
      'Olahraga',
      'Teknologi',
      'Hiburan',
    ];

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Pagi,',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Rifky Tyo',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/news_icon.png',
                    width: 65,
                    height: 65,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 35,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: menuTitles.length,
                itemBuilder: (context, index) {
                  bool isActive = _selectedCategory == menuTitles[index];
                  return Row(
                    children: [
                      const SizedBox(width: 15),
                      containerMenu(menuTitles[index],
                          () => _onMenuTap(menuTitles[index]), isActive),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Consumer<CnnNewsProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.state == ResultState.hasData) {
                    return RefreshIndicator(
                      onRefresh: () => state.fetchListCnn(_selectedCategory),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.result.data.posts.length,
                        itemBuilder: (context, index) {
                          var newsItem = state.result.data.posts[index];
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            leading: Image.network(
                              newsItem.thumbnail,
                              width: 125,
                              fit: BoxFit.fill,
                            ),
                            title: Text(
                              newsItem.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              newsItem.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      news: state.result.data.posts[index]),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  } else if (state.state == ResultState.error) {
                    return Center(
                      child: Material(
                        child: Text(
                          state.message,
                        ),
                      ),
                    );
                  } else if (state.state == ResultState.noData) {
                    return Center(
                      child: Material(
                        child: Text(state.message),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Material(
                        child: Text(''),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
