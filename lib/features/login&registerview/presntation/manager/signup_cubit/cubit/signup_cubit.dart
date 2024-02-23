import 'package:bloc/bloc.dart';
import 'package:graduation/core/utiles/api_services.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  String? firstName;
  String? lastName;
  String? password;
  String? email;

  void postPasswardAndEmail(
      {required String email, required String password}) async {
    emit(SignupLooding());
    try {
      dynamic data = await ApiServices().post(
          url: 'https://acedmix.azurewebsites.net/index.php?type=STD&fun=Login',
          body: {
            'FirstName': firstName,
            'LastName': lastName,
            'Email': email,
            'Password': password
          });

      emit(SignupSucssess(data: data));
    } catch (e) {
      emit(SignupFailuer(error: 'there is an error please try again'));
    }
  }
}
