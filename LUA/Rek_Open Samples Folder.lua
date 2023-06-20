local function No_Undo()end; local function no_undo()reaper.defer(No_Undo)end;

local pathFile = ''D:\\SAMPLES''

if reaper.GetOS() == 'OSX32' or reaper.GetOS() == 'OSX64' then;
    os.execute('open ''..pathFile..''');
  else;
    os.execute('start '' '..pathFile);
end;
no_undo();
