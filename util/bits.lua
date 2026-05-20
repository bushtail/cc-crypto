---@class bits
local bits = {}

---@param x number
---@param disp number
---@return number
function bits.rotr(x, disp)
    return bit32.rrotate(x, disp)
end

---@param x number
---@param disp number
---@return number
function bits.rotl(x, disp)
    return bit32.lrotate(x, disp)
end

---@param x number
---@param disp number
---@return number
function bits.shr(x, disp)
    return bit32.rshift(x, disp)
end

---@param x number
---@param disp number
---@return number
function bits.shl(x, disp)
    return bit32.lshift(x, disp)
end

---@param x number
---@param y number
---@return number
function bits.band(x, y)
    return bit32.band(x, y)
end

---@param x number
---@param y number
---@return number
function bits.bor(x, y)
    return bit32.bor(x, y)
end

---@param x number
---@param y number
---@return number
function bits.bxor(x, y)
    return bit32.bxor(x, y)
end

---@param x number
---@return number
function bits.bnot(x)
    return bit32.bnot(x)
end

---@param ... number
---@return number
function bits.add32(...)
    local sum = 0

    for i = 1, select("#", ...) do
        sum = (sum + select(i, ...)) % 0x100000000
    end

    return sum
end

return bits
