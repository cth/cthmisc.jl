
"joincmds(cmds): stitch together an array of commands"
joincmds(cmds) = foldl((cmd1,cmd2)->`$cmd1 $cmd2`, ``, cmds)

# Filesystem stuff
"mkdir_ifnot(dir): Create directoy if it does not exist"
mkdir_ifnot(dir) = if (!isdir(dir)) mkdir(dir) end

"Decimal numbers from danish software often use , rather than . as separator"
parse_danish_float(x) = parse(Float64, replace(x, ",", "."))

