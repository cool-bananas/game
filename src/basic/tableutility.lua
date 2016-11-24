
-- unpack
if unpack and not table.unpack then table.unpack = unpack end

-- pack
if not table.pack then table.pack = function (...) return {...} end end

if not table.copy then
  table.copy = function (t)
    local clone = {}

    for k,v in pairs(t) do
      if type(v) ~= 'table' then
        clone[k] = v
      else
        clone[k] = table.copy(v)
      end
    end

    return clone
  end
end
