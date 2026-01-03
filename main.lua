local InputContainer = require("ui/widget/container/inputcontainer")
local NetworkMgr = require("ui/network/manager")
local https = require("ssl.https")
local ltn12 = require("ltn12")
local json = require("json")
local socket_url = require("socket.url")
local ImageViewer = require("image_viewer")
local UIManager = require("ui/uimanager")

local VisualDictionary = InputContainer:new {
    name = "visual_dictionary",
    image_urls = {},
}

function VisualDictionary:fetchImageUrls(term)
    self.image_urls = {}

    local search_term = socket_url.escape(term)
    local url = "https://en.wikipedia.org/w/api.php?action=query&generator=search&gsrsearch=" .. search_term .. "&prop=pageimages&pithumbsize=600&format=json"

    local response_body = {}
    local _, code = https.request{
        url = url,
        sink = ltn12.sink.table(response_body)
    }

    if code == 200 then
        local data = json.decode(table.concat(response_body))
        local new_urls = {}

        if data.query and data.query.pages then
            for _, page_data in pairs(data.query.pages) do
                if page_data.thumbnail and page_data.thumbnail.source then
                    table.insert(new_urls, page_data.thumbnail.source)
                end
            end
        end

        self.imageUrls = new_urls
    end
end

function VisualDictionary:onDictButtonsReady(dict_popup, dict_buttons)
    local plugin_buttons = {}

    table.insert(plugin_buttons, {
        id = "show_image",
        font_bold = true,
        text = "Show image",
        callback = function()
            NetworkMgr:runWhenOnline(function()
               -- instanciate imageviewer with image, but first must define logic to fetch the image and save it in some temp folder or something. 
            end
            )
        end
    })

    table.insert(dict_buttons, plugin_buttons)
end


return VisualDictionary
