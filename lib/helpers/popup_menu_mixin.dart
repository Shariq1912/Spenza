import 'package:flutter/material.dart';
import 'package:spenza/utils/spenza_extensions.dart';

enum PopupMenuAction {
  copy,
  delete,
  edit,
  upload,
  receipt
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
      case PopupMenuAction.upload:
        return "Upload Receipt";
      case PopupMenuAction.receipt:
        return "Receipts";
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
    FloatingActionButton(
      onPressed: () {
        // Implement action for the first floating button
      },
      child: Icon(Icons.add),
    );

    showMenu<PopupMenuAction>(
      context: context,
      position: position,
      items: items,
      elevation: 8.0,
      color: Colors.white,
        surfaceTintColor: Colors.white,
    ).then<void>((PopupMenuAction? itemSelected) {
      if (itemSelected != null) {
        onSelected(itemSelected);
      }
    });
  }
}
/*class CustomPopupMenuOverlay {
  final BuildContext context;
  OverlayEntry? overlayEntry;
  Offset buttonPosition = Offset.zero;

  CustomPopupMenuOverlay(this.context);

  void show(String itemPath, Offset itemPosition) {
    final overlay = Overlay.of(context);

    buttonPosition = itemPosition;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: buttonPosition.dx-50,
        top: buttonPosition.dy-50,
        child: GestureDetector(
          onTap: hide,
          child: Material(
            color: Colors.transparent,
            child: Row(
              children: [
                ClipOval(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      splashColor:Color(0xFF7B868C),
                      onTap: () {},
                      child: SizedBox(
                          width: 25,
                          height: 25,
                          child:
                              Icon(
                            Icons.favorite_border_outlined,
                            color: Color(0xFF7B868C),
                            size: 20,
                          )),
                    ),
                  ),
                ),
                ClipOval(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      splashColor:Color(0xFF7B868C),
                      onTap: () {},
                      child: SizedBox(
                          width: 25,
                          height: 25,
                          child:
                          Icon(
                            Icons.favorite_border_outlined,
                            color: Color(0xFF7B868C),
                            size: 20,
                          )),
                    ),
                  ),
                ),
                ClipOval(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      splashColor:Color(0xFF7B868C),
                      onTap: () {},
                      child: SizedBox(
                          width: 25,
                          height: 25,
                          child:
                          Icon(
                            Icons.favorite_border_outlined,
                            color: Color(0xFF7B868C),
                            size: 20,
                          )),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry!);
  }

  void hide() {
    overlayEntry?.remove();
  }
}*/

/*class CustomPopupMenuOverlay {
  final BuildContext context;
  OverlayEntry? overlayEntry;
  Offset buttonPosition = Offset.zero;

  CustomPopupMenuOverlay(this.context);

  void show(String itemPath, Offset itemPosition) {
    final overlay = Overlay.of(context);

    buttonPosition = itemPosition;

    overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: hide,
        child: Positioned(
          left: buttonPosition.dx,
          top: buttonPosition.dy,
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    context.showSnackBar( message: 'clicked');
                  },
                  child: Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () {
                    // Add your code here
                  },
                  child: Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () {
                    // Add your code here
                  },
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry!);
  }

  void hide() {
    overlayEntry?.remove();
  }
}*/


