import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_firebase_ddd/application/notes/note_form/note_form_bloc.dart';
import 'package:notes_firebase_ddd/domain/notes/value_objects.dart';

class ColorField extends StatelessWidget {
  const ColorField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteFormBloc, NoteFormState>(
      buildWhen: (p, c) => p.note.color != c.note.color,
      builder: (context, state) {
        return Container(
          height: 80,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (ctx, index) {
              final itemColor = NoteColor.predefinedColors[index];
              return GestureDetector(
                onTap: () => {
                  BlocProvider.of<NoteFormBloc>(ctx)
                      .add(NoteFormEvent.colorChanged(itemColor))
                },
                child: Material(
                  color: itemColor,
                  elevation: 4,
                  shape: CircleBorder(
                    side: state.note.color.value.fold(
                      (_) => BorderSide.none,
                      (color) => color == itemColor
                          ? const BorderSide(width: 1.5)
                          : BorderSide.none,
                    ),
                  ),
                  child: Container(
                    height: 50,
                    width: 50,
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                width: 12,
              );
            },
            itemCount: NoteColor.predefinedColors.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }
}
