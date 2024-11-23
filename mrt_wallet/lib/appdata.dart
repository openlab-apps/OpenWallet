//修改处
String doublebit(String str, int bitnum) {
  if (str.contains(".")) {
    String str1 = str.split(".")[0];
    String str2 = str.split(".")[1];
    if (str2.length > bitnum) {
      str2 = str2.substring(0, bitnum);
    }
    str = "$str1.$str2";
  }
  return str;
}
