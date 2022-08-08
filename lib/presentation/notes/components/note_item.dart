import 'package:clean_architecture_note/domain/model/note.dart';
import 'package:clean_architecture_note/ui/colors.dart';
import 'package:flutter/material.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final Function? onDeleteTap;

  const NoteItem({super.key, required this.note, this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    print(note);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Color(note.color)),
        child: Stack(
          children: [
            Positioned(
                right: 0,
                bottom: 0,
                child: IconButton(
                    onPressed: () {
                      onDeleteTap?.call();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: darkgray,
                    ))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  note.content,
                  style: Theme.of(context).textTheme.bodyText2,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
