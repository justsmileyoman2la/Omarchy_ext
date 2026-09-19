local mp = require 'mp'

local volume_file = mp.command_native({"expand-path", "~~/volume.conf"})
local saved_volume = nil
local saved_mute = nil

function save_volume()
    local volume = mp.get_property("volume")
    local mute = mp.get_property("mute")
    local f = io.open(volume_file, "w")
    if f then
        f:write("volume=" .. volume .. "\n")
        f:write("mute=" .. tostring(mute) .. "\n")
        f:close()
    end
end

function load_volume()
    local f = io.open(volume_file, "r")
    if f then
        for line in f:lines() do
            local key, value = line:match("^(%w+)=(.+)$")
            if key == "volume" then
                saved_volume = value
            elseif key == "mute" then
                saved_mute = value
            end
        end
        f:close()
    end
end

function apply_volume()
    if saved_volume then
        mp.set_property_number("volume", tonumber(saved_volume))
    end
    if saved_mute then
        mp.set_property_bool("mute", saved_mute == "true")
    end
end

-- Загрузить сохранённые значения
load_volume()

-- Применить при старте
apply_volume()

-- Применить ДО загрузки каждого нового файла
mp.register_event("start-file", apply_volume)

-- Сохранить при закрытии
mp.register_event("shutdown", save_volume)
