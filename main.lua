local Device = require("device")
local InputContainer = require("ui/widget/container/inputcontainer")
local NetworkMgr = require("ui/network/manager")
local _ = require("gettext")

local generateImage = require("generate_image")

local VisualizeBook = InputContainer:new {
  name = "visualize_book",
  is_doc_only = true,
}

function VisualizeBook:init()
  self.ui.highlight:addToHighlightDialog("visualize_book_gpt", function(_reader_highlight_instance)
    return {
      text = _("Generate Image"),
      enabled = Device:hasClipboard(),
      callback = function()
        NetworkMgr:runWhenOnline(function() generateImage(self.ui, _reader_highlight_instance.selected_text.text) end)
      end,
    }
  end)
end

return VisualizeBook
