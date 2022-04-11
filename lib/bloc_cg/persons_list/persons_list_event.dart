part of 'persons_list_bloc.dart';

@immutable
abstract class PersonsListEvent {}

class FetchPersonsList extends PersonsListEvent {}

class FetchPerson extends PersonsListEvent {
  final String personId;

  FetchPerson(this.personId);
}
