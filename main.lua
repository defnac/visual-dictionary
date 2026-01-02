local InputContainer = require("ui/widget/container/inputcontainer")
local NetworkMgr = require("ui/network/manager")

local VisualDictionary = InputContainer:new {
    name = "visual_dictionary",
}

function VisualDictionary:onDictButtonsReady(dict_popup, dict_buttons)
    local plugin_buttons = {}

    table.insert(plugin_buttons, {
        id = "show_image",
        font_bold = true,
        text = "Show image",
        callback = function()
            NetworkMgr:runWhenOnline(function()
                -- searchImage
            end
            )
        end
    })

    table.insert(dict_buttons, plugin_buttons)
end

return VisualDictionary
