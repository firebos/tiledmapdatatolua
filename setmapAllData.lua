setmapAllData = {}
alldata = {};
local tabdata = {}

local function SaveTable()
	--alldata = data
    local mapdata = require("worldmap")
	if mapdata then
	local file = io.open("alldata.lua", "w");
		assert(file);
		if file then
			file:write("alldata = {}\n");
			file:write("alldata = \n");
			SaveTableContent(file,i, mapdata.layers);
			file:write("\nreturn alldata");
			file:close();
		end
	end
end
function SaveTableContent(file,index, obj)-- mapdata.layers[n].data(obj为导出的数据所在table，假设已知层级关系)
	file:write("{\n");
	for i=1,#(obj[1].data)do
		if not (i == 1) then 
			file:write(",");
		end
			local szType = type(obj[1].data[i]);
			--print(szType);
			if szType == "number" then
				--[[根据既定规则填充ID
				实验的图有四层
				最终图：
				scenemapid  = cityid(0-999)*10000000 + raceid(0-9)*1000000 
				+ dimian(0-9)*100000 + dibiao(0-99) *1000 + shijian(0-999)]]
				local num = obj[1].data[i]*10000000
				 + obj[2].data[i]*1000000
				 + obj[3].data[i]*100000
				 + obj[4].data[i]*1000
				 file:write(num);
			elseif szType == "string" then
				file:write(string.format("%q", obj));
				return
			else
				file:write(":");
				error("can't serialize a "..szType);
			end		
	end
	file:write("\n}");
end
--SaveTable(data);
SaveTable()
setmapAllData = {	
	SaveTable = SaveTable,
}
return setmapAllData

--[[function SaveTableContent(file, obj)
	if obj == "}" then
		--return
	end
	local szType = type(obj);
	print(szType);
	if szType == "number" then
		file:write(obj);
	elseif szType == "string" then
		--file:write(string.format("%q", obj));
		return
	elseif szType == "table" then
		--
		file:write("{\n");			
		for i, v in pairs(obj) do
				-- .type == "tilelayer" then
			  --file:write("[");
			  --SaveTableContent(file, i);
			 -- file:write("]=\n");
			  file:write(",");
			  SaveTableContent(file, v);
			 
			--end
		end
		--file:write("}\n");
	elseif szType == "boolean" then 
		file:write("false");
	else
	error("can't serialize a "..szType);
	end
end--]]