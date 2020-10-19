import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:AwwWallpapers/data/set_wallpaper.dart';

class ImageView extends StatefulWidget {
  final String imageURL;
  ImageView({this.imageURL});
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.network(
          widget.imageURL,
          fit: BoxFit.cover,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(right: 8.0),
            width: 48.0,
            height: 48.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              padding: EdgeInsets.symmetric(),
              color: Colors.white,
              onPressed: () async {
                var response =
                    await setWallpaper(context: context, url: widget.imageURL);
                if (response == WallpaperSet.Success) {
                  final snackBar = SnackBar(content: Text('Wallpaper Set'));
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                } else if (response == WallpaperSet.Failed) {
                  final snackBar = SnackBar(content: Text('Wallpaper Not Set'));
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                }
              },
              child: Icon(
                Icons.wallpaper,
                color: Colors.blue,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 8.0),
            width: 48.0,
            height: 48.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              padding: EdgeInsets.symmetric(),
              color: Colors.white,
              onPressed: () async {
                var status = await Permission.storage.request();
                if (status.isGranted) {
                  try {
                    var imageId = await ImageDownloader.downloadImage(
                        widget.imageURL,
                        destination: AndroidDestinationType.directoryPictures);
                    final snackBar = SnackBar(
                      content: Text('Wallpaper Downloaded'),
                      action: SnackBarAction(
                        label: "Open",
                        onPressed: () async {
                          var path = await ImageDownloader.findPath(imageId);
                          ImageDownloader.open(path);
                        },
                      ),
                    );
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  } on PlatformException catch (_) {
                    final snackBar =
                        SnackBar(content: Text('Wallpaper Download Failed'));
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  }
                } else {
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      title: Text("Need access to storage."),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            openAppSettings();
                          },
                          child: Text("Open settings"),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                        )
                      ],
                    ),
                  );
                }
              },
              child: Icon(
                Icons.arrow_circle_down,
                color: Colors.blue,
              ),
            ),
          ),
          Container(
            width: 48.0,
            height: 48.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              padding: EdgeInsets.symmetric(),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
                FocusScope.of(context).unfocus();
              },
              child: Icon(
                Icons.cancel,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
