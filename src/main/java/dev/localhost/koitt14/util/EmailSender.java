package dev.localhost.koitt14.util;

import java.io.IOException;

import com.sendgrid.*;
import com.sendgrid.helpers.mail.Mail;
import com.sendgrid.helpers.mail.objects.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class EmailSender {
  @Autowired
  ApiInfo apiInfo;
 
  public void send (String mailTo, String subject, String mailContent) throws IOException {
    String mailFrom = apiInfo.getSendgridEmail();
    String key = apiInfo.getSendgridKey();

    Email from = new Email(mailFrom);
    Email to = new Email(mailTo);

    Content content = new Content("text/html", mailContent);

    Mail mail = new Mail(from, subject, to, content);

    SendGrid sendgrid = new SendGrid(key);
    Request request = new Request();

    request.setMethod(Method.POST);
    request.setEndpoint("mail/send");
    request.setBody(mail.build());

    sendgrid.api(request);
  }
}
