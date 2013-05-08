-module(myMath).

-export([add/2, divide/2]).

add(One, Two) ->
    One + Two.

divide(_, 0) ->
    {false, you_are_an_idiot};
divide(One, Two) ->
    One/Two.