package dev.localhost.koitt14.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class ApiInfo {
  @Value("${twilio.sid}")
  private String twilioSid;

  @Value("${twilio.token}")
  private String twilioToken;

  @Value("${twilio.phone}")
  private String twilioPhone;

  @Value("${sendgrid.key}")
  private String sendgridKey;

  @Value("${sendgrid.email}")
  private String sendgridEmail;

  public String getTwilioSid() {
    return twilioSid;
  }

  public String getTwilioToken() {
    return twilioToken;
  }

  public String getTwilioPhone() {
    return twilioPhone;
  }

  public String getSendgridKey() {
    return sendgridKey;
  }

  public String getSendgridEmail() {
    return sendgridEmail;
  }
}
