
syn region String start='"' end='"'
syn match Operator "=\||\|@\|\$\|\*\|+\|_\|!"
syn match Blue "\~"

syn match Special "\u\(\u\|_\)*"
syn match Identifier "\l\i*"

syn region Comment start='//' end='$'
syn region Comment start='/\*' end='\*/'

