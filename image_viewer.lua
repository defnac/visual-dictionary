local InputContainer = require("ui/widget/container/inputcontainer")
local FrameContainer = require("ui/widget/container/framecontainer")
local TextBoxWidget = require("ui/widget/textboxwidget")
local ImageWidget = require("ui/widget/imagewidget")
local Size = require("ui/size")
local Font = require("ui/font")
local Screen = require("device").screen

local ImageViewer = InputContainer:extend {
    name = "ImageViewer"
}

function ImageViewer:init()
    self.width = Screen:getWidth()
    self.height = Screen:getHeight()

    local content_widget
    local frame_width
    local frame_height

    if self.image_path then
        frame_width = Screen:getWidth() * 0.9
        frame_height = Screen:getHeight() * 0.9

        content_widget = ImageWidget:new {
            image = self.image_path,
            width = frame_width,
            height = frame_height,
            keep_aspect_ratio = true,
        }
    else
        frame_width = Screen:getWidth() * 0.6
        frame_height = Screen:getHeight() * 0.3

        content_widget = TextBoxWidget:new {
            text = "No results for " .. self.text .. ".",
            face = Font:getFace("cfont", 20),
            width = frame_width,
            alignment = "left",
        }
    end

    self.frame = FrameContainer:new {
        widget = content_widget,
        background = 1,
        bordersize = 2,
        padding = Size.padding.large,
        radius = Size.radius.window,
        width = frame_width,
        height = frame_height,
    }

    self[1] = self.frame
end

function ImageViewer:onClose()
    require("ui/uimanager"):close(self)
end

return ImageViewer
