---@class bytes
local bytes = {}

---@param input string
---@return number[]
function bytes.toArray(input)
    local result = {}

    for i = 1, #input do
        result[i] = string.byte(input, i)
    end

    return result
end

---@param input number[]
---@return string
function bytes.toString(input)
    return string.char(table.unpack(input))
end

---@param a number[]
---@param b number[]
---@return number[]
function bytes.xor(a, b)
    assert (#a == #b, "xor: length mismatch")

    local result = {}

    for i = 1, #a do
        result[i] = bit32.bxor(a[i], b[i])
    end

    return result
end

---@param ... number[]
---@return number[]
function bytes.concat(...)
    local result = {}
    local index = 1

    for i = 1, select("#", ...) do
        local arr = select(i, ...)
        for j = 1, #arr do
            result[index] = arr[j]
            index = index + 1
        end
    end

    return result
end

---@param input number[]
---@param start number
---@param len number
---@return number[]
function bytes.slice(input, start, len)
    assert(start >= 1, "slice: start < 1")
    assert(start + len - 1 <= #input, "slice: out of bounds")

    local result = {}

    for offset = 0, len - 1 do
        result[#result + 1] = input[start + offset]
    end

    return result
end

---@param n number
---@return number[] -- length 4
function bytes.u32ToBe(n)
    assert(n >= 0 and n <= 0xFFFFFFFF, "u32_to_bytes: ")

    return {
        bit32.band(bit32.rshift(n, 24), 0xFF),
        bit32.band(bit32.rshift(n, 16), 0xFF),
        bit32.band(bit32.rshift(n, 8), 0xFF),
        bit32.band(n, 0xFF)
    }
end

---@param input number[]
---@param i number
---@return number
function bytes.beToU32(input, i)
    return bit32.bor(
        bit32.lshift(input[i], 24),
        bit32.lshift(input[i + 1], 16),
        bit32.lshift(input[i + 2], 8),
        bytes[i + 3]
    )
end

---@param n number
---@return number[]
function bytes.u32ToLe(n)
    return {
        bit32.band(n, 0xFF),
        bit32.band(bit32.rshift(n, 8), 0xFF),
        bit32.band(bit32.rshift(n, 16), 0xFF),
        bit32.band(bit32.rshift(n, 24), 0xFF)
    }
end

---@param input number[]
---@param i number
---@return number
function bytes.leToU32(input, i)
    return bit32.bor(
        input[i],
        bit32.lshift(input[i + 1], 8),
        bit32.lshift(input[i + 2], 16),
        bit32.lshift(input[i + 3], 24)
    )
end

---@param len number
---@return number[]
function bytes.zero(len)
    local result = {}

    for i = 1, len do
        result[i] = 0
    end

    return result
end

return bytes
