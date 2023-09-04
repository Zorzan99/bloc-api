import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_contact/repositories/contacts_repositories.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/contact_model.dart';

part 'contact_list_event.dart';
part 'contact_list_state.dart';
part 'contact_list_bloc.freezed.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  final ContactsRepositories _repository;

  ContactListBloc({required ContactsRepositories repository})
      : _repository = repository,
        super(ContactListState.inital()) {
    on<_ContactListEventFindAll>(_findAll);
    on<_ContactListEventDelete>(_deleteById);
  }

  Future<void> _findAll(
      _ContactListEventFindAll event, Emitter<ContactListState> emit) async {
    try {
      emit(ContactListState.loading());
      //   await Future.delayed(const Duration(seconds: 2));
      final contacts = await _repository.findAll();
      emit(ContactListState.data(contacts: contacts));
    } catch (e, s) {
      log('Erro ao buscar contatos', error: e, stackTrace: s);
      emit(ContactListState.error(error: 'Erro ao buscar contatos'));
    }
  }

  FutureOr<void> _deleteById(
      _ContactListEventDelete event, Emitter<ContactListState> emit) async {
    emit(ContactListState.loading());
    await _repository.delete(event.model);
    add(const ContactListEvent.findAll());
  }
}
