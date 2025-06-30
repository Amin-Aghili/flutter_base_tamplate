import 'package:flutter/material.dart';

class HeaderScrollScreen extends StatefulWidget {
  final Widget header;
  final Widget child;
  final double maxHeaderHeight;

  const HeaderScrollScreen({
    super.key,
    required this.header,
    required this.child,
    this.maxHeaderHeight = 70.0,
  });

  @override
  State<HeaderScrollScreen> createState() => _HeaderScrollScreenState();
}

class _HeaderScrollScreenState extends State<HeaderScrollScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _translateAnimation;
  double _lastOffset = 0.0;
  bool _isScrollingUp = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // کنترل دستی
      upperBound: 1,
      lowerBound: 0,
    );

    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
    _translateAnimation =
        Tween<double>(begin: 0.0, end: -widget.maxHeaderHeight)
            .animate(_animationController);

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final offset = _scrollController.offset;

    if (offset > _lastOffset + 5) {
      // اسکرول به پایین با threshold
      if (_isScrollingUp) {
        _isScrollingUp = false;
        _animationController.forward();
      }
    } else if (offset < _lastOffset - 5) {
      // اسکرول به بالا با threshold
      if (!_isScrollingUp) {
        _isScrollingUp = true;
        _animationController.reverse();
      }
    }

    _lastOffset = offset;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            final double paddingTop =
                widget.maxHeaderHeight * (1.0 - _animationController.value);

            return Stack(
              children: [
                // محتوای اسکرول‌شونده با پدینگ پویا
                Padding(
                  padding: EdgeInsets.only(top: paddingTop),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    child: widget.child,
                  ),
                ),

                // هدر متحرک
                _opacityAnimation.value == 0
                    ? const SizedBox.shrink()
                    : Transform.translate(
                        offset: Offset(0, _translateAnimation.value),
                        child: FadeTransition(
                          opacity: _opacityAnimation,
                          child: Container(
                            height: widget.maxHeaderHeight,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: widget.header,
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
