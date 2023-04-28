part of 'entity_cubit.dart';

class EntityState extends Equatable {
  final Status status;
  final String errorMessage;
  const EntityState._({
    required this.errorMessage,
    required this.status,
  });

  const EntityState.initial()
      : this._(
          status: Status.initial,
          errorMessage: '',
        );

  @override
  List<Object?> get props => [
        status,
        errorMessage,
      ];

  EntityState copyWith({
    Status? status,
    String? errorMessage,
  }) {
    return EntityState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
