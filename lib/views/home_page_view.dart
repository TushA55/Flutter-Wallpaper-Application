import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:AwwWallpapers/data/data.dart';
import 'package:AwwWallpapers/model/categories_model.dart';
import 'package:AwwWallpapers/model/wallpaper_model.dart';
import 'package:AwwWallpapers/views/category_view.dart';
import 'package:AwwWallpapers/widgets/brand_name.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:AwwWallpapers/widgets/grid_builder.dart';
import 'package:AwwWallpapers/views/search_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController t1 = TextEditingController();
  List<CategoriesModel> categories = List();

  Future<List<WallpaperModel>> getCuratedPhotos() async {
    List<WallpaperModel> wallpapers = List();

    var response = await http.get(
      "https://api.pexels.com/v1/curated?per_page=100&page=1",
      headers: {
        "Authorization": apikey,
      },
    );
    var jsonData = json.decode(response.body);
    var data = jsonData["photos"];
    for (var element in data) {
      WallpaperModel model = WallpaperModel(
        photographer: element["photographer"],
        photographerId: element["photographerId"],
        photographerUrl: element["photographerUrl"],
        src: Src(
          original: element["src"]["original"],
          portrait: element["src"]["portrait"],
          small: element["src"]["small"],
        ),
      );
      wallpapers.add(model);
    }
    return wallpapers;
  }

  @override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: brandName(),
        ),
        body: Stack(
          children: [
            buildGrid(getCuratedPhotos, null),
            Container(
              height: 160,
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xfff5f8fd),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      margin: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: t1,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "search wallpapers",
                              ),
                            ),
                          ),
                          InkWell(
                            child: Icon(
                              Icons.search,
                              color: Colors.blue,
                            ),
                            onTap: () => {
                              if (t1.text != '')
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SearchView(
                                        query: t1.text,
                                      ),
                                    ),
                                  ),
                                }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Made By "),
                      Text(
                        "Tushar Ghige",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    height: 65.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CategoriesTile(
                            title: categories[index].categorieName,
                            imageURL: categories[index].imageURL);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String title;
  final String imageURL;

  CategoriesTile({@required this.title, @required this.imageURL});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blue,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryView(
                      catName: title,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1.0, 1.0), //(x,y)
              spreadRadius: 0.0,
              blurRadius: 0.5,
            ),
          ],
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 5.0,
            ),
            ClipOval(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 20.0,
                backgroundImage: NetworkImage(imageURL),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
