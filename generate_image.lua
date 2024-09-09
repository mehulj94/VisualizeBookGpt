local JSON = require("json")
local ltn12 = require("ltn12")
local socket = require("socket")
local base64 = require('ffi/sha2')
local http = require("socket.http")
local socket_url = require("socket.url")
local socketutil = require("socketutil")
local UIManager = require("ui/uimanager")
local RenderImage = require("ui/renderimage")
local ImageViewer = require("ui/widget/imageviewer")
local _ = require("gettext")

local function getUrlContent(context_prompt, url, timeout, maxtime)
  local parsed = socket_url.parse(url)
  if parsed.scheme ~= "http" and parsed.scheme ~= "https" then
      return false, "Unsupported protocol"
  end
  if not timeout then timeout = 60 end

  local requestBodyTable = {
    prompt = context_prompt,
    steps = 10
  }

  local requestBody = JSON.encode(requestBodyTable)

  local sink = {}
  socketutil:set_timeout(timeout, maxtime or 60)
  local request = {
      url     = url,
      method  = "POST",
      headers = headers,
      source  = ltn12.source.string(requestBody),
      sink    = ltn12.sink.table(sink),
  }

  local code, headers, status = socket.skip(1, http.request(request))
  socketutil:reset_timeout()
  local content = table.concat(sink)

  if code == socketutil.TIMEOUT_CODE or
     code == socketutil.SSL_HANDSHAKE_CODE or
     code == socketutil.SINK_TIMEOUT_CODE
  then
      return false, code
  end
  if headers == nil then
      return false, "Network or remote server unavailable"
  end
  if not code or code < 200 or code > 299 then
      return false, "Remote server error or unavailable"
  end

  local response = json.decode(content)
  return true, response.images[1]
end

local function generateImage(ui, highlightedText)
  -- set your hosted model ip here
  local success, data = getUrlContent(highlightedText, "http://192.168.86.43:7860/sdapi/v1/txt2img")

  local img = base64.base64_to_bin(data)
  
  local bb = RenderImage:renderImageData(img, #img, true)

  local imgviewer = ImageViewer:new{
      image = bb,
      image_disposable = false,
      with_title_bar = true,
      fullscreen = true,
  }
  UIManager:show(imgviewer)
end

return generateImage