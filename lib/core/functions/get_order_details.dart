String getPaymentMethod(String code) {
  if (code == "0") {
    return "نقدياً عند التوصيل";
  } else {
    return "الدفع بواسطة البطاقة";
  }
}

String getOrderType(String code) {
  if (code == "0") {
    return "توصيل";
  } else {
    return "تلقي يدوياَ";
  }
}

String getOrderState(String code) {
  if (code == "none") {
    return "بإنتظار الموافقة";
  } else if (code == "1") {
    return "قيد التحضير";
  } else {
    return "none";
  }
}
