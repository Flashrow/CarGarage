part of 'persons_list_bloc.dart';

@immutable
abstract class PersonsListState {}

class PersonsListInitial extends PersonsListState {}

class LoadingPersonsList extends PersonsListState {}

class PersonsListFetched extends PersonsListState {
  final List<PersonDto> personsList;

  PersonsListFetched(this.personsList);
}

class FailedFetchingPersonsList extends PersonsListState {}

class LoadingPerson extends PersonsListState {}

class FailedFetchingPerson extends PersonsListState {}

class PersonNotExists extends PersonsListState {}

class PersonFetched extends PersonsListState {
  final PersonDto personDto;

  PersonFetched(this.personDto);
}
