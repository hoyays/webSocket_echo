package com.site.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import com.site.handler.ReplyEchoHandler;

@Configuration
@EnableWebSocket
public class sbpWebSocketConfig implements WebSocketConfigurer{
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		
		//pure WebSocket
//		registry.addHandler(new ReplyEchoHandler(), "/replyEcho").setAllowedOrigins("*");
		
		
		
		//SockJS
		registry.addHandler(new ReplyEchoHandler(), "/replyEcho").withSockJS();
		
	}

}//class
