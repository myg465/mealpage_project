package dev.localhost.koitt14.util;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SmsSender {
  @Autowired
  ApiInfo apiInfo;

  public void send (String sendTo, String text) {
    String twilioSid = apiInfo.getTwilioSid();
    String twilioToken = apiInfo.getTwilioToken();
    String twilioPhone = apiInfo.getTwilioPhone();

    Twilio.init(twilioSid, twilioToken);

    Message
      .creator(new PhoneNumber(sendTo), new PhoneNumber(twilioPhone), text)
      .create();
  }  
}
