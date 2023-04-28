part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Status status;
  final String errorMessage;
  final UserData userData;
  final List<Entities> entitiesList;
  const HomeState._({
    required this.errorMessage,
    required this.userData,
    required this.status,
    required this.entitiesList,
  });

  HomeState.initial()
      : this._(
          status: Status.initial,
          errorMessage: '',
          userData: UserData(),
          entitiesList: [],
        );

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        userData,
        entitiesList,
      ];

  HomeState copyWith({
    Status? status,
    String? errorMessage,
    UserData? userData,
    List<Entities>? entitiesList,
  }) {
    return HomeState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userData: userData ?? this.userData,
      entitiesList: entitiesList ?? this.entitiesList,
    );
  }
}
