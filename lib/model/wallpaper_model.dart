class WallpaperModel {
  String photographer;
  String photographerUrl;
  int photographerId;
  Src src;
  WallpaperModel({
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.src,
  });
}

class Src {
  String original;
  String small;
  String portrait;

  Src({
    this.original,
    this.small,
    this.portrait,
  });
}
