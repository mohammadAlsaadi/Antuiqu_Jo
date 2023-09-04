part of 'detail_bloc.dart';

sealed class DetailEvent {}

class SendDataToDetailPageEvent extends DetailEvent {
  final int index;

  SendDataToDetailPageEvent({required this.index});
}
