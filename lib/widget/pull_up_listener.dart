import 'package:flutter/widgets.dart';

///上拉手势监听
class PullUpListener extends StatefulWidget {
  final Widget child;
  final OnPullUpListener onPullUpListener;

  PullUpListener(
      {@required this.child, @required this.onPullUpListener, Key key})
      : assert(child != null),
        assert(onPullUpListener != null),
        super(key: key);

  @override
  _PullUpListenerState createState() => _PullUpListenerState();
}

class _PullUpListenerState extends State<PullUpListener> {
  bool isPullUp=false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        child: widget.child, onNotification: _handleScrollNotification);
  }

  ///处理滑动监听
  bool _handleScrollNotification(ScrollNotification notification) {
    ///无视除排列方向不是向下的滑动
    if (notification.metrics.axisDirection != AxisDirection.down) {
      return false;
    }
    if (notification is OverscrollNotification) {
      isPullUp = notification.overscroll > 0.0;
    } else if (notification is ScrollEndNotification) {
      _handleScrollEnd(notification);
    }
    return false;
  }

  ///判断到达到最底部
  bool _atEdgeBottom(ScrollNotification scrollNotification) =>
      scrollNotification.metrics.extentAfter == 0.0;

  _handleScrollEnd(ScrollEndNotification scrollEndNotification) {
    if (isPullUp && _atEdgeBottom(scrollEndNotification)) {
      widget.onPullUpListener();
    }
  }
}
///监听回调
typedef OnPullUpListener = Function();
