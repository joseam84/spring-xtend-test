package com.jam.templates;

import com.jam.templates.Template;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.IntegerRange;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public class HelloFonta implements Template {
  @Override
  public String content() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("<html>");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("<body>");
    _builder.newLine();
    {
      IntegerRange _upTo = new IntegerRange(1, 10);
      for(final Integer it : _upTo) {
        _builder.append("    ");
        _builder.append("<div>Hello Fonta Hello!!!</div>");
        _builder.newLine();
      }
    }
    _builder.append("    ");
    _builder.append("</body>");
    _builder.newLine();
    _builder.append("</html>");
    _builder.newLine();
    return _builder.toString();
  }
  
  @Override
  @Pure
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    return result;
  }
  
  @Override
  @Pure
  public boolean equals(final Object obj) {
    if (this == obj)
      return true;
    if (obj == null)
      return false;
    if (getClass() != obj.getClass())
      return false;
    HelloFonta other = (HelloFonta) obj;
    return true;
  }
  
  @Override
  @Pure
  public String toString() {
    ToStringBuilder b = new ToStringBuilder(this);
    return b.toString();
  }
}
