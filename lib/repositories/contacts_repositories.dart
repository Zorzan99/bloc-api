// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_contact/models/contact_model.dart';
import 'package:dio/dio.dart';

class ContactsRepositories {
  Future<List<ContactModel>> findAll() async {
    final response = await Dio().get('http://10.0.2.2:8080/users');

    return response.data
        ?.map<ContactModel>((contact) => ContactModel.fromMap(contact))
        .toList();
  }

  Future<void> create(ContactModel model) async => Dio().post(
        'http://10.0.2.2:8080/users',
        data: model.toMap(),
      );

  Future<void> update(ContactModel model) => Dio().put(
        'http://10.0.2.2:8080/users/${model.id}',
        data: model.toMap(),
      );

  Future<void> delete(ContactModel model) => Dio().delete(
        'http://10.0.2.2:8080/users/${model.id}',
        data: model.toMap(),
      );
}
