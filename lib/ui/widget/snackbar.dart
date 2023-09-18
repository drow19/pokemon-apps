import 'package:fluttertoast/fluttertoast.dart';
import 'package:pokedex/utils/commons/colors.dart';
import 'package:pokedex/utils/network/error_res.dart';

showSnackBar(
  message, {
  String? textButton,
  Function()? onClick,
  Duration duration = const Duration(seconds: 3),
}) {
  String errorMessage = '';
  int errorCode = 0;

  if (message is ErrorRes) {
    errorMessage = message.message;
    errorCode = message.code;
  } else {
    errorMessage = message;
  }

  Fluttertoast.showToast(
    msg: errorMessage,
    backgroundColor: kBlackColor1,
    textColor: kWhiteColor,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
  );
}
