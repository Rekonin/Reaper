goScript, volValue = reaper.GetUserInputs("Trim Volume", 1, "Amount", "0")

function resetVolume()
reaper.Undo_BeginBlock();

  selItemCount = reaper.CountSelectedMediaItems(0)
  
  for i = 0, selItemCount-1 do
    selItem = reaper.GetSelectedMediaItem(0, i)
    reaper.SetMediaItemInfo_Value(selItem, "D_VOL", 1)
  end

reaper.Undo_EndBlock("Volume Control - RESET VOLUME", 0);
end


-------


function newVolume()
reaper.Undo_BeginBlock();

  selItemCount = reaper.CountSelectedMediaItems(0)

  for i = 0, selItemCount-1 do

    selItem = reaper.GetSelectedMediaItem(0, i)
    newVolValue = math.exp(stringRest * 0.115129254)

    reaper.SetMediaItemInfo_Value(selItem, "D_VOL", newVolValue)
    
  end

reaper.Undo_EndBlock("Volume Control - NEW VOLUME", 0);
end


-------


function incVolume()
reaper.Undo_BeginBlock();

  selItemCount = reaper.CountSelectedMediaItems(0)

  for i = 0, selItemCount-1 do

  selItem = reaper.GetSelectedMediaItem(0, i)

      currentVol = reaper.GetMediaItemInfo_Value(selItem, "D_VOL")
      currentVolDB = 20 * (math.log(currentVol, 10))
      newVol = currentVolDB + stringRest

      if newVol >= 24 then
        newVol = 24
        else
        newVol = newVol
      end

      newVolValue = math.exp(newVol * 0.115129254)

      reaper.SetMediaItemInfo_Value(selItem, "D_VOL", newVolValue)
  end

reaper.Undo_EndBlock("Volume Control - INCREASE VOLUME", 0);
end


-------


function decVolume()
reaper.Undo_BeginBlock();

  selItemCount = reaper.CountSelectedMediaItems(0)

  for i = 0, selItemCount-1 do

  selItem = reaper.GetSelectedMediaItem(0, i)

      currentVol = reaper.GetMediaItemInfo_Value(selItem, "D_VOL")
      currentVolDB = 20 * (math.log(currentVol, 10))
      newVol = currentVolDB - stringRest

      newVolValue = math.exp(newVol * 0.115129254)

      reaper.SetMediaItemInfo_Value(selItem, "D_VOL", newVolValue)
  end

reaper.Undo_EndBlock("Volume Control - DECREASE VOLUME", 0);
end


-------


function main()

stringFirst = string.sub(volValue, 1, 1)
stringRest = string.sub(volValue, 2, 10)

  if stringFirst == "-" then
      decVolume()
    elseif stringFirst == "+" then
      incVolume()
    elseif stringFirst == "=" then
      newVolume()
    elseif volValue == "0" then
      resetVolume()
    else
  end

end

if goScript == true then
  main()
end

reaper.UpdateArrange();
