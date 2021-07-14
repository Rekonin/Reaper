-- Show the number of selected items as tooltip close to the mouse, when more than 1 item is selected
-- Meo-Ada Mespotine -- 18th of August 2020 - licensed under MIT-license

xoffset=30 -- change this, to move the tooltip in x-position related to the mouse; default is 30 pixels to the right(30)
yoffset=-18 -- change this, to move the tooltip in y-position related to the mouse; default is 18 pixels to the top(-18)


function main()
  selmi=reaper.CountSelectedMediaItems(0)
  x,y=reaper.GetMousePosition()
  if selmi>1 then
    reaper.TrackCtl_SetToolTip(selmi.." media items selected", x+xoffset, y+yoffset, false)
  else
    reaper.TrackCtl_SetToolTip("", x+10, y+10, false)
  end
  reaper.defer(main)
end

main()
