import 'package:flutter/material.dart';
import 'package:AwwWallpapers/views/image_view.dart';

Widget buildGrid(Function func, String query) {
  return FutureBuilder(
    future: query == null ? func() : func(query),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        return Padding(
          padding: query == null
              ? const EdgeInsets.only(top: 200.0)
              : const EdgeInsets.only(top: 100.0),
          child: GridView.builder(
              clipBehavior: Clip.none,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: snapshot.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.6,
                crossAxisCount: 2,
                crossAxisSpacing: 6.0,
                mainAxisSpacing: 6.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GridTile(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: InkWell(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => ImageView(
                                      imageURL:
                                          snapshot.data[index].src.portrait,
                                    )))
                      },
                      child: Hero(
                        tag: snapshot.data[index].src.portrait,
                        child: Image.network(
                          snapshot.data[index].src.portrait,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}
