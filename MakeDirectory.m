function dir_name = MakeDirectory()

DateString = replace(datestr(datetime('now')),":","_");
dir_name=['graph' DateString];
mkdir(dir_name);

end