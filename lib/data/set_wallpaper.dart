import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

enum WallpaperSet { Success, Failed }

enum SetWallpaperAs { Home, Lock, Both }

const _setAs = {
  SetWallpaperAs.Home: WallpaperManager.HOME_SCREEN,
  SetWallpaperAs.Lock: WallpaperManager.LOCK_SCREEN,
  SetWallpaperAs.Both: WallpaperManager.BOTH_SCREENS,
};

Future<WallpaperSet> setWallpaper({BuildContext context, String url}) async {
  var actionSheet = CupertinoActionSheet(
    title: Text("Set as"),
    actions: [
      CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context).pop(SetWallpaperAs.Home),
        child: Text("Home Screen"),
      ),
      CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context).pop(SetWallpaperAs.Lock),
        child: Text("Lock Screen"),
      ),
      CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context).pop(SetWallpaperAs.Both),
        child: Text("Both"),
      ),
    ],
  );

  var option = await showCupertinoModalPopup(
      context: context, builder: (context) => actionSheet);

  if (option != null) {
    var cachedImage = await DefaultCacheManager().getSingleFile(url);
    if (cachedImage != null) {
      var result = await WallpaperManager.setWallpaperFromFile(
          cachedImage.path, _setAs[option]);
      if (result != 'Wallpaper set') {
        return WallpaperSet.Failed;
      }
    }
  }
  return WallpaperSet.Success;
}
