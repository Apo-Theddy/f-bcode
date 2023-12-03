import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';

class NavBarComponent {
  Widget nav(BuildContext context, List<CollapsibleItem> items, Function body,
      Size size) {
    return CollapsibleSidebar(
      isCollapsed: MediaQuery.of(context).size.width <= 800,
      items: items,
      collapseOnBodyTap: true,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      title: 'John Smith',
      body: body(size, context),
      sidebarBoxShadow: [const BoxShadow(color: Colors.black12)],
    );
  }
}
