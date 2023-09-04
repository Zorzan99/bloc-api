import 'package:bloc_contact/features/contacts/list/bloc/contact_list_bloc.dart';
import 'package:bloc_contact/models/contact_model.dart';
import 'package:bloc_contact/repositories/contacts_repositories.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepositories {}

void main() {
  //declaracao

  late MockContactsRepository repository;

  late ContactListBloc bloc;
  late List<ContactModel> contacts;

  //preparacao

  setUp(() {
    repository = MockContactsRepository();
    bloc = ContactListBloc(repository: repository);
    contacts = [
      ContactModel(name: 'Gabriel', email: 'gabriel@hotmail.com'),
      ContactModel(name: 'Gabriel Zorzan', email: 'gabriel@hotmail.com.br')
    ];
  });

  //execução
  blocTest<ContactListBloc, ContactListState>(
    'Deve buscar os contatos',
    build: () => bloc,
    act: (bloc) => bloc.add(const ContactListEvent.findAll()),
    setUp: () {
      when(
        () => repository.findAll(),
      ).thenAnswer((_) async => contacts);
    },
    expect: () => [
      ContactListState.loading(),
      ContactListState.data(contacts: contacts),
    ],
  );
  blocTest<ContactListBloc, ContactListState>(
    'Deve retornar erros ao buscar os contatos',
    build: () => bloc,
    act: (bloc) => bloc.add(const ContactListEvent.findAll()),
    expect: () => [
      ContactListState.loading(),
      ContactListState.error(error: 'Erro ao buscar contatos'),
    ],
  );
}
