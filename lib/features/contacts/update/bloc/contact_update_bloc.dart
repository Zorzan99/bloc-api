import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_contact/models/contact_model.dart';
import 'package:bloc_contact/repositories/contacts_repositories.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_update_event.dart';
part 'contact_update_state.dart';
part 'contact_update_bloc.freezed.dart';

class ContactUpdateBloc extends Bloc<ContactUpdateEvent, ContactUpdateState> {
  final ContactsRepositories _contactsRepositories;

  ContactUpdateBloc({required ContactsRepositories contactsRepositories})
      : _contactsRepositories = contactsRepositories,
        super(const _Initial()) {
    on<_Save>(_save);
  }

  FutureOr<void> _save(_Save event, Emitter<ContactUpdateState> emit) async {
    try {
      emit(const ContactUpdateState.loading());
      final model = ContactModel(
        id: event.id,
        name: event.name,
        email: event.email,
      );

      await _contactsRepositories.update(model);
      emit(const ContactUpdateState.success());
    } catch (e, s) {
      log('Erro ao atualizar contato', error: e, stackTrace: s);
      emit(
          const ContactUpdateState.error(message: 'Erro ao atualizar contato'));
    }
  }
}
