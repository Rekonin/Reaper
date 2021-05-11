font_size = 22
font_name = "Open Sans Condensed Bold"
window_w = 204
window_h = font_size * 26
screen_w = 1920
screen_h = 1080
position_x = (screen_w / 2) - (window_w / 2)
position_y = (screen_h / 2) - (window_h / 2)
marge = font_size
line_height = font_size + font_size/10
done = false
times = {}
z = 0
clicks = -1
input_limit = 16
average_times = {}
w = 0
a = 0
b = 0

function init(window_w, window_h)
  gfx.clear = 3289650
  gfx.init("Tap Tempo", window_w, window_h, 0, position_x, position_y)
  gfx.setfont(1, font_name, font_size, 'b')
  color("White")
  line = 0      
  gfx.x = marge
  gfx.y = line_height
  line_offset = 0
end

local function splitWords(Lines, limit)
    while #Lines[#Lines] > limit do
        Lines[#Lines+1] = Lines[#Lines]:sub(limit+1)
        Lines[#Lines-1] = Lines[#Lines-1]:sub(1,limit)
    end
end

local function wrap(str, limit)
    local Lines, here, limit, found = {}, 1, limit or 72, str:find("(%s+)()(%S+)()")

    if found then
        Lines[1] = string.sub(str,1,found-1)
    else Lines[1] = str end

    str:gsub("(%s+)()(%S+)()",
        function(sp, st, word, fi)
            splitWords(Lines, limit)

            if fi-here > limit then
                here = st
                Lines[#Lines+1] = word
            else Lines[#Lines] = Lines[#Lines].." "..word end
        end)

    splitWords(Lines, limit)

    return Lines
end

function stringWrap (text, margin_b, margin_l, margin_r)
  
  text = tostring(text)
  
  if indent ~= nil then text = string.rep(" ", indent) .. text end
  str_width, str_height = gfx.measurestr(text)
  
  if margin_l == nil then margin_l = marge end
  if margin_r == nil then margin_r = marge end
  gfx.x = margin_l
  
  text_width = str_width + margin_r + margin_l
  
  newLine()
  gfx.x = margin_l
  
  if text_width > gfx.w then

    m_width, m_height = gfx.measurestr("s")
    char_max = math.floor( (gfx.w - margin_r - margin_l) / m_width )
    
    myTable = wrap(text, char_max)
   
    local i
    for i=1, #myTable do 
      gfx.printf(tostring(myTable[i]), line)
      newLine()
      gfx.x = margin_l
    end
  
    line = line - 1
  
  else

    gfx.printf(text, line)
  
  end
  
  line = line - 1
  
  if margin_b == nil then margin_b = 1 end
  if margin_b >= 1 then
    newLine(margin_b)
  end
  
end

function rgba(r, g, b, a)
  if a ~= nil then 
    gfx.a = a/255
  else
    a = 1
  end
  gfx.r = r/255
  gfx.g = g/255
  gfx.b = b/255
end

function HexToRGB(value)
  local hex = value:gsub("#", "")
  local R = tonumber("0x"..hex:sub(1,2))
  local G = tonumber("0x"..hex:sub(3,4))
  local B = tonumber("0x"..hex:sub(5,6))
  
  gfx.r = R/255
  gfx.g = G/255
  gfx.b = B/255
    
end

function color(col)
  if col == "White" then HexToRGB("#ececec") end
  if col == "Black" then HexToRGB("#131313") end
  if col == "Red" then HexToRGB("#bf251f") end
  if col == "Yellow" then HexToRGB("#d7cf48") end
  if col == "Green" then HexToRGB("#77b861") end
end

function newLine(number)
  gfx.x = marge
  
  if number == nil then number = 1 end
  line = line + number
  gfx.y = line * line_height
end

function square(opacity, number, current)
  
  gfx.x = marge
  
  width = gfx.w/10
  
  column = (number-1) % 8
  
  gfx.x = gfx.x + gfx.w/10 * column
  
  gfx.rect(gfx.x, gfx.y, width, line_height, rgba(opacity,opacity,opacity,255))
  
  if number == current then
    gfx.rect(gfx.x, gfx.y, width, line_height/4, rgba(229,229,229,255))
  end
  
end

function average(matrix)
  local sum = 0
  for i, cell in ipairs(matrix) do
    sum = sum + cell
  end
  sum = sum / #matrix
  return sum
end

function durationToBpm(duration)
  local bpm = 60 / duration
  return bpm
end

function mean( t )
  local sum = 0
  local count= 0

  for k,v in pairs(t) do
    if type(v) == 'number' then
      sum = sum + v
      count = count + 1
    end
  end

  return (sum / count)
end

function standardDeviation( t )
  local m
  local vm
  local sum = 0
  local count = 0
  local result

  m = mean( t )

  for k,v in pairs(t) do
    if type(v) == 'number' then
      vm = v - m
      sum = sum + (vm * vm)
      count = count + 1
    end
  end

  result = math.sqrt(sum / (count-1))

  return result
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function variance( t )
  local m
  local vm
  local sum = 0
  local count = 0
  local result

  m = mean( t )

  for k,v in pairs(t) do
    if type(v) == 'number' then
      vm = v - m
      sum = sum + (vm * vm)
      count = count + 1
    end
  end

  result = (sum / (count-1))

  return result
end

function maxmin( t )
  local max = -math.huge
  local min = math.huge

  for k,v in pairs( t ) do
    if type(v) == 'number' then
      max = math.max( max, v )
      min = math.min( min, v )
    end
  end

  return max, min
end

function secToBeats(sec, bpm)
  
  local result = sec/(bpm/60) 
  
  return result

end

function run()  
  
  color("White")
  
  line = 0
  if line_offset == nil then line_offset = 0 end
  char = gfx.getchar()
  
  if char == 30064 then 
    line_offset = line_offset + 1
    line = line + line_offset
  end
  if char == 1685026670 then
    line_offset = line_offset - 1
    line = line + line_offset
  end 

  if done == false then clock = reaper.time_precise() end  

  if gfx.mouse_cap == 0 or char > 0 then engaged = true end

  if (gfx.mouse_cap > 0 or char > 0 ) and engaged == true then

     if clicks > 1 then
       z = z + 1
       if z > input_limit then z = 1 end
       times[z] = durationToBpm(reaper.time_precise() - clock)
    end

    if clicks > 3 then
      w = w + 1
      if w > input_limit then w = 1 end
      average_times[w] = average_current
    end

    clock = reaper.time_precise()
    done = true
    engaged = false
    color("Red")
    gfx.rect(gfx.mouse_x-8, gfx.mouse_y-8, 30, 30)
    clicks = clicks + 1

  end

  color("White")

  if clicks == -1 then stringWrap("Press a key 5 times more") end
  if clicks == 0 then stringWrap("Press a key 4 times more") end
  if clicks == 1 then stringWrap("Press a key 3 times more") end
  if clicks == 2 then stringWrap("Press a key 2 times more") end
  if clicks == 3 then stringWrap("Press a key 1 time more") end
  if clicks > 3 then

    average_current = average(times)
    deviation = standardDeviation(times)
    max_deviation = average_current + deviation
    min_deviation = average_current - deviation
    
    precision = min_deviation / average_current
    
    if precision <= 0.5 then color("Red") end
    if precision > 0.5 and precision <= 0.9 then color("Yellow") end
    if precision > 0.9 then color("Green") end
      
    stringWrap("BPM of the last " .. (#times)) 
    stringWrap("Average BPM = ".. (round(average_current, 0)))
    stringWrap("Average BPM /2 = ".. (round(average_current/2, 0)))
    stringWrap("Deviation = " .. (round(deviation, 2)))
    stringWrap("Accuracy = ".. (round(precision*100, 2)).." %%")
    stringWrap("Max BPM = "..(round(max_deviation, 2)))
    stringWrap("Min BPM = "..(round(min_deviation, 2)))
    
    for b = 1, #times do
      if b == 1 then newLine(2) end
      if b <= 8 then square(times[b], b, z) end
      if b == 8  then newLine() end
      if b > 8 then square(times[b], b, z) end
    end
    
    newLine()
    
    average_timesBPM = average(average_times)
    deviationBPM = standardDeviation(average_times)
    max_deviationBPM = average_timesBPM + deviationBPM
    min_deviationBPM = average_timesBPM - deviationBPM
    
    precisionBPM = min_deviationBPM / average_timesBPM
  
  if precisionBPM <= 0.5 then color("Red") end
    if precisionBPM > 0.5 and precisionBPM <= 0.95 then color("Yellow") end
    if precisionBPM > 0.95 then color("Green") end
    
    if clicks > 5 then
      newLine()
      stringWrap("Average of last " .. (#average_times))
      stringWrap("Average BPM = ".. (round(average_timesBPM, 0)))
      stringWrap("Average BPM /2 = ".. (round(average_timesBPM/2, 0)))
      stringWrap("Deviation = " .. (round(deviationBPM, 2)))
      stringWrap("Accuracy = ".. (round(precisionBPM*100, 2)).." %%")
      stringWrap("Max BPM = "..(round(max_deviationBPM, 2)))
      stringWrap("Min BPM = "..(round(min_deviationBPM, 2)))
      
      for a = 1, #average_times do
        if a == 1 then newLine(2) end
        if a <= 8 then square(average_times[a], a, w) end
        if a == 8  then newLine() end
        if a > 8 then square(average_times[a], a, w) end
      end
    
    end
  
  end 

  gfx.update()
  
  if char == 27 then gfx.quit() end
  if char >= 0 then reaper.defer(run) end

end

init(window_w, window_h)
run()
