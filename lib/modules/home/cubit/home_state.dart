part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Status status;
  final String errorMessage;
  final UserData userData;
  final List<Entities> entitiesList;
  final int page;
  final int totalPages;
  final ScrollController scrollController;

  const HomeState._({
    required this.errorMessage,
    required this.userData,
    required this.status,
    required this.entitiesList,
    required this.page,
    required this.totalPages,
    required this.scrollController,
  });

  HomeState.initial()
      : this._(
          status: Status.initial,
          errorMessage: '',
          userData: UserData(),
          entitiesList: [],
          page: 1,
          totalPages: 1,
          scrollController: ScrollController(),
        );

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        userData,
        entitiesList,
        page,
        totalPages,
        scrollController,
      ];

  HomeState copyWith(
      {Status? status,
      String? errorMessage,
      UserData? userData,
      List<Entities>? entitiesList,
      int? page,
      int? totalPages,
      ScrollController? scrollController}) {
    return HomeState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userData: userData ?? this.userData,
      entitiesList: entitiesList ?? this.entitiesList,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      scrollController: scrollController ?? this.scrollController,
    );
  }
}
