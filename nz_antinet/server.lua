local Player_Data = {}
local Players = {}


--	添加信息
AddEventHandler('playerJoining', function(name, setCallback, deferrals)
    local _source = source
	Player_Data[_source] = {
		id = GetGameID(_source),
		num = 0,
		state = false,
	}
	table.insert(Players, _source)
    print('id:'.._source)
end)

--	负责检查
RegisterServerEvent('nz_antinet:data')
AddEventHandler('nz_antinet:data', function()
	local _source = source
	if Player_Data[_source].num > 2 then
		DropPlayer(_source, '由于系统检测到你断网并重连行为,试图存在卡BUG行为')
	elseif Player_Data[_source].num > 1 then
		Player_Data[_source].num = Player_Data[_source].num - 1
	elseif Player_Data[_source].num > 0 then
		Player_Data[_source].num = Player_Data[_source].num - 1
	end
end)


RegisterServerEvent('nz_antinet:load')
AddEventHandler('nz_antinet:load', function()
	local _source = source
	Player_Data[_source].state = true
end)

--	3秒一次
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		for k, v in ipairs(Players) do
        	if Player_Data[v].state then
				Player_Data[v].num = Player_Data[v].num + 1
				TriggerClientEvent('nz_antinet:data', v)
          	end
		end
	end
end)


--  获取游戏ID（R星）
function GetGameID(source)
    local license = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.match(v, "license:") then
            license = v
            break
        end
    end
    return license
end