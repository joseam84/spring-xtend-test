package org.eclipse.xtend

import org.junit.Test
import static extension org.eclipse.xtend.HelloAppender.*

class HelloAppender {
	def static greet(String str, String str2){
		new String(str) +" "+ str2
	}
}

class Main{
	@Test def void testAppend(){
		println("Hello".greet("Mister"))
	}
}