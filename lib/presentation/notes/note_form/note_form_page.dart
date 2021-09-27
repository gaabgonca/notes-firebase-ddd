import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_firebase_ddd/application/notes/note_form/note_form_bloc.dart';
import 'package:notes_firebase_ddd/domain/notes/note.dart';
import 'package:notes_firebase_ddd/injection.dart';
import 'package:notes_firebase_ddd/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:notes_firebase_ddd/presentation/notes/note_form/widgets/body_field_widget.dart';
import 'package:notes_firebase_ddd/presentation/notes/note_form/widgets/color_field_widget.dart';
import 'package:notes_firebase_ddd/presentation/notes/note_form/widgets/todo_list_widget.dart';
import 'package:notes_firebase_ddd/presentation/notes/note_form/widgets/todo_tile_widget.dart';
import 'package:notes_firebase_ddd/presentation/routes/router.gr.dart';
import 'package:provider/provider.dart';

class NoteFormPage extends StatelessWidget {
  final Note? editingNote;

  const NoteFormPage({Key? key, required this.editingNote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            getIt<NoteFormBloc>()..add(NoteFormEvent.initialized(editingNote)),
        child: BlocConsumer<NoteFormBloc, NoteFormState>(
            listenWhen: (p, c) =>
                p.saveFailureOrSuccessOption != c.saveFailureOrSuccessOption,
            listener: (context, state) {
              state.saveFailureOrSuccessOption.fold(
                () => {},
                (either) {
                  either.fold((failure) {
                    FlushbarHelper.createError(
                      message: failure.map(
                        insufficientPermission: (_) =>
                            'Insufficient permissions ❌',
                        unableToUpdate: (_) =>
                            "Couldn't update the note. Was it deleted from another device?",
                        unexpected: (_) =>
                            'Unexpected error occured, please contact support.',
                      ),
                    ).show(context);
                  },
                      (r) => AutoRouter.of(context).popUntil((route) =>
                          route.settings.name == NotesOverviewPageRoute.name));
                },
              );
            },
            buildWhen: (p, c) => p.isSaving != c.isSaving,
            builder: (context, state) {
              return Stack(
                children: [
                  const NoteFormPageScaffold(),
                  SavingInProgressOverlay(isSaving: state.isSaving)
                ],
              );
            }));
  }
}

class SavingInProgressOverlay extends StatelessWidget {
  final bool isSaving;

  const SavingInProgressOverlay({Key? key, required this.isSaving})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isSaving,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          color: isSaving ? Colors.black.withOpacity(0.8) : Colors.transparent,
          width: MediaQuery.of(context).size.width,
          child: Visibility(
            visible: isSaving,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 8,
                ),
                Text('Saving',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 16, color: Colors.white))
              ],
            ),
          )),
    );
  }
}

class NoteFormPageScaffold extends StatelessWidget {
  const NoteFormPageScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: BlocBuilder<NoteFormBloc, NoteFormState>(
            buildWhen: (previous, current) =>
                previous.isEditing != current.isEditing,
            builder: (ctx, state) {
              return Text(state.isEditing ? 'Edit a note' : 'Create a note');
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  BlocProvider.of<NoteFormBloc>(context)
                      .add(const NoteFormEvent.saved());
                },
                icon: const Icon(Icons.check))
          ],
        ),
        body: BlocBuilder<NoteFormBloc, NoteFormState>(
          buildWhen: (previous, current) =>
              previous.showErrorMessages != current.showErrorMessages,
          builder: (context, state) {
            return ChangeNotifierProvider(
              create: (_) => FormTodos(),
              child: Form(
                  autovalidateMode: state.showErrorMessages
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: SingleChildScrollView(
                    child: Column(
                      children: const [
                        BodyField(),
                        ColorField(),
                        TodoList(),
                        AddTodoTile(),
                      ],
                    ),
                  )),
            );
          },
        ));
  }
}
