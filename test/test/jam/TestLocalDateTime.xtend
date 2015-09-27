package test.jam

import org.junit.Test
import java.time.LocalDateTime

class TestLocalDateTime {
    @Test
    def void testTodayDate(){
        println(LocalDateTime.now)
    }
    
}