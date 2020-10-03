import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/routine.dart';

addTag(BuildContext context, {List<String> addedTags}) async {
  final tagNotifier = ValueNotifier<List<String>>(addedTags);

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      tagNotifier.value = addedTags;

      return Padding(
        padding: EdgeInsets.only(
          left: 25.0,
          right: 25.0,
          top: 60.0,
          bottom: 60.0,
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "TAGS",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      flex: 3,
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "DONE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: tagNotifier,
                    builder: (context, tagList, _) {
                      return ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: tags.length,
                        itemBuilder: (context, index) {
                          final tag = tags[index];
                          return InkWell(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    tag,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  tagList.contains(tag)
                                      ? Positioned(
                                          left: 0.0,
                                          child: Icon(Icons.done),
                                        )
                                      : Offstage(),
                                ],
                              ),
                            ),
                            onTap: () {
                              final list = tagNotifier.value.toList();
                              if (list.contains(tag)) {
                                list.remove(tag);
                              } else {
                                list.add(tag);
                              }
                              tagNotifier.value = list;
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "EDIT TAGS",
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                        child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "ADD NEW TAG",
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
  return tagNotifier.value;
}
