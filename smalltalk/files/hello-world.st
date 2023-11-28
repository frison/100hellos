Object subclass: Hello [
  greet [
    'Hello, world' displayNl
  ]
].

greeting := Hello new.
greeting greet.
