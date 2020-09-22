package com.asp.example

import io.quarkus.test.junit.QuarkusTest
import io.restassured.RestAssured.given
import org.junit.jupiter.api.Test

@QuarkusTest
class TodoControllerTest {

    @Test
    fun testHelloEndpoint() {
        given()
          .`when`().get("/todos")
          .then()
             .statusCode(200)
    }

}