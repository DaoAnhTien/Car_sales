import 'dart:core';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../values/style.dart';
import 'triangle_painter.dart';

abstract class MenuItemProvider {
  String? get menuTitle;

  String? get menuKey;

  Widget? get menuImage;

  TextStyle? get menuTextStyle;

  TextAlign? get menuTextAlign;
}

class MenuItem extends MenuItemProvider {
  Widget? image;
  String? key;
  String? title;
  String? userInfo;
  TextStyle? textStyle;
  TextAlign? textAlign;

  MenuItem(
      {this.key,
      this.title,
      this.image,
      this.userInfo,
      this.textStyle,
      this.textAlign});

  @override
  Widget? get menuImage => image;

  @override
  String? get menuKey => key;

  @override
  String? get menuTitle => title;

  @override
  TextStyle get menuTextStyle =>
      textStyle ?? const TextStyle(color: Color(0xffc5c5c5), fontSize: 10.0);

  @override
  TextAlign get menuTextAlign => textAlign ?? TextAlign.center;
}

enum MenuType { big, oneLine }

typedef MenuClickCallback = Function(MenuItemProvider item);
typedef PopupMenuStateChanged = Function(bool isShow);

class PopupMenu {
  double? itemWidth;
  double? itemHeight;
  static var arrowHeight = 10.0;
  OverlayEntry? _entry;
  List<MenuItemProvider>? items;

  String? selected;

  /// row count
  int? _row;

  /// col count
  int? _col;

  /// The left top point of this menu.
  Offset? _offset;

  /// Menu will show at above or under this rect
  Rect? _showRect;

  /// if false menu is show above of the widget, otherwise menu is show under the widget
  bool _isDown = true;

  /// The max column count, default is 4.
  int? _maxColumn;

  /// callback
  VoidCallback? dismissCallback;
  MenuClickCallback? onClickMenu;
  PopupMenuStateChanged? stateChanged;

  Size? _screenSize; // 屏幕的尺寸

  /// Cannot be null
  static BuildContext? context;

  /// style
  Color? _backgroundColor;
  Color? _highlightColor;
  Color? _lineColor;

  /// It's showing or not.
  bool _isShow = false;

  bool? get isShow => _isShow;

  PopupMenu(
      {this.onClickMenu,
      BuildContext? context,
      VoidCallback? onDismiss,
      int? maxColumn,
      Color? backgroundColor,
      Color? highlightColor,
      Color? lineColor,
      this.stateChanged,
      this.selected,
      this.items,
      double? itemWidth,
      double? itemHeight}) {
    this.itemWidth = itemWidth ?? 72.0;
    this.itemHeight = itemHeight ?? 65.0;
    onClickMenu = onClickMenu;
    dismissCallback = onDismiss;
    stateChanged = stateChanged;
    selected = selected;
    items = items;
    _maxColumn = maxColumn ?? 4;
    _backgroundColor = backgroundColor ?? const Color(0xff232323);
    _lineColor = lineColor ?? const Color(0xff353535);
    _highlightColor = highlightColor ?? const Color(0x55000000);
    if (context != null) {
      PopupMenu.context = context;
    }
  }

  void show({Rect? rect, GlobalKey? widgetKey, List<MenuItemProvider>? items}) {
    if (rect == null && widgetKey == null) {
      debugPrint("'rect' and 'key' can't be both null");
      return;
    }

    this.items = items ?? this.items;
    _showRect = rect ?? PopupMenu.getWidgetGlobalRect(widgetKey!);
    _screenSize = window.physicalSize / window.devicePixelRatio;
    dismissCallback = dismissCallback;

    _calculatePosition(PopupMenu.context!);

    _entry = OverlayEntry(builder: (context) {
      return buildPopupMenuLayout(_offset!);
    });

    Overlay.of(PopupMenu.context!)!.insert(_entry!);
    _isShow = true;
    if (stateChanged != null) {
      stateChanged!(true);
    }
  }

  static Rect getWidgetGlobalRect(GlobalKey key) {
    RenderBox? renderBox = key.currentContext!.findRenderObject() as RenderBox?;
    var offset = renderBox!.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  void _calculatePosition(BuildContext context) {
    _col = _calculateColCount();
    _row = _calculateRowCount();
    _offset = _calculateOffset(PopupMenu.context!);
  }

  Offset _calculateOffset(BuildContext context) {
    double dx = _showRect!.left + _showRect!.width / 2.0 - menuWidth() / 2.0;
    if (dx < 10.0) {
      dx = 10.0;
    }

    if (dx + menuWidth() > _screenSize!.width && dx > 10.0) {
      double tempDx = _screenSize!.width - menuWidth() - 10;
      if (tempDx > 10) dx = tempDx;
    }

    double dy = _showRect!.top - menuHeight();
    if (dy <= MediaQuery.of(context).padding.top + 10) {
      // The have not enough space above, show menu under the widget.
      dy = arrowHeight + _showRect!.height + _showRect!.top;
      _isDown = false;
    } else {
      dy -= arrowHeight;
      _isDown = true;
    }

    return Offset(dx, dy);
  }

  double menuWidth() {
    return itemWidth! * _col!;
  }

  // This height exclude the arrow
  double menuHeight() {
    return itemHeight! * _row!;
  }

  LayoutBuilder buildPopupMenuLayout(Offset offset) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          dismiss();
        },
//        onTapDown: (TapDownDetails details) {
//          dismiss();
//        },
        // onPanStart: (DragStartDetails details) {
        //   dismiss();
        // },
        onVerticalDragStart: (DragStartDetails details) {
          dismiss();
        },
        onHorizontalDragStart: (DragStartDetails details) {
          dismiss();
        },
        child: Stack(
          children: <Widget>[
            // triangle arrow
            Positioned(
              left: _showRect!.left + _showRect!.width / 2.0 - 7.5,
              top: _isDown ? offset.dy + menuHeight() : offset.dy - arrowHeight,
              child: CustomPaint(
                size: Size(15.0, arrowHeight),
                painter:
                    TrianglePainter(isDown: _isDown, color: _backgroundColor),
              ),
            ),
            // menu content
            Positioned(
              left: offset.dx,
              top: offset.dy,
              child: SizedBox(
                width: menuWidth(),
                height: menuHeight(),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: menuWidth(),
                          height: menuHeight(),
                          decoration: BoxDecoration(
                              color: _backgroundColor,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            children: _createRows(),
                          ),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  // 创建行
  List<Widget> _createRows() {
    List<Widget> rows = [];
    for (int i = 0; i < _row!; i++) {
      Color? color =
          (i < _row! - 1 && _row != 1) ? _lineColor : Colors.transparent;
      Widget rowWidget = Container(
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(color: color!))),
        height: itemHeight,
        child: Row(
          children: _createRowItems(i),
        ),
      );

      rows.add(rowWidget);
    }

    return rows;
  }

  // 创建一行的item,  row 从0开始算
  List<Widget> _createRowItems(int row) {
    List<MenuItemProvider> subItems =
        items!.sublist(row * _col!, min(row * _col! + _col!, items!.length));
    List<Widget> itemWidgets = [];
    int i = 0;
    for (var item in subItems) {
      itemWidgets.add(_createMenuItem(
        item,
        i < (_col! - 1),
      ));
      i++;
    }

    return itemWidgets;
  }

  // calculate row count
  int _calculateRowCount() {
    if (items == null || items!.isEmpty) {
      debugPrint('error menu items can not be null');
      return 0;
    }

    int itemCount = items!.length;

    if (_calculateColCount() == 1) {
      return itemCount;
    }

    int row = (itemCount - 1) ~/ _calculateColCount() + 1;

    return row;
  }

  // calculate col count
  int _calculateColCount() {
    if (items == null || items!.isEmpty) {
      debugPrint('error menu items can not be null');
      return 0;
    }

    int itemCount = items!.length;
    if (_maxColumn != 4 && _maxColumn! > 0) {
      return _maxColumn!;
    }

    if (itemCount == 4) {
      // 4个显示成两行
      return 2;
    }

    if (itemCount <= _maxColumn!) {
      return itemCount;
    }

    if (itemCount == 5) {
      return 3;
    }

    if (itemCount == 6) {
      return 3;
    }

    return _maxColumn!;
  }

  double get screenWidth {
    double width = window.physicalSize.width;
    double ratio = window.devicePixelRatio;
    return width / ratio;
  }

  Widget _createMenuItem(MenuItemProvider item, bool showLine) {
    return _MenuItemWidget(
      item: item,
      showLine: showLine,
      clickCallback: itemClicked,
      lineColor: _lineColor,
      backgroundColor: _backgroundColor,
      highlightColor: _highlightColor,
      selected: selected,
      itemWidth: itemWidth,
      itemHeight: itemHeight,
    );
  }

  void itemClicked(MenuItemProvider item) {
    if (onClickMenu != null) {
      onClickMenu!(item);
      selected = item.menuKey;
    }

    dismiss();
  }

  void dismiss() {
    if (!_isShow) {
      // Remove method should only be called once
      return;
    }

    _entry!.remove();
    _isShow = false;
    if (dismissCallback != null) {
      dismissCallback!();
    }

    if (stateChanged != null) {
      stateChanged!(false);
    }
  }
}

class _MenuItemWidget extends StatefulWidget {
  final MenuItemProvider? item;

  // 是否要显示右边的分隔线
  final bool? showLine;
  final Color? lineColor;
  final Color? backgroundColor;
  final Color? highlightColor;
  final String? selected;
  final double? itemWidth;
  final double? itemHeight;

  final Function(MenuItemProvider item)? clickCallback;

  const _MenuItemWidget(
      {this.item,
      this.showLine = false,
      this.clickCallback,
      this.lineColor,
      this.backgroundColor,
      this.highlightColor,
      this.selected,
      this.itemWidth,
      this.itemHeight});

  @override
  State<StatefulWidget> createState() {
    return _MenuItemWidgetState();
  }
}

class _MenuItemWidgetState extends State<_MenuItemWidget> {
  var highlightColor = const Color(0x55000000);
  var color = const Color(0xff232323);

  @override
  void initState() {
    color = widget.backgroundColor!;
    highlightColor = widget.highlightColor!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        color = highlightColor;
        setState(() {});
      },
      onTapUp: (details) {
        color = widget.backgroundColor!;
        setState(() {});
      },
      onLongPressEnd: (details) {
        color = widget.backgroundColor!;
        setState(() {});
      },
      onTap: () {
        if (widget.clickCallback != null) {
          widget.clickCallback!(widget.item!);
        }
      },
      child: Container(
          width: widget.itemWidth,
          height: widget.itemHeight,
          decoration: BoxDecoration(
              color: color,
              border: Border(
                  right: BorderSide(
                      color: widget.showLine!
                          ? widget.lineColor!
                          : Colors.transparent))),
          child: _createContent()),
    );
  }

  Widget _createContent() {
    if (widget.item!.menuImage != null) {
      // image and text
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: widget.itemWidth,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Text(
                      widget.item!.menuTitle ?? '',
                      style: widget.item!.menuTextStyle!.copyWith(
                        fontFamily: widget.selected == widget.item!.menuKey
                            ? Style.fontDemiBold
                            : widget.item!.menuTextStyle!.fontFamily,
                      ),
                      textAlign: widget.item!.menuTextAlign,
                    ),
                  ),
                ),
                AnimatedCrossFade(
                  firstChild: widget.item!.menuImage ?? const SizedBox(),
                  secondChild: const SizedBox(),
                  crossFadeState: widget.selected == widget.item!.menuKey ||
                          widget.selected == 'icon'
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 200),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // only text
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: widget.itemWidth,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: widget.selected == widget.item!.menuKey
                  ? context.theme.highlightColor
                  : context.theme.hoverColor,
            ),
            child: Text(
              widget.item!.menuTitle ?? '',
              style: widget.item!.menuTextStyle!.copyWith(
                  fontFamily: widget.selected == widget.item!.menuKey
                      ? Style.fontDemiBold
                      : widget.item!.menuTextStyle!.fontFamily,
                  color: widget.selected == widget.item!.menuKey
                      ? context.textTheme.headline3!.color
                      : widget.item!.menuTextStyle!.color),
              textAlign: widget.item!.menuTextAlign,
            ),
          ),
        ),
      );
    }
  }
}
