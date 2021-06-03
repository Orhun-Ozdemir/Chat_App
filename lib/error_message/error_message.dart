class ErrorMessage {
  static String translatemessage(String message) {
    switch (message) {
      case "email-already-in-use":
        return " Bu email adresi zaten kullanılıyor";
      case "invalid-email":
        return "Geçersiz Email";
    }
  }
}
