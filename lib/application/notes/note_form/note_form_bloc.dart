import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes_firebase_ddd/domain/notes/i_note_repository.dart';
import 'package:notes_firebase_ddd/domain/notes/note.dart';
import 'package:notes_firebase_ddd/domain/notes/note_failure.dart';
import 'package:notes_firebase_ddd/domain/notes/value_objects.dart';
import 'package:notes_firebase_ddd/infrastructure/notes/note_dtos.dart';
import 'package:notes_firebase_ddd/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';

part 'note_form_event.dart';
part 'note_form_state.dart';
part 'note_form_bloc.freezed.dart';

@injectable
class NoteFormBloc extends Bloc<NoteFormEvent, NoteFormState> {
  final INoteRepository _noteRepository;

  NoteFormState get initialState => NoteFormState.initial();

  NoteFormBloc(this._noteRepository) : super(NoteFormState.initial());

  @override
  Stream<NoteFormState> mapEventToState(
    NoteFormEvent event,
  ) async* {
    yield* event.map(
      initialized: (_Initialized e) async* {
        if (e.note == null) {
          yield state;
        } else {
          yield state.copyWith(note: e.note!, isEditing: true);
        }
      },
      bodyChanged: (_BodyChanged e) async* {
        yield state.copyWith(
            note: state.note.copyWith(body: NoteBody(e.bodyStr)),
            saveFailureOrSuccessOption: none());
      },
      colorChanged: (_ColorChanged e) async* {
        yield state.copyWith(
            note: state.note.copyWith(color: NoteColor(e.color)),
            saveFailureOrSuccessOption: none());
      },
      todosChanged: (_TodosChanged e) async* {
        yield state.copyWith(
            note: state.note.copyWith(
                todos: List3(e.todos
                    .map((todoItemPrimitive) => todoItemPrimitive.toDomain()))),
            saveFailureOrSuccessOption: none());
      },
      saved: (_Saved e) async* {
        Either<NoteFailure, Unit> failureOrSuccess;

        yield state.copyWith(
            isSaving: true, saveFailureOrSuccessOption: none());
        if (state.note.failureOption.isNone()) {
          failureOrSuccess = state.isEditing
              ? await _noteRepository.update(state.note)
              : await _noteRepository.create(state.note);
        } else {
          failureOrSuccess = left(NoteFailure.unexpected());
        }

        yield state.copyWith(
            isSaving: false,
            showErrorMessages: true,
            saveFailureOrSuccessOption:
                optionOf<Either<NoteFailure, Unit>>(failureOrSuccess));
      },
    );
  }
}
