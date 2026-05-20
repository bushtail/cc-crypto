---@class sha256
local sha256 = {}

local bits  = require("util.bits")
local bytes = require("util.bytes")

local BAND = bits.band
local BXOR = bits.bxor
local BNOT = bits.bnot
local SHR  = bits.shr
local ROTR = bits.rotr
local ADD  = bits.add32

local MASK32 = 0xFFFFFFFF

local K = {
    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
    0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
    0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
    0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
    0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
    0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
    0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
    0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
    0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
    0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
    0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
    0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
    0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
}

local H0 = {
    0x6a09e667,
    0xbb67ae85,
    0x3c6ef372,
    0xa54ff53a,
    0x510e527f,
    0x9b05688c,
    0x1f83d9ab,
    0x5be0cd19
}

local function ch(x, y, z)
    return BAND(BXOR(BAND(x, y), BAND(BNOT(x), z)), MASK32)
end

local function maj(x, y, z)
    return BAND(BXOR(BXOR(BAND(x, y), BAND(x, z)), BAND(y, z)), MASK32)
end

local function bigSigma0(x)
    return BAND(BXOR(BXOR(ROTR(x, 2), ROTR(x, 13)), ROTR(x, 22)), MASK32)
end

local function bigSigma1(x)
    return BAND(BXOR(BXOR(ROTR(x, 6), ROTR(x, 11)), ROTR(x, 25)), MASK32)
end

local function smallSigma0(x)
    return BAND(BXOR(BXOR(ROTR(x, 7), ROTR(x, 18)), SHR(x, 3)), MASK32)
end

local function smallSigma1(x)
    return BAND(BXOR(BXOR(ROTR(x, 17), ROTR(x, 19)), SHR(x, 10)), MASK32)
end

---@param inputBytes number[]
---@return number[] digest -- 32 bytes
function sha256.hash(inputBytes)
    -- validate input
    for i = 1, #inputBytes do
        local b = inputBytes[i]
        if type(b) ~= "number" or b < 0 or b > 255 or b % 1 ~= 0 then
            error("sha256.hash: inputBytes must contain integers 0..255")
        end
    end

    local message = {}
    for i = 1, #inputBytes do
        message[i] = inputBytes[i]
    end

    message[#message + 1] = 0x80
    while (#message % 64) ~= 56 do
        message[#message + 1] = 0x00
    end

    local bitLen = #inputBytes * 8
    for i = 7, 0, -1 do
        message[#message + 1] = BAND(SHR(bitLen, i * 8), 0xFF)
    end

    local H = {}
    for i = 1, 8 do
        H[i] = H0[i]
    end

    local W = {}

    for offset = 1, #message, 64 do
        for i = 0, 15 do
            W[i] = bytes.beToU32(message, offset + i * 4)
        end

        for i = 16, 63 do
            W[i] = ADD(
                smallSigma1(W[i - 2]),
                W[i - 7],
                smallSigma0(W[i - 15]),
                W[i - 16]
            )
        end

        local a,b,c,d,e,f,g,h =
            H[1],H[2],H[3],H[4],H[5],H[6],H[7],H[8]

        for i = 0, 63 do
            local t1 = ADD(
                h,
                bigSigma1(e),
                ch(e, f, g),
                K[i + 1],
                W[i]
            )

            local t2 = ADD(bigSigma0(a), maj(a, b, c))

            h = g
            g = f
            f = e
            e = ADD(d, t1)
            d = c
            c = b
            b = a
            a = ADD(t1, t2)
        end

        H[1] = ADD(H[1], a)
        H[2] = ADD(H[2], b)
        H[3] = ADD(H[3], c)
        H[4] = ADD(H[4], d)
        H[5] = ADD(H[5], e)
        H[6] = ADD(H[6], f)
        H[7] = ADD(H[7], g)
        H[8] = ADD(H[8], h)
    end

    local digest = {}
    for i = 1, 8 do
        local w = bytes.u32ToBe(H[i])
        digest[#digest + 1] = w[1]
        digest[#digest + 1] = w[2]
        digest[#digest + 1] = w[3]
        digest[#digest + 1] = w[4]
    end

    return digest
end

---@param s string
---@return number[]
function sha256.hashString(s)
    return sha256.hash({ s:byte(1, #s) })
end

---@param digest number[]
---@return string
function sha256.toHex(digest)
    local out = {}
    for i = 1, #digest do
        out[i] = string.format("%02x", digest[i])
    end
    return table.concat(out)
end

function sha256.selfTest()
    local function hex(s)
        return sha256.toHex(sha256.hashString(s))
    end

    assert(hex("") == "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")

    assert(hex("abc") == "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad")

    assert(hex("The quick brown fox jumps over the lazy dog") == "d7a8fbb307d7809469ca9abcb0082e4f8d5651e46d3cdb762d02d0bf37c9e592")

    assert(hex("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq") == "248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1")

    return true
end

return sha256
