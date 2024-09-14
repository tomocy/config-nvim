local number = {}

number.min = function(a, b)
  if a < b then
    return a
  else
    return b
  end
end

number.max = function(a, b)
  if a > b then
    return a
  else
    return b
  end
end

number.at_least = function(a, b)
  return number.max(a, b)
end

number.at_most = function(a, b)
  return number.min(a, b)
end

number.clamp = function(min, max, x)
  return number.at_least(min, number.at_most(max, x))
end

return number
