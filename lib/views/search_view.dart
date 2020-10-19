import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:AwwWallpapers/data/data.dart';
import 'package:AwwWallpapers/model/wallpaper_model.dart';
import 'package:AwwWallpapers/widgets/brand_name.dart';
import 'package:AwwWallpapers/widgets/grid_builder.dart';

class SearchView extends StatefulWidget {
  final String query;
  SearchView({this.query});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  initState() {
    super.initState();
    t1.text = widget.query;
  }

  TextEditingController t1 = TextEditingController();
  Future<List<WallpaperModel>> getSearchPhotos(String query) async {
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
            onTap: () => {
              Navigator.pop(context),
              FocusScope.of(context).unfocus(),
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          elevation: 0.0,
          title: brandName(),
        ),
        body: Stack(
          children: [
            buildGrid(getSearchPhotos, t1.text),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
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
                        FocusScope.of(context).unfocus(),
                        if (t1.text != '')
                          {
                            setState(() {
                              getSearchPhotos(t1.text);
                            })
                          }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
