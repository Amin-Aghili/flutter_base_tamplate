String? usernameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  if (value.length != value.replaceAll(' ', '').length) {
    return 'Username must not contain any spaces';
  }
  if (int.tryParse(value[0]) != null) {
    return 'Username must not start with a number';
  }
  if (value.length <= 2) {
    return 'Username should be at least 3 characters long';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  if (value.length != value.replaceAll(' ', '').length) {
    return 'Password must not contain any spaces';
  }
  // if (int.tryParse(value[0]) != null) {
  //   return 'Username must not start with a number';
  // }
  if (value.length <= 2) {
    return 'Password should be at least 3 characters long';
  }
  return null;
}
