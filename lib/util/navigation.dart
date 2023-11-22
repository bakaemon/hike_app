import 'package:flutter/material.dart';

/// Available navigation animations: [fade], [slideLeft/Right/Down/Up], [scale], [rotate], [size]
enum NavigationAnimation {
  fade,
  slideLeft,
  slideRight,
  slideUp,
  slideDown,
  scale,
  rotate,
  size,
  none,
}

Future<T?> navigate<T>(
  BuildContext context,
  Widget widget, {
  bool noHistory = false,
  NavigationAnimation? animation,
  PageRouteBuilder<T>? customRoute,
}) {
  if (noHistory) {
    return Navigator.of(context).pushReplacement<T, T>(
      customRoute ?? _getRoute<T>(widget, animation),
    );
  }

  return Navigator.push<T>(
    context,
    customRoute ?? _getRoute<T>(widget, animation),
  );
}

// ANIMATION
PageRoute<T> _getRoute<T>(
  Widget widget,
  NavigationAnimation? animation,
) {
  switch (animation) {
    case NavigationAnimation.fade:
      return _fadeTransition<T>(widget);
    case NavigationAnimation.slideRight:
      return _slideLeftToRightTransition<T>(widget);
    case NavigationAnimation.slideLeft:
      return _slideRightToLeftTransition<T>(widget);
    case NavigationAnimation.slideUp:
      return _slideUpTransition<T>(widget);
    case NavigationAnimation.scale:
      return _scaleTransition<T>(widget);
    case NavigationAnimation.rotate:
      return _rotateTransition<T>(widget);
    case NavigationAnimation.size:
      return _sizeTransition<T>(widget);
    case NavigationAnimation.none:
    default:
      return MaterialPageRoute<T>(
        builder: (context) => widget,
      );
  }
}

// fade transition
PageRouteBuilder<T> _fadeTransition<T>(Widget widget) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

// slide rtl transition
PageRouteBuilder<T> _slideRightToLeftTransition<T>(Widget widget) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}

// slide ltr transition
PageRouteBuilder<T> _slideLeftToRightTransition<T>(Widget widget) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}

// slide up transition
PageRouteBuilder<T> _slideUpTransition<T>(Widget widget) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}

// slide down transition
PageRouteBuilder<T> _slideDownTransition<T>(Widget widget) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}

// scale transition
PageRouteBuilder<T> _scaleTransition<T>(Widget widget) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: animation,
        child: child,
      );
    },
  );
}

// rotate transition
PageRouteBuilder<T> _rotateTransition<T>(Widget widget) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return RotationTransition(
        turns: animation,
        child: child,
      );
    },
  );
}

// size transition
PageRouteBuilder<T> _sizeTransition<T>(Widget widget) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SizeTransition(
        sizeFactor: animation,
        child: child,
      );
    },
  );
}
