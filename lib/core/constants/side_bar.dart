import 'package:dash_board/core/constants/assets_constants.dart';

class SideBar {
  final String title;
  final String path;
  final int index;

  SideBar({required this.title, required this.path, required this.index});

  static List<SideBar> bars = [
    SideBar(title: "Users", path: AssetsConstants.users, index: 0),
    SideBar(title: "Suppliers", path: AssetsConstants.users, index: 1),
    SideBar(
        title: "Chat",
        path: "assets/chat-round-dots-svgrepo-com.svg",
        index: 2),
    SideBar(title: "Orders", path: AssetsConstants.client, index: 3),
    SideBar(title: "Accepted Orders", path: AssetsConstants.client, index: 4),
    SideBar(title: "Offers", path: AssetsConstants.supplier, index: 5),
    SideBar(title: "Accepted Offers", path: AssetsConstants.supplier, index: 6),
    SideBar(title: "Notifications", path: '', index: 7),
    SideBar(title: "Clients approved", path: AssetsConstants.supplier, index: 8),
  ];
}
