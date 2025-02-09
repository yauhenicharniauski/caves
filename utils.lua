Utils = {}

function Utils.trunc(num)
    return num >= 0 and math.floor(num) or math.ceil(num)
end
