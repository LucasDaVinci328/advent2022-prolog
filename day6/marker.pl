marker([H | L], LEN, LEN) :- subList([H | L], LEN, LL), not_equal(LL), !.
marker([_ | L], N, LEN) :- marker(L, NN, LEN), N is NN + 1.

subList([H | _], 0, [H]) :- !.
subList([H | T], N, [H | L]) :- NN is N - 1, subList(T, NN, L).
       
insertUnique(H, [], [H]) :- !.
insertUnique(H, [H | T], [H | T]) :- !.
insertUnique(H, [A | T], [A | TT]) :- insertUnique(H, T, TT).

addUnique([], A, A) :- !.
addUnique([H | T], L, NL) :- insertUnique(H, L, NNL), addUnique(T, NNL, NL).

not_equal(L) :- addUnique(L, [], LL), length(L, Len), length(LL, Len).

run_part_one(N) :- string_to_list("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", L), marker(L, N, 4).
run_part_two(N) :- string_to_list("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", L), marker(L, N, 14).
