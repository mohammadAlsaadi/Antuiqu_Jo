import 'package:antique_jo/data/add_edit/add_edit_models/car/cars_info.dart';
import 'package:antique_jo/data/customer_home/customer_home_repository/customer_home_repository.dart';
import 'package:antique_jo/data/login_register/login_register_repository/customer_register_repository/customer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'customer_home_event.dart';
part 'customer_home_state.dart';

class CustomerHomeBloc extends Bloc<CustomerHomeEvent, CustomerHomeState> {
  CustomerHomeBloc() : super(CustomerHomeInitial()) {
    on<AllCarFitchEvent>(_loadAllCars);
    on<BookCarEvent>(_bookCar);
    on<MyCarFitchEvent>(_loadCustomerBookedCars);
  }
}

Future<void> _loadAllCars(
    AllCarFitchEvent event, Emitter<CustomerHomeState> emit) async {
  emit(LoadingCarsState());

  List<CarInfo> carsLoad = await CustomerHomeRepository.loadAllCars();

  if (carsLoad.isNotEmpty) {
    emit(LoadedCarsState(carsLoad));
  } else {
    emit(FailureLoadedCarsState());
  }
}

Future<void> _loadCustomerBookedCars(
    MyCarFitchEvent event, Emitter<CustomerHomeState> emit) async {
  emit(LoadingCarsState());

  List<CarInfo> customerCars =
      await CustomerHomeRepository.loadCustomerBookedCars();
  emit(LoadedCarsState(customerCars));
}

Future<void> _bookCar(
    BookCarEvent event, Emitter<CustomerHomeState> emit) async {
  String? customerUID =
      await LoginRegistrationCustomerRepository.getCustomerUID(
          key: 'currentUID');

  await CustomerHomeRepository.bookCarUpdate(
      event.carModel.carUUID, customerUID!, event.carModel);

  bool isUpdated = await CustomerHomeRepository.bookCarUpdate(
      event.carModel.carUUID, customerUID, event.carModel);
  if (isUpdated) {
    emit(BookCarSuccessedState());
  } else {
    emit(BookCarFailedState());
  }
}
