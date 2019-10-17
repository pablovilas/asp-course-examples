package com.country.timezone;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Promise;
import io.vertx.core.http.HttpServerRequest;
import io.vertx.core.json.JsonObject;

import java.time.LocalDateTime;
import java.time.ZoneId;

public class CountryTimeService extends AbstractVerticle {

  @Override
  public void start(Promise<Void> startPromise) throws Exception {
    vertx.createHttpServer().requestHandler(req -> {
      String zone = req.getParam("tz");
      if (zone != null) {
        try {
          ZoneId zoneId = ZoneId.of(zone);
          LocalDateTime convertedDateTime = LocalDateTime.now(zoneId);
          success(req, new JsonObject()
            .put("time", convertedDateTime.toString()));
        } catch (Exception ex) {
          error(req, new JsonObject()
            .put("code", "Wrong argument value")
            .put("description", "The \"tz\" parameter with value " + zone + " is not a valid zone")
          );
        }
      } else {
        error(req, new JsonObject()
          .put("code", "Missing argument")
          .put("description", "The \"tz\" parameter is missing")
        );
      }
    }).listen(8081, http -> {
      if (http.succeeded()) {
        startPromise.complete();
        System.out.println("Country service started!. http://localhost:8081?tz=America/Montevideo");
      } else {
        startPromise.fail(http.cause());
      }
    });
  }

  private void success(HttpServerRequest req, JsonObject data) {
    req.response()
      .putHeader("Content-type", "application/json")
      .setStatusCode(200)
      .end(data.encode());
  }

  private void error(HttpServerRequest req, JsonObject data) {
    req.response()
      .putHeader("Content-type", "application/json")
      .setStatusCode(400)
      .end(data.encode());
  }

}
