part of 'contact_list_bloc.dart';

@freezed
class ContactListState with _$ContactListState {
  factory ContactListState.inital() = _ContactListStateInitial;
  factory ContactListState.loading() = _ContactListStateloading;

  factory ContactListState.data({required List<ContactModel> contacts}) =
      _ContactListStateData;

  factory ContactListState.error({required String error}) =
      _ContactListStateError;
}
