Button = {}
function Button:new (o)
      o = o or {}   -- create object if user does not provide one
      setmetatable(o, self)
      self.__index = self
      return o
end



function initializeText(scriptName, scriptText)
	local text = "";
	local cnt = 0;
	for word in string.gmatch(scriptText, "%S+") do 
		if(cnt ~= 0) then
			text = text.." ";
		end
		cnt = cnt +1;
		local temp = _G[word];
		if(temp) then
			text = text ..temp;
		end
	end
	if(string.gsub(text , "%s", "") ~= '')then
		setText(scriptName, text);
	end
end


function replace(textForReplace, replacedFrom, replacedTo)
	return string.gsub(textForReplace , replacedFrom, replacedTo);
end

function getSize(tbl)
	local cnt = 0;
	for k,v in pairs(tbl) do	
		cnt = cnt +1;
	end
	return cnt;
end


function splitValues(val)
	return string.gmatch(val, "%S+");
end

function round(value, afterDot)
	return string.format("%."..afterDot.."f", value);
end
