% The module name must match the filename, and dashes
% are not supported -- which is why this one has a different
% filename.
-module(hello_world).
-export([hello_world/0]).

hello_world() -> io:fwrite("Hello World!\n").
