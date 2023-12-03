import 'package:bcode/feature/presentation/pages/notes/notes_page.dart';
import 'package:bcode/feature/presentation/widgets/nav_bar_component.dart';
import 'package:flutter/material.dart';
import "package:collapsible_sidebar/collapsible_sidebar.dart";
import "dart:math" as math;
import 'package:bcode/feature/presentation/pages/community/community_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final navBarComponent = NavBarComponent();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          // body: navBarComponent.nav(context, _items, _body, size),
          body: navBarComponent.nav(context, _items, _body, size)),
    );
  }

  Widget _body(Size size, BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blueGrey[50],
        child: _buildPage());
  }

  Widget _buildPage() {
    List<Widget> pages = const [NotesPage(), CommunityPage()];
    return pages[currentIndex];
  }

  List<CollapsibleItem> get _items {
    return [
      CollapsibleItem(
        text: 'Home',
        icon: Icons.home,
        isSelected: currentIndex == 0,
        onPressed: () => setState(() => currentIndex = 0),
      ),
      CollapsibleItem(
        text: 'Community',
        icon: Icons.assessment,
        isSelected: currentIndex == 1,
        onPressed: () => setState(() => currentIndex = 1),
      ),
    ];
  }
}
