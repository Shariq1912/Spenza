import 'package:flutter/material.dart';

enum PopupMenuAction {
  copy,
  delete,
  edit,
}

extension PopupMenuActionExtension on PopupMenuAction {
  String get value {
    switch (this) {
      case PopupMenuAction.copy:
        return "Copy";
      case PopupMenuAction.delete:
        return "Delete";
      case PopupMenuAction.edit:
        return "Edit";
    }
  }
}

mixin PopupMenuMixin<T extends StatefulWidget> on State<T> {
  void showPopupMenu({
    required BuildContext context,
    required RelativeRect position,
    required List<PopupMenuEntry<PopupMenuAction>> items,
    required void Function(PopupMenuAction value) onSelected,
  }) {
    final theme = Theme.of(context);

    showMenu<PopupMenuAction>(
      context: context,
      position: position,
      items: items,
      elevation: 8.0,
      color: theme.popupMenuTheme.color,
    ).then<void>((PopupMenuAction? itemSelected) {
      if (itemSelected != null) {
        onSelected(itemSelected);
      }
    });
  }
}
