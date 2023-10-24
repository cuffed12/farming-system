RegisterServerEvent('veuqx:farming')
AddEventHandler('veuqx:farming', function(item)
    if sv_config.typ == 'esx' then
        if ESX.GetPlayerFromId(source) then
            ESX.GetPlayerFromId(source).addInventoryItem(item, 1)
        end
    elseif sv_config.typ == 'qbcore' then
        if QBCore.Functions.GetPlayer(source) then
            QBCore.Functions.GetPlayer(source).AddItem(item, 1)
        end
    elseif sv_config.typ == 'custom' then
        -- Add your code self
        --print('hi')
    end
    if sv_config.discord.debug then
        if sv_config.language == 'de' then
            print('Spieler '..GetPlayerName(source)..' hat 1 '..item ..' gesammelt.')
        elseif sv_config.language == 'en' then
            print('Player '..GetPlayerName(source)..' collected 1 '..item)
        end
    end
    discordembed = {
        {
            ['color'] = tonumber(sv_config.discord.color),
            ['title'] = sv_config.discord.embed.titel,
            ['description'] = GetPlayerName(source).. ' hat ein **Item** gesammelt:', -- Change this to you language
            ['thumbnail'] = {
                ['url'] = sv_config.discord.embed.avatar
            },
            ['fields'] = {
                {
                    ['name'] = 'ID',
                    ['value'] = source,
                    ['inline'] = true
                },
                {
                    ['name'] = 'Item',
                    ['value'] = item,
                    ['inline'] = true
                },
            },
            ['footer'] = {
               ['text'] = sv_config.discord.embed.footer,
                ['icon_url'] = sv_config.discord.embed.logo
            }
        }
    }
    PerformHttpRequest(sv_config.discord.webhook, function(err, text, headers) end, 'POST', json.encode({username = sv_config.discord.embed.username, avatar_url = sv_config.discord.embed.avatar, embeds = discordembed}), {['Content-Type'] = 'application/json'})
end)