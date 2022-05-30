Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
        --	连接网络会话开始触发事件
		if NetworkIsSessionStarted() then
            TriggerServerEvent('nz_antinet:load')
			return
		end
	end
end)


--	接收数据并返回
RegisterNetEvent('nz_antinet:data')
AddEventHandler('nz_antinet:data', function ()
	TriggerServerEvent('nz_antinet:data')
end)
