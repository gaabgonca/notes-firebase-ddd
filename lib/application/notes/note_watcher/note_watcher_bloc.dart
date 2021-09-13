import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes_firebase_ddd/domain/notes/i_note_repository.dart';
import 'package:notes_firebase_ddd/domain/notes/note.dart';
import 'package:notes_firebase_ddd/domain/notes/note_failure.dart';
import 'package:dartz/dartz.dart';

part 'note_watcher_event.dart';
part 'note_watcher_state.dart';
part 'note_watcher_bloc.freezed.dart';

@injectable
class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  final INoteRepository _noteRepository;

  NoteWatcherBloc(this._noteRepository)
      : super(const NoteWatcherState.initial());

  StreamSubscription<Either<NoteFailure, KtList<Note>>>? _noteStreamSuscription;

  @override
  Stream<NoteWatcherState> mapEventToState(
    NoteWatcherEvent event,
  ) async* {
    yield* event.map(watchAllStarted: (e) async* {
      yield const NoteWatcherState.loadInProgress();
      await _noteStreamSuscription?.cancel();
      _noteStreamSuscription = _noteRepository.watchAll().listen(
          (failureOrNotes) =>
              add(NoteWatcherEvent.notesReceived(failureOrNotes)));
    }, watchUncompletedStarted: (e) async* {
      yield const NoteWatcherState.loadInProgress();
      await _noteStreamSuscription?.cancel();
      _noteStreamSuscription = _noteRepository.watchUncompleted().listen(
          (failureOrNotes) =>
              add(NoteWatcherEvent.notesReceived(failureOrNotes)));
    }, notesReceived: (event) async* {
      yield event.failureOrNotes.fold((f) => NoteWatcherState.loadFailure(f),
          (notes) => NoteWatcherState.loadSuccess(notes));
    });
  }

  @override
  Future<void> close() {
    _noteStreamSuscription?.cancel();
    return super.close();
  }
}
