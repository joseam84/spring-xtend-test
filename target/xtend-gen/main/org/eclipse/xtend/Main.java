package org.eclipse.xtend;

import org.eclipse.xtend.HelloAppender;
import org.eclipse.xtext.xbase.lib.InputOutput;
import org.junit.Test;

@SuppressWarnings("all")
public class Main {
  @Test
  public void testAppend() {
    String _greet = HelloAppender.greet("Hello", "Mister");
    InputOutput.<String>println(_greet);
  }
}
