package com.jam.models;

import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public class Greeting {
  private final long id;
  
  private final String content;
  
  public Greeting(final long id, final String content) {
    super();
    this.id = id;
    this.content = content;
  }
  
  @Override
  @Pure
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + (int) (this.id ^ (this.id >>> 32));
    result = prime * result + ((this.content== null) ? 0 : this.content.hashCode());
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
    Greeting other = (Greeting) obj;
    if (other.id != this.id)
      return false;
    if (this.content == null) {
      if (other.content != null)
        return false;
    } else if (!this.content.equals(other.content))
      return false;
    return true;
  }
  
  @Override
  @Pure
  public String toString() {
    ToStringBuilder b = new ToStringBuilder(this);
    b.add("id", this.id);
    b.add("content", this.content);
    return b.toString();
  }
  
  @Pure
  public long getId() {
    return this.id;
  }
  
  @Pure
  public String getContent() {
    return this.content;
  }
}
