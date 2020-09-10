local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
    if (string.find(data.Content, "妹子") ~= 1 and string.find(data.Content, "meizi") ~= 1) then
        return 1
    end
    
    local idx = math.random(0, 130)
    idx = string.format('%04d', idx)
    local url = "https://cdn.jsdelivr.net/gh/ipchi9012/cos_pics@latest/cos_" .. idx .. ".js`
    log.info("url=%s", url)
    local resp = http.request("GET", url).body
    idx = string.find(resp, "(", 1, true)
    resp = string.sub(resp, idx + 1, -2)
		resp = json.decode(resp)
    local item = resp[math.random(table.getn(resp))]
    local url = "https://cdn.jsdelivr.net/gh/ipchi9012/cos_pics@latest/" .. item.path
    local text = item.category .. " - " .. item.suite .. "\n" .. url
    log.info("url=%s, text=%s", url, text)
    ApiRet = Api.Api_SendMsg(
        CurrentQQ,
        {
            toUser = data.FromGroupId,
            sendToType = 2,
            sendMsgType = "TextMsg", 
            groupid = 0,
            content = text,
            picUrl = url,
            atUser = 0
        }
    )
    return 1
end
function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end
