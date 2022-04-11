import 'package:bloc/bloc.dart';
import 'package:car_garage/network/models/person_dto.dart';
import 'package:car_garage/repository/person_list_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'persons_list_event.dart';
part 'persons_list_state.dart';

class PersonsListBloc extends Bloc<PersonsListEvent, PersonsListState> {
  final PersonListRepository _personListRepository;
  PersonsListBloc(this._personListRepository) : super(PersonsListInitial()) {
    on<FetchPersonsList>((event, emit) async {
      emit(LoadingPersonsList());
      try {
        List<PersonDto> personsList =
            await _personListRepository.fetchPersonsList();
        emit(PersonsListFetched(personsList));
      } catch (error) {
        emit(FailedFetchingPersonsList());
        rethrow;
      }
    });
    on<FetchPerson>((event, emit) async {
      emit(LoadingPerson());
      try {
        List<PersonDto> personsList =
            await _personListRepository.fetchPersonsList();
        PersonDto? personDto;
        try {
          personDto =
              personsList.firstWhere((person) => person.id == event.personId);
        } catch (personNotFound) {
          emit(PersonNotExists());
          return;
        }
        emit(PersonFetched(personDto));
      } catch (error) {
        emit(FailedFetchingPerson());
        rethrow;
      }
    });
  }
}
