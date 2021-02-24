import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class SideNav extends StatefulWidget {
  final List<SideBarNavPage> pages;
  final List<SideBarNavPage> bottom;
  final Widget child;

  SideNav({Key key, this.pages = const [], this.child, this.bottom = const []})
      : super(key: key);

  @override
  _SideNavState createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  Widget _page(BuildContext context, SideBarNavPage page) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          bottom: 8.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: page.isSelected
                ? TinyColor(Theme.of(context).accentColor).color
                : TinyColor(Theme.of(context).canvasColor).lighten(10).color,
          ),
          child: Material(
            elevation: page.isSelected ? 12.0 : 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            clipBehavior: Clip.antiAlias,
            color: Colors.transparent,
            child: InkWell(
              onTap: page.onPressed,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Icon(page.icon),
                    ),
                    Text(
                      page.title,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sideBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: SizedBox(
        width: 88,
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            ...widget.pages.map((e) => _page(context, e)).toList(),
            Expanded(
              child: Container(),
            ),
            ...widget.bottom.map((e) => _page(context, e)).toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _sideBar(context),
        Expanded(
          child: widget.child,
        )
      ],
    );
  }
}

class SideBarNavPage {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isSelected;

  SideBarNavPage(
      {this.isSelected = false,
      this.title,
      @required this.icon,
      this.onPressed});
}
