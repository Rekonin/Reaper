items = reaper.CountSelectedMediaItems(0)

if items > 0 then
    reaper.Undo_BeginBlock()
    for i = 0, items-1 do
      item = reaper.GetSelectedMediaItem(0,i)
      reaper.SetMediaItemInfo_Value(item, 'D_FADEINLEN', '0.1')
      reaper.SetMediaItemInfo_Value(item, 'C_FADEINSHAPE', '1')
      
      reaper.SetMediaItemInfo_Value(item, 'D_FADEOUTLEN', '0.1')
      reaper.SetMediaItemInfo_Value(item, 'C_FADEOUTSHAPE', '1')
    
    
    
    -- Get the script's path, so we can save the data in the same place
    local info = debug.getinfo(1,'S');
    local script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
    
    local file_path = script_path .. "fade_config.txt"
    
    -- Open the file for writing, and avoid crashing if there's a problem
    -- "w+" means "erase whatever's there".
    local file, err = io.open(file_path, "w+") or nil
    if not file then 
      reaper.ShowMessageBox("Couldn't open the file.\nError: "..tostring(err), "Whoops", 0)
      return 0 
    end
    
    -- If your table's indices are contiguous numbers starting from 1, i.e. 123456789, not 123  6 apple 9...
    for i = 1, #my_table_of_data do
      file:write(my_table[i] .. "\n")
    end
    
    -- Otherwise
    for k, v in pairs(my_table_of_data) do
      file:write( tostring(k) .. "=" .. tostring(v) .. "\n" )
    end
    
    -- Close the file
    io.close(file)
    
    
    
  --  file = io.open("D:\\Programs\\REAPER\\Scripts\\Rekonin's Things\\LUA\\fade_config.ini", 'w+')
  --  file:write('FADEINLEN=0.1', '\n')
  --  file:write('FADEINSHAPE=1', '\n')
  --  file:write('FADEOUTLEN=0.1', '\n')
  --  file:write('FADEOUTSHAPE=1')
  --  file:close()
        
    end
    reaper.UpdateArrange()
    reaper.Undo_EndBlock('Rek_Fade Config 01', -1)
end
