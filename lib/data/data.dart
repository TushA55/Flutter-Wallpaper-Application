import 'package:AwwWallpapers/model/categories_model.dart';

final String apikey = "[API-KEY]";

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categoires = List();

  categoires.add(CategoriesModel("Street Art",
      "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));

  categoires.add(CategoriesModel("Wild Life",
      "https://images.pexels.com/photos/1034559/pexels-photo-1034559.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"));

  categoires.add(CategoriesModel("Creative",
      "https://images.pexels.com/photos/5836/yellow-metal-design-decoration.jpg?cs=srgb&dl=pexels-kaboompics-com-5836.jpg&fm=jpg"));

  categoires.add(CategoriesModel("Business",
      "https://images.pexels.com/photos/3184418/pexels-photo-3184418.jpeg?cs=srgb&dl=pexels-fauxels-3184418.jpg&fm=jpg"));

  categoires.add(CategoriesModel("Technology",
      "https://images.pexels.com/photos/3913025/pexels-photo-3913025.jpeg?cs=srgb&dl=pexels-thisisengineering-3913025.jpg&fm=jpg"));

  return categoires;
}
