<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Hello</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
		<script type="text/javascript">
		
		
			//WebSocket, SockJS 방식에서 사용하는 JQuery
			/* $(document).ready(function(){
				
				//connectWS();   //pure WebSocket
				connectSockJS();   //SockJS 방식
				
				
				$("#btnSend").on("click", function(evt){
					evt.preventDefault();
					
					if(socket.readyState !== 1){
						return;
					}
					
					var msg = $("#msg").val();
					socket.send(msg);
				});
			});//jQuery */
			
			
			
			
			//STOMP 방식에서 사용하는 JQuery
			$(document).ready(function(){
				connectStomp();
				
				
				$("#btnSend").on("click", function(evt){
					evt.preventDefault();
					
					if(!isStomp && socket.readyState !== 1){
						return;
					}
					
					
					//Stomp으로 보내는 메세지 형태는 Json을 가장 많이 사용한다.
					var msg = $("#msg").val();
					console.log("mmmmmmmmmmm>>", msg);
					if(isStomp){
						socket.send("/TTT", {}, JSON.stringify({id:"user11", msg:msg}));
					}else {
						socket.send(msg);
					}
					
				});
				
			})//jQuery
		
		
		
			//변수선언
			var socket = null;
			var isStomp = false;
			
			
			//pure WebSocket
			function connectWS(){
				console.log("connectWS() 입니다!");
				var ws = new WebSocket("ws://localhost:8001/replyEcho");
				socket = ws;
				
				ws.onopen = function(){
					console.log("Info : connection opened.");
					//1초마다 커넥션에 연결한다.
					//setTimeout(function(){ connectWS();}, 1000);
				};
				
				ws.onmessage = function(event){
					console.log("Received Message : "+event.data);
				};
				
				ws.onclose = function(event){
					console.log("Info : connection closed.");
				};
				
				ws.error = function(err){
					console.log("Error : "+err)
				};
			}//connectWS()
		
			
			//SockJS 방식
			function connectSockJS(){
				console.log("connectSockJS() 입니다!");
				var sock = new SockJS("/replyEcho");
				socket = sock;
				
				//SockJS에서는 소켓이 열리면 onmessage와 onclose가 동작한다. 즉, onopen안에 구현했다.
				sock.onopen = function(){
					console.log("SockJS opened.");
					sock.send("hi~!");
					
					sock.onmessage = function(event){
						console.log("SockJS, Received Message : "+event.data);
					}
					
					sock.onclose = function(event){
						console.log("SockJS closed.");
					}
				}
			}//connectSockJS()
			
			
			
			//STOMP 방식
			function connectStomp(){
				
				var sock = new SockJS("/stompTest");   //@configuration의 Endpoint
				var client = Stomp.over(sock);         //STOMP는 SockJS기반에 운영된다. 즉, SockJS위에 STOMP를 태워서 사용한다.
				isStomp = true;
				socket = client;
				
				client.connect({}, function(){
					console.log("STOMP opened.");
					
					//Controller's MessageMapping, header, message(자유형식, 보통 Json을 많이 사용함)
					//STOMP방식은 WebSocket과 바로 연결되지 않고, Controller로 보내서 처리한다.
					//STOMP의 메세지 전송방식은 매개변수가 여러개이니 꼭 유념하자!
					client.send("/TTT", {}, "msg : STOMP start!");
					
					//해당 토픽을 구독한다!
					client.subscribe("/topic/message", function(event){
						console.log("!!!!!!!!!!!!event>>", event);
					});
				});
				
				
				
				
			}//connectStomp()
		
		
		</script>
	</head>
	<body>
		테스트
		<div id="test">
			<input type="text" id="msg">
			<input type="button" id="btnSend" value="전송">
		</div>
	</body>
</html>