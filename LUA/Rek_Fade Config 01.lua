items = reaper.CountSelectedMediaItems(0)

if items > 0 then
    reaper.Undo_BeginBlock()
    for i = 0, items-1 do
      item = reaper.GetSelectedMediaItem(0,i)
      reaper.SetMediaItemInfo_Value(item, 'D_FADEINLEN', '0.1')
      reaper.SetMediaItemInfo_Value(item, 'C_FADEINSHAPE', '1')
      
      reaper.SetMediaItemInfo_Value(item, 'D_FADEOUTLEN', '0.1')
      reaper.SetMediaItemInfo_Value(item, 'C_FADEOUTSHAPE', '1')

    end
    reaper.UpdateArrange()
    reaper.Undo_EndBlock('Rek_Fade Config 01', -1)
end
