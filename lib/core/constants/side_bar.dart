import 'package:dash_board/core/constants/assets_constants.dart';

class SideBar {
  final String title;
  final String path;
  final int index;

  SideBar({required this.title, required this.path, required this.index});

  static List<SideBar> bars = [
    SideBar(title: "Users", path: AssetsConstants.users, index: 0),
    SideBar(title: "Orders", path: AssetsConstants.client, index: 1),
    SideBar(title: "Offers", path: AssetsConstants.supplier, index: 2),
  ];
}
