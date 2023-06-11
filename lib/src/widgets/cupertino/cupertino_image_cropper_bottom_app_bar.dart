import 'package:croppy/src/src.dart';
import 'package:flutter/cupertino.dart';

class CupertinoImageCropperBottomAppBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  const CupertinoImageCropperBottomAppBar({
    super.key,
    required this.controller,
    required this.shouldPopAfterCrop,
  });

  final CroppableImageController controller;
  final bool shouldPopAfterCrop;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CupertinoButton(
          onPressed: () => Navigator.maybePop(context),
          padding: const EdgeInsets.only(
            left: 4.0,
            right: 16.0,
            top: 16.0,
            bottom: 16.0,
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Color(0xFF8D2AF3)),
          ),
        ),
        const Spacer(),
        CupertinoButton(
          onPressed: () async {
            context
                .findAncestorStateOfType<CroppableImagePageAnimatorState>()
                ?.setHeroesEnabled(true);

            final result = await controller.crop();

            if (context.mounted && shouldPopAfterCrop) {
              Navigator.of(context).pop(result);
            }
          },
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 4.0,
            top: 16.0,
            bottom: 16.0,
          ),
          child: const Text('Done', style: TextStyle(color: Color(0xFF8D2AF3)),),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44.0);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
