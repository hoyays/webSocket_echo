package com.site.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ReplyEchoHandler extends TextWebSocketHandler{

	List<WebSocketSession> sessions = new ArrayList<>();

	
	//WebSocket에 연결되었을 때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("afterConnectionEstablished : "+session);
		sessions.add(session);
	}
	
	
	//WebSocket이 메세지를 받았을 때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("handleTextMessage : "+session+" : "+message);
		String senderId = session.getId();
		for(WebSocketSession sess : sessions) {
			sess.sendMessage(new TextMessage(senderId+" : "+message.getPayload()));
		}
	}
	
	
	//WebSocket 연결이 끊어졌을 때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("afterConnectionClosed : "+session+" : "+status);
	}
	
	
}//class
