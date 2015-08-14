package org.eclipse.xtend;

@SuppressWarnings("all")
public class HelloAppender {
  public static String greet(final String str, final String str2) {
    String _string = new String(str);
    String _plus = (_string + " ");
    return (_plus + str2);
  }
}
