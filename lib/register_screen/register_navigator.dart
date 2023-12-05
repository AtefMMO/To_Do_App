abstract class RegisterNavigator{
  //actions between view and viewmodel
  void showLoading();
  void hideLoading();
  void changeScreen(String screenRouteName);
  void showMessage(String message);
}