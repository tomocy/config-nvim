local number = {}

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

return number
