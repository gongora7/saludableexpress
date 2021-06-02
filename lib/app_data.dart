import 'package:flutter_app1/src/api/responses/languages_response.dart';

import 'src/api/responses/banners_response.dart';
import 'src/api/responses/categories_response.dart';
import 'src/models/drawer_menu_item.dart';
import 'src/models/settings.dart';
import 'src/models/user.dart';

class AppData {
  static User user;
  static List<DrawerMenuItem> data;
  static SettingsData settings;
  static CategoriesResponse categories;
  static BannersResponse banners;
  static List<int> cartIds = List<int>();
  static LanguagesResponse languages;
  static String currencySymbol = "\$";

}
