package com.jam.templates

import org.eclipse.xtend.lib.annotations.Data

@Data
class HelloFonta implements Template{
	override String content(){ '''
	<html>
		<body>
		«FOR it : 1..10»
		<div>Hello Fonta Hello!!!</div>
		«ENDFOR»
		</body>
	</html>
	'''
	}
}