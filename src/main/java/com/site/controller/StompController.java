package com.site.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.site.dto.Message;

@Controller
public class StompController {

	
	@MessageMapping("/TTTx")
	@SendTo("/topic/message")
	//매개변수가 String인 경우
	public String tttx(String message) throws Exception{
		System.out.println("Client => Controller가 받은 메세지 : "+message);
		
		return message;
	}
	
	
	
	//매개변수가 Json인 경우(가장 많이 사용하는 경우)
	@MessageMapping("/TTT")
	@SendTo("/topic/message")
	public Message ttt(Message message) throws Exception{
		System.out.println("Client => Controller가 받은 메세지 : "+message);
		
		return message;
	}
	
	
	
	
}//class
