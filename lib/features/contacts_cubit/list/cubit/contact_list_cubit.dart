import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_contact/repositories/contacts_repositories.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/contact_model.dart';
part 'contact_list_cubit_state.dart';
part 'contact_list_cubit.freezed.dart';

class ContactListCubit extends Cubit<ContactListCubitState> {
  final ContactsRepositories _repositories;

  ContactListCubit({required ContactsRepositories repositories})
      : _repositories = repositories,
        super(ContactListCubitState.initial());

  Future<void> findAll() async {
    try {
      emit(ContactListCubitState.loading());
      final contacts = await _repositories.findAll();
      await Future.delayed(const Duration(seconds: 1));

      emit(ContactListCubitState.data(contacts: contacts));
    } catch (e, s) {
      log('Erro ao buscar contatos', error: e, stackTrace: s);
      emit(ContactListCubitState.error(message: "Ocorreu um erro inesperado"));
    }
  }

  Future<void> deleteByModel(ContactModel model) async {
    emit(ContactListCubitState.loading());
    await _repositories.delete(model);
    findAll();
  }
}
