import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_base_template/models/shop.dart';
import 'package:flutter_base_template/ui/components/my_container.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.todos,
    this.onTab,
    this.isLoading = false,
    this.isPlaceholder = false,
  });

  final Todo? todos;
  final VoidCallback? onTab;
  final bool isLoading;
  final bool isPlaceholder;

  @override
  Widget build(BuildContext context) {
    if (todos == null) {
      CircularProgressIndicator();
    }
    return GestureDetector(
      onTap: isLoading || isPlaceholder ? null : onTab,
      child: MyContainer(
          child: isLoading || isPlaceholder
              ? _buildPlaceholder()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      // margin: EdgeInsets.symmetric(vertical: defaultPadding),
                      padding: EdgeInsets.all(defaultPadding * 0.75),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: todos!.color!.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: SvgPicture.asset(
                        todos!.svgSrc!,
                        // colorFilter:
                        //     ColorFilter.mode(todos.color ?? Colors.black, BlendMode.srcIn),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          todos!.numOfTodo.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          // style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                          todos!.title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                )),
    );
  }

  Widget _buildPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 80,
            height: 20,
            color: Colors.white,
          ),
          Container(
            width: 100,
            height: 24,
            color: Colors.white,
          ),
          Container(
            width: 24,
            height: 24,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
