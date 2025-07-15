import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class DndReorderableGrid<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final void Function(int oldIndex, int newIndex) onReorder;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  const DndReorderableGrid({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onReorder,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.childAspectRatio = 1,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableWrap(
      spacing: crossAxisSpacing,
      runSpacing: mainAxisSpacing,
      maxMainAxisCount: crossAxisCount,
      needsLongPressDraggable: true,
      onReorder: onReorder,
      children: [
        for (int i = 0; i < items.length; i++)
          SizedBox(
            width:
                (MediaQuery.of(context).size.width -
                    (crossAxisCount - 1) * crossAxisSpacing -
                    32) /
                crossAxisCount,
            child: AspectRatio(
              aspectRatio: childAspectRatio,
              child: itemBuilder(context, items[i], i),
            ),
          ),
      ],
    );
  }
}
