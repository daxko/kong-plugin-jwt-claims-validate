local cjson = require "cjson"

local valid_types = {
    ["string"]  = true, 
    ["boolean"] = true,
    ["number"]  = true
}

local function claim_check(value, conf)
  for k,v in pairs(value) do
    local type = type(v)
    if not is_scalar(v) then
      return false, "'claims."..k.."' is not one following types: [boolean, string, number]"
    end
  end
  return true, nil
end

return {
  no_consumer = true,
  fields = {
    uri_param_names = { type = "array", default = { "jwt" } },
    claims = { 
      type = "table", 
      func = claim_check,
      new_type = {
        type = "map",
        keys = { type = "string" },
        values = { type = "skip", custom_validator = is_scalar },
      }
    }
  }
}
