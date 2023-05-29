import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateToAndRemove(Widget widget, BuildContext context) =>
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ), (Route route) => false);

void navigateToAndSave(Widget widget, BuildContext context) =>
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ), (Route route) => true);

Widget DefaultTextFormField({
  String? hintText,
  required String? label,
  required TextInputType type,
  required TextEditingController? controll,
  void Function()? onclicked,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  void Function()? suffixpressed,
  void Function(String)? onSubmit,
  required String? Function(String?) validate,
}) =>
    TextFormField(
      validator: validate,
      controller: controll,
      obscureText: isPassword,
      keyboardType: type,
      onTap: onclicked,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        hintText: hintText,
        labelText: label,
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixpressed, icon: Icon(suffix))
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget defaultButton({
  Color color = Colors.blue,
  bool isUppercase = false,
  required Function() onpressed,
  required String text,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextButton(
          onPressed: onpressed,
          child: Text(
            '${isUppercase ? text.toUpperCase() : text}',
            style: TextStyle(color: Colors.white),
          )),
    );

Widget defaultTextButton(context,
        {required String? text, required Function()? onAction}) =>
    TextButton(
      onPressed: onAction,
      child: Text(text!.toUpperCase(),style: Theme.of(context).textTheme.displaySmall!.copyWith(fontFamily: 'BoldFont',color: Colors.blue),),
    );

void showToast(String message, ToastStates state) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: resolveToastStates(state),
    textColor: Colors.white,
    fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color resolveToastStates(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget buildSeperator([double padding = 5.0,Color color =Colors.grey]) => Padding(
    padding: EdgeInsets.symmetric(vertical: padding),
    child: Container(
      color: color,
      height: 1.0,
      width: double.infinity,
    ));

PreferredSizeWidget defaultAppBar(context,{String? text,required String buttonText,Function()? onPressed}) =>  AppBar(
            title:text == null ? null:Text(text),
            leading: IconButton(
                onPressed: () {

                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios_new)),
            actions: [
              defaultTextButton(context,
                  text: buttonText,
                  onAction: onPressed),
              const SizedBox(
                width: 15.0,
              )
            ],
          );