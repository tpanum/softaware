-module(kitchen).

-export([fridge/1]).

fridge(FoodList) ->
    receive
        {From, {store, Food}} ->
            From ! {self(), ok},
            fridge([Food|FoodList]);
        {From, {take, Food}} ->
            case lists:member(Food, FoodList) of
                true ->
                    From ! {self(), {ok, Food}},
                    fridge(lists:delete(Food, FoodList));
                false ->
                    From ! {self(), {false, not_found}},
                    fridge(FoodList)
            end;
        {From, list} ->
            From ! {self(), FoodList},
            fridge(FoodList);
        terminate ->
            ok
    end.