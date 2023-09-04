import 'package:bloc_contact/features/contacts_cubit/list/cubit/contact_list_cubit.dart';
import 'package:bloc_contact/models/contact_model.dart';
import 'package:bloc_contact/repositories/contacts_repositories.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepositories {}

void main() {
  //declaracao

  late MockContactsRepository repository;

  late ContactListCubit cubit;
  late List<ContactModel> contacts;

  //preparacao

  setUp(() {
    repository = MockContactsRepository();
    cubit = ContactListCubit(repositories: repository);
    contacts = [
      ContactModel(name: 'Gabriel', email: 'gabriel@hotmail.com'),
      ContactModel(name: 'Gabriel Zorzan', email: 'gabriel@hotmail.com.br')
    ];
  });

  //execução

  blocTest<ContactListCubit, ContactListCubitState>(
    'Deve buscar os contatos',
    build: () => cubit,
    act: (cubit) => cubit.findAll(),
    setUp: () {
      when(
        () => repository.findAll(),
      ).thenAnswer((_) async => contacts);
    },
    expect: () => [
      ContactListCubitState.loading(),
      ContactListCubitState.data(contacts: contacts),
    ],
  );
}
