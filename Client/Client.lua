RegisterNUICallback("exit", function(data, cb)
    isUiOpen = false
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    cb({})
end)

RegisterCommand('openemote', function()
    isUiOpen = true
    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)

    local Table = {
        { label = 'Gestos', sub = GetEmoteTable(DP.Emotes, 'e') }, 
        { label = 'Formas de caminar', sub = GetEmoteTable(DP.Walks, 'walk') },   
        { label = 'Compartidas', sub = GetEmoteTable(DP.Shared, 'nearby') }, 
        { label = 'Bailes', sub = GetEmoteTable(DP.Dances, 'e') }, 
        { label = 'Objetos', sub = GetEmoteTable(DP.PropEmotes, 'e') }, 
    }

    SendNUIMessage({
        action = 'open',
        list = Table
    })
end)
RegisterNUICallback('clear', function()
    ClearPedTasks(PlayerPedId())
    EmoteCancel()
end)
CreateThread(function()
    while true do
        if isUiOpen then
            for _, control in ipairs({1, 2, 30, 31, 32, 33, 34, 35, 21, 22, 23, 24, 25, 44, 45}) do
                EnableControlAction(0, control, true)
            end
            DisableControlAction(0, 24, true) -- Ataque
            DisableControlAction(0, 25, true) -- Apuntar
            DisableControlAction(0, 140, true) -- Golpe suave
            DisableControlAction(0, 141, true) -- Golpe fuerte
            DisableControlAction(0, 142, true) -- Patada
            DisableControlAction(0, 257, true) -- Golpe melee
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)

            Wait(0)
        else
            Wait(500) 
        end
    end
end)


RegisterNUICallback("close", function()
    SendNUIMessage({
        action = "HideEmotes",
    })
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    print('close')
end)


function GetEmoteTable(Table, Prefix)
    local Emotes = {}

    if Prefix ~= 'walk' then 
        for i,v in pairs(Table) do 
            table.insert(Emotes, { label = v[3], value = i, prefix = Prefix })
        end
    else
        for i,v in pairs(Table) do 
            table.insert(Emotes, { label = i, value = i, prefix = Prefix })
        end
    end

    return Emotes
end 

RegisterNUICallback('execute', function(data) 
    ExecuteCommand(data.anim.prefix..' '..data.anim.value)
end)

RegisterKeyMapping('openemote', 'Abrir/Cerrar Animaciones', 'keyboard', 'F3')