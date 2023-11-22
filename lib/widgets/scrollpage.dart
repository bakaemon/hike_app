import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScrollPage extends StatelessWidget {
  const ScrollPage({
    required this.body,
    Key? key,
    this.title,
    this.hasBackArrow,
    this.backIcon,
    this.actions,
    this.background,
    this.floatingActionButton,
    this.appBarColor,
    this.titleText,
    this.bodyPadding,
  }) : super(key: key);

  final Widget body;
  final Widget? title;
  final bool? hasBackArrow;
  final IconData? backIcon;
  final List<Widget>? actions;
  final Color? background;
  final Widget? floatingActionButton;
  final Color? appBarColor;
  final String? titleText;
  final EdgeInsetsGeometry? bodyPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: appBarColor ?? Colors.grey[200],
              ),
            ),
            elevation: 1.0,
            title: title ??
                Text(
                  titleText ?? '',
                  style: TextStyle(color: Colors.blue[900]),
                ),
            centerTitle: true,
            leading: hasBackArrow == true
                ? GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Icon(
                      backIcon ?? Icons.arrow_back,
                      color: Colors.blue[900],
                      size: 30,
                    ),
                  )
                : Container(),
            actions: actions,
          ),
          // overflow fix
          SliverToBoxAdapter(
            child: Container(
              padding: bodyPadding ?? const EdgeInsets.all(10),
              color: background,
              child: body,
            ),
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
