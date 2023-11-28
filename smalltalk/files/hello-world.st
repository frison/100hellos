Object subclass: Hello [
  greet [
    'Hello World!' displayNl
  ]
].

greeting := Hello new.
greeting greet.
