import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_contact/models/contact_model.dart';
import 'package:bloc_contact/repositories/contacts_repositories.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_register_state.dart';
part 'contact_register_event.dart';

part 'contact_register_bloc.freezed.dart';

class ContactRegisterBloc
    extends Bloc<ContactRegisterEvent, ContactRegisterState> {
  final ContactsRepositories _contactsRepositories;

  ContactRegisterBloc({required ContactsRepositories contactsRepositories})
      : _contactsRepositories = contactsRepositories,
        super(ContactRegisterState.initial()) {
    on<_Save>(_save);
  }

  Future<FutureOr<void>> _save(
      event, Emitter<ContactRegisterState> emit) async {
    try {
      emit(ContactRegisterState.loading());
      await Future.delayed(const Duration(seconds: 2));

      final contactModel = ContactModel(
        name: event.name,
        email: event.email,
      );

      await _contactsRepositories.create(contactModel);
      emit(ContactRegisterState.success());
    } catch (e, s) {
      log('Erro ao  salvar um novo contato', error: e, stackTrace: s);
      emit(ContactRegisterState.error(message: 'Erro ao salvar contato'));
    }
  }
}
