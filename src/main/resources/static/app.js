var stompClient = null;

function setConnected(connected){
	
	$("#connect").prop("disabled", connected);   //prop(propertyName, value) ==> 속성값을 추가
	$("#disconnect").prop("disabled", !connected);
	
	if(connected){
		$("#conversation").show();
	}else {
		$("#conversation").hide();
	}
	$("#greetings").html("");
	
}//setConnected()


function connect(){
	//Stomp는 구독방식이므로, 해당 topic를 구독중인(바라보는) user에게만 메세지가 전송된다.
	var socket = new SockJS("/gs-guide-websocket");   //SockJS 1개를 연다.
	stompClient = Stomp.over(socket);   //stomp는 SockJS기반에서 움직일 수 있으므로, Stomp를 SockJS에 태운다.
	
	stompClient.connect({}, function(frame){
		setConnected(true);
		console.log("Connected : "+frame);
		stompClient.subscribe("topic/greetings", function(greeting){
			showGreeting(JSON.parse(greeting.body).content);
		});
	});
	
}//connect()



function disconnect(){
	
	if(stompClient !== null){
		stompClient.disconnect();
	}
	setConnected(false);
	console.log("Disconnected");
	
}//disconnect()



function sendName(){
	stompClient.send("/app/hello", {}, JSON.stringify({"name":$("#name").val()}));
}//sendName()



function showGreeting(message){
	$("#greetings").append("<tr><td>" + message + "</td></tr>");
}//showGreeting()



$(function(){
	
	
	$("form").on("submint", function(e){
		e.preventDefault();
	});
	
	$("#connect").click(function(){
		connect();
	});
	$("#disconnect").click(function(){
		disconnect();
	});
	$("#send").click(function(){
		sendName();
	});
	
});//jQuery







