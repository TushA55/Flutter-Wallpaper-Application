import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:AwwWallpapers/data/data.dart';
import 'package:AwwWallpapers/model/wallpaper_model.dart';
import 'package:AwwWallpapers/widgets/brand_name.dart';
import 'package:AwwWallpapers/widgets/grid_builder.dart';

class CategoryView extends StatefulWidget {
  final String catName;
  CategoryView({this.catName});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  initState() {
    super.initState();
    t1.text = widget.catName;
  }

  TextEditingController t1 = TextEditingController();
  Future<List<WallpaperModel>> getCatPhotos(String query) async {
    List<WallpaperModel> wallpapers = List();

    var response = await http.get(
      "https://api.pexels.com/v1/search?query=$query&per_page=100&page=1",
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          elevation: 0.0,
          title: brandName(),
        ),
        body: Stack(
          children: [
            buildGrid(getCatPhotos, widget.catName),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              color: Colors.white,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: ": ",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: "${widget.catName} ",
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
