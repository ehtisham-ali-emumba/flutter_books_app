import 'package:books/core/constants/app_strings.dart';
import 'package:books/core/enums/theme_enums.dart';
import 'package:books/presentation/shared_view_models/app_bloc/app_bloc.dart';
import 'package:books/presentation/shared_view_models/app_bloc/app_event.dart';
import 'package:books/presentation/shared_view_models/app_bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppColorToggle extends StatelessWidget {
  const AppColorToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final themeColor = state.themeColor;

        return IconButton(
          icon: Icon(Icons.color_lens, color: themeColor),
          tooltip: AppStrings.changeThemeColor,
          onPressed: () => _showColorPicker(context, themeColor),
        );
      },
    );
  }

  Future<void> _showColorPicker(
    BuildContext context,
    Color currentColor,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(AppStrings.selectThemeColor),
          content: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: ThemeColorEnum.values.map((color) {
              return GestureDetector(
                onTap: () {
                  context.read<AppBloc>().add(
                    AppThemeColorChanged(color.toColor()),
                  );
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.toColor(),
                    shape: BoxShape.circle,
                    border: currentColor == color
                        ? Border.all(
                            color: Theme.of(context).colorScheme.onSurface,
                            width: 3,
                          )
                        : null,
                  ),
                  child: currentColor == color
                      ? Icon(
                          Icons.check,
                          color: _getContrastColor(color.toColor()),
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(AppStrings.cancel),
            ),
          ],
        );
      },
    );
  }

  Color _getContrastColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
