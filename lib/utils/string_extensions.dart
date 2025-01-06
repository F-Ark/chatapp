extension NameAndSurnameFirstCharecterExtension on String {
  String getInitials() {
    return split(' ')
        .map((nameOrSurname) =>
            nameOrSurname.isNotEmpty ? nameOrSurname[0].toUpperCase() : '',)
        .join();
  }
}

/// İki UserId yi birleştirirken küçük olanı önce yazmak için kullanılır.
extension CombineUidExtension on String {
  String combineUid({required String otherUid}) {
    return (compareTo(otherUid) < 0) ? this + otherUid : otherUid + this;
  }
}

/// Srting olan birleşik UserId yi verilen currentUserId ile ayırır.
extension SeparateUidExtension on String {
  String separateUid({
    required String currentUserId,
  }) {
    final uIdLength = length ~/ 2;
    return (currentUserId == substring(0, uIdLength - 1))
        ? substring(uIdLength, length - 1)
        : substring(0, uIdLength - 1);
  }
}
