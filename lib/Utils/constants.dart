class Constants {
  // ignore: non_constant_identifier_names
  static String TOP_HEADLINES_URL =
      "http://newsapi.org/v2/top-headlines?country=my&category=nation&apiKey=5d01468df4e64020a5d4f75c83d0b746";

  static String headlinesFor(String keyword) {
    return "https://newsapi.org/v2/everything?q=$keyword&apiKey=5d01468df4e64020a5d4f75c83d0b746";
  }
}
