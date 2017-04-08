function login()
	setText("popupText", "Аутентификация");
	show("popup");
	connectionToServer(getText("login_input"), getText("password_input"));
end

function authentefication(val)
val = tonumber(val);
	if(val == 1) then
		setText("popupText", "Авторизация");
	elseif (val == 0) then
		setText("popupText", "Подключение не удалось");
	end
	return val;
end


function credentials(val)
	val = tonumber(val);
	if(val == 1) then
		setText("popupText", "Загрузка списка миров");
	elseif (val == 0) then
		setText("popupText", "Неверный логин или пароль");
	end
	return val;
end

function showRealms(val)
	local cnt = 0;
	local tempCnt=  0;
	for word in string.gmatch(val, "%S+") do 
		cnt = cnt +1;
	end
	initializeList("realms", cnt/4);
	cnt = 0;
		
	for word in string.gmatch(val, "%S+") do 
		  testStr = string.gsub(word, "%%20", " ")

		  tempCnt = tempCnt +1;
		  local text = "realmName";
		  local layout = "realm";
		  if(cnt >= 4) then
				text = text..math.floor(cnt/4);
				layout = layout..math.floor(cnt/4);
		  end
		  if(tempCnt == 2) then
			setText(text, testStr);
		  end
		  
		  if(tempCnt == 3) then
			_G[layout].ip = testStr;
		  end

		  if(tempCnt == 4) then
			_G[layout].port = testStr;
		  end
		  
		  cnt = cnt+ 1;
		  if((cnt % 4) == 0) then
			tempCnt = 0;
		  end
		  
	end
	hide("popup");
	show("realmsList");
end


function connectToWorld_Lua(self)
	connectionToWorld(self.ip, self.port);
end

function connectToWorld_Response(val)
	val = tonumber(val)
	if(val == 1) then
		setText("popupText", "Вход в мир");
	elseif (val == 0) then
		setText("popupText", "Подключение не удалось");
	end
	show("popup");
	hide("realmsList");
	return val;
end


function changeCharacter(id)
	getCharacterInfo(id);
end


function loadedCharacters(val)
	hide("popup");
	show("charactersList");
	hide("mainLayout");
	local cnt = 0;
	local tempCnt=  0;
	for word in string.gmatch(val, "%S+") do 
		cnt = cnt +1;
	end
	local hasCharacters = cnt/4 >= 1;
	initializeList("characters", cnt/4);
	cnt = 0;
			
	for word in string.gmatch(val, "%S+") do 
		  testStr = string.gsub(word, "%%20", " ")

		  tempCnt = tempCnt +1;
		  local text = "charName";
		  local textLevel = "charLevel";
		  local charIdName = "char";
		  if(cnt >= 4) then
				text = text..math.floor(cnt/4);
				textLevel = textLevel..math.floor(cnt/4);
				charIdName = charIdName ..math.floor(cnt/4);
		  end

		  if(tempCnt == 1) then
			_G[charIdName].charId = testStr;
		  end
		  
		  if(tempCnt == 2) then
			_G[charIdName].race = testStr;
		  end
		  
		  if(tempCnt == 3) then
			setText(text, testStr);
		  end
		  
		  if(tempCnt == 4) then
			setText(textLevel, testStr);
		  end

		  cnt = cnt+ 1;
		  if((cnt % 4) == 0) then
			tempCnt = 0;
		  end
	end
	
	if(hasCharacters == true) then
		changeCharacter(_G["char"].charId);
		setSelected("char");
	end
end

function connectToWorldCheckCreds(val)
	val = tonumber(val)
	if(val == 1) then
		setText("popupText", "Загрузка персонажей");
	elseif (val == 0) then
		setText("popupText", "Неверный пароль");
	end
	return val;
end

function loginCharacter_resp(val)
print(val)
end
