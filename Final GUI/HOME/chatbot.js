        <!--_____________________________SCRIPT SECTION START_______________________________________________-->
        
		<script type="text/javascript">

			//________________________________SCRIPTING CHATBOT UI SECTION START_____________________________________

			function display_sendButton_Now(){document.getElementById('sendButton_id').style.visibility='visible'};
			function hide_sendButton_Now(){document.getElementById('sendButton_id').style.visibility='hidden'};
			function display_sendText_Now(){document.getElementById('sendText_id').style.visibility='visible';document.getElementById('sendText_id').focus();};
			function hide_sendText_Now(){document.getElementById('sendText_id').style.visibility='hidden';};
			function display_chatspace_Now(){document.getElementById('chatspace_id').style.display='block';};
			function hide_chatspace_Now(){document.getElementById('chatspace_id').style.display='none'};
			function display_chatlogo_Now(){document.getElementById('chatspace_logo_id').style.display='block';};
			function hide_chatlogo_Now(){document.getElementById('chatspace_logo_id').style.display='none';};
			function display_speechToTextButton_Now(){document.getElementById('speechToText_id').style.visibility='visible';};
			function hide_speechToTextButton_Now(){document.getElementById('speechToText_id').style.visibility='hidden';};
		
			//______________________________SCRIPTING CHATBOT UI SECTION END_______________________________________

			//______________________________SCRIPTING TEXT-TO-SPEECH SECTION START_________________________________
			
		    var voiceOptions = document.getElementById('voiceOptions');
			var volumeSlider = document.getElementById('volumeSlider');
			var rateSlider = document.getElementById('rateSlider');
			var pitchSlider = document.getElementById('pitchSlider');
			var voiceMap = [];
		
			function checkCompatibilty() 
			{
				if(!('speechSynthesis' in window)){
					alert('Your browser is not supported. If google chrome, please upgrade!!');
				}
			};

			checkCompatibilty();

			function loadVoices() 
			{
				var voices = speechSynthesis.getVoices();
				for (var i = 0; i < voices.length; i++) 
				{
					var voice = voices[i];
					var option = document.createElement('option');
					option.value = voice.name;
					option.innerHTML = voice.name;
					voiceOptions.appendChild(option);
					voiceMap[voice.name] = voice;
				};
			};

			window.speechSynthesis.onvoiceschanged = function(e)
			{
				loadVoices();
			};

			function speak (myText) 
			{
				var msg = new SpeechSynthesisUtterance();
				msg.volume = volumeSlider.value;
				msg.voice = voiceMap[voiceOptions.value];
				msg.rate = rateSlider.value;
				msg.Pitch = pitchSlider.value;
				msg.text = myText;
				window.speechSynthesis.speak(msg);
			};
            
            //______________________________SCRIPTING TEXT-TO-SPEECH SECTION END__________________________________

            //______________________________SCRIPTING COOKIE OPERATIONS SECTION START_____________________________

			function setCookie(cname, cvalue, exhours) 
			{
			    var d = new Date();
			    d.setTime(d.getTime() + (exhours * 60 * 1000));
			    var expires = "expires="+d.toUTCString();
			    document.cookie = cname + "=" + cvalue + ";" + expires + "path=https://weatherappneel.000webhostapp.com/RefreadBotNeel/index4[WithEncryption&Token].html";
			};

			function getCookie(cname) 
			{
			    var name = cname + "=";
			    var ca = document.cookie.split(';');
			    for(var i = 0; i < ca.length; i++) 
			    {
			        var c = ca[i];
			        while (c.charAt(0) == ' ') 
			        {
			            c = c.substring(1);
			        }
			        if (c.indexOf(name) == 0) 
			        {
			            return c.substring(name.length, c.length);
			        }
			    }
			    return "";
			};

			//______________________________SCRIPTING COOKIE OPERATIONS SECTION END_______________________________

			//_________________________________ENCRYPTING USER QUESTION START_____________________________________

			function encrypt(question)
			{
				plaintext=question;
				plaintext+="000";
   				plaintext=plaintext.toLowerCase();
			    var cipher='';
			    var charcode=0;

				for (var i=0; i < plaintext.length; i++) 
				{
			        charcode = (plaintext[i].charCodeAt()) + 1;
			        cipher += String.fromCharCode(charcode);
			    }
			    return cipher;
			};
			
			//_________________________________ENCRYPTING USER QUESTION END______________________________________

			//_________________________________DECRYPTING USER QUESTION START____________________________________

			function decrypt(answer)
			{
				cipher=answer;
			    var plaintext='';
			    var charcode=0;

			    for (var i=0; i<cipher.length; i++) 
			    {
			        charcode = (cipher[i].charCodeAt()) - 1;
			        plaintext += String.fromCharCode(charcode);
			    }
			    return plaintext;
			};

			//_________________________________DECRYPTING USER QUESTION END______________________________________

			//_____________________________MAKING INPUT FEILD - REQUIRED START___________________________________

			function required(inputtx) 
   			{
     			if (inputtx.length == 0)
      			{  	
         			return false; 
      			}  	
      			return true; 
    		}; 

    		//_____________________________MAKING INPUT FEILD - REQUIRED END_____________________________________

			//_________________________TRIGGER BUTTON CLICK ON 'ENTER' KEY PRESS START___________________________

			var input = document.getElementById("sendText_id");
			input.addEventListener("keyup", function(event) 
			{
			    event.preventDefault();
			    if (event.keyCode === 13) {
			        document.getElementById("sendButton_id").click();
			    }
			});

			//_________________________TRIGGER BUTTON CLICK ON 'ENTER' KEY PRESS END____________________________

			//__________________________SCRIPTING TO DISPLAY WHAT USER SAID START_______________________________

			function displayWhatUserSaid()
			{
				var UserMessage=document.getElementById("sendText_id").value;
				if(required(UserMessage)) 
				{
					var chatspaceVar = document.getElementById("chatspace_id");
                                        chatspaceVar.innerHTML += '<div class="userMessage">'+UserMessage+'</div>';
                                        chatspaceVar.scrollTop = chatspaceVar.scrollHeight;
				}
				else
				{
					//NO OPERATION
				}
			};

			//__________________________SCRIPTING TO DISPLAY WHAT USER SAID END_________________________________

			//___SCRIPTING TO DISPLAY WHAT CHATBOT SAID START____SENDING MESSAGE TO CHATBOT API___START_________

			function displayWhatChatbotSaid()
			{
				var UserMessage=document.getElementById("sendText_id").value;
				if(required(UserMessage)) 
				{                                    
					access_Chatbot_API();
				}
				else
				{
					alert("Your message is empty"); 
				}
			};

			//________________________________STANDARD RESPONSES SECTION START____________________________________

			Array.prototype.randomElement = function () 
			{
    			return this[Math.floor(Math.random() * this.length)]
			};

			myArray = ["Sorry, I guess the server is down. Not Refead's but mine!","Apologies, I think my backend has some problem. Talk to you later.","Really sorry, server's down I think. I'll go and wake him up. Can you please ping me after some time.","Very Sorry..But couldn't connect to the server","Sorry, my server's unreachable"];

			//________________________________STANDARD RESPONSES SECTION END_______________________________________

			//________________________________HITTING THE REST API SECTION START___________________________________

			function access_Chatbot_API()
			{
				var i=0;
				var ourRequest = new XMLHttpRequest();
				var UserMessage = document.getElementById("sendText_id").value;
					
				//Encrypting the question we are passing with 000 as a kind of VALIDITY
				//UserMessage = encrypt(UserMessage);
				
				UserMessage = encodeURIComponent(UserMessage).replace(/%20/g,'+');

				console.log("TOKEN:"+token+"|");
				console.log("SESSIONID"+sessionID);

				ourRequest.setRequestHeader("ChatbotAPIAuthToken", token); //Added on 7/7/18
				ourRequest.setRequestHeader("SessionID", sessionID); //Added on 7/7/18
				ourRequest.onreadystatechange = function() 
				{
					//Chatbot text
					if(ourRequest.readystate!=4 && ourRequest.status!=200)
					{
						if(i==0)
                   	    {
                          	i=1;
                      		var myRandomElement = myArray.randomElement();
                           	var ChatbotMessage= myRandomElement ; 
                      		var chatspaceVar = document.getElementById("chatspace_id")
                            chatspaceVar.innerHTML += '<div class="chatbotMessage">'+ChatbotMessage+'</div>';
                            speak(ChatbotMessage);
                            chatspaceVar.scrollTop=chatspaceVar.scrollHeight;
                            document.getElementById("sendText_id").value="";
                      	}
					}	
                    else
                    {
                       	//var ourData = this.responseText;
                      	if(i==0)
                      	{
                          	i=1;
                       	}
                        else if(i==1)
                       	{
                           	i=2;

                           	//Decrypting the answer we received from the server
                           	//var decrypted_answer=decrypt(ourRequest.responseText);

                            var chatspaceVar = document.getElementById("chatspace_id")
                            chatspaceVar.innerHTML += '<div class="chatbotMessage">'+ourRequest.responseText+'</div>';
                            speak(ourRequest.responseText);
                           	chatspaceVar.scrollTop=chatspaceVar.scrollHeight;
                           	document.getElementById("sendText_id").value="";
                       	}
                   	}
				};
				ourRequest.send();
			};

			//________________________________HITTING THE REST API SECTION END________________________________

			//___SCRIPTING TO DISPLAY WHAT CHATBOT SAID START____SENDING MESSAGE TO CHATBOT API___END_________

			//__________________________SCRIPTING - SPEECH RECOGNITION START__________________________________

			function speechToTextConversion()
			{			
				var SpeechRecognition = SpeechRecognition || webkitSpeechRecognition;
				var SpeechRecognitionEvent = SpeechRecognitionEvent || webkitSpeechRecognitionEvent;
				var recognition = new SpeechRecognition();
				var diagnostic = document.getElementById('sendText_id');
				var i=0;
                var j=0;
				recognition.continuous = true;
				recognition.lang = 'en-IN';
				recognition.interimResults = true;
				recognition.maxAlternatives = 1;

				//_____________________________SPEECH RECOGNITION EVENTS START________________________________
                
				document.getElementById("speechToText_id").onclick = function() 
				{
				    if(i==0)
				    {
				        if(j==0)
				        {
				            j=1;
				            document.getElementById('id01').style.display='block';
				        }
				        else
				        {
				            if(document.getElementById("Hindi").checked)
				            {
				                recognition.lang = 'hi-IN';
				            }
				            else if(document.getElementById("Gujarati").checked)
				            {
				                recognition.lang = 'gu-IN';
				            }
				            else if(document.getElementById("Bengali").checked)
				            {
				                recognition.lang = 'bn-IN';   
				            }
				            else if(document.getElementById("Kannada").checked)
				            {
				                recognition.lang = 'kn-IN';   
				            }
				            else if(document.getElementById("Malayalam").checked)
				            {
				                recognition.lang = 'ml-IN';   
				            }
				            else if(document.getElementById("Marathi").checked)
				            {
				                recognition.lang = 'mr-IN';   
				            }
				            else if(document.getElementById("Tamil").checked)
				            {
				                recognition.lang = 'ta-IN';   
				            }
				            else if(document.getElementById("Telugu").checked)
				            {
				                recognition.lang = 'te-IN';   
				            }
				            else if(document.getElementById("Urdu").checked)
				            {
				                recognition.lang = 'ur-IN';   
				            }
				            else
				            {
				                recognition.lang = 'en-IN';
				            }
				            document.getElementById("speechToText_id").style.background="red";
				            recognition.start();
				            i=1;
				        }
				    }
				    else
				    {
				         document.getElementById("speechToText_id").style.background="white";
				         recognition.stop();
				         i=0;
				    }
				}
				recognition.onresult = function(event) {
				  var last = event.results.length - 1;
				  var convertedText = event.results[last][0].transcript;
				  diagnostic.value = convertedText;
				  console.log('Confidence: ' + event.results[0][0].confidence);
				}
				recognition.onnomatch = function(event) {
				  diagnostic.value = 'I didnt recognise that.';
				}
				recognition.onerror = function(event) {
				  diagnostic.value = 'Error occurred in recognition: ' + event.error;
				}

				//_____________________________SPEECH RECOGNITION EVENTS END________________________________
			};

			//__________________________SCRIPTING - SPEECH RECOGNITION END__________________________________

		</script>

		<!--______________________________________SCRIPT SECTION END______________________________________-->