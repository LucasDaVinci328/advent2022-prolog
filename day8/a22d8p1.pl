splitLines(S, L) :- split_string(S, "\n", "\n", L).

parseTrees([], []).
parseTrees([TS | S], [TL | L]) :- string_to_list(TS, TL), parseTrees(S, L).

nextCoord(Trees, X, Y, NX, 0) :- YY is Y + 1, length(Trees, YY), !, NX is X + 1.
nextCoord(_, X, Y, X, NY) :- NY is Y + 1.

subList([H | _], 0, [H]) :- !.
subList([H | T], N, [H | L]) :- NN is N - 1, subList(T, NN, L).

endList(L, 0, L) :- !.
endList([_ | T], N, L) :- NN is N - 1, endList(T, NN, L).

column([], _, []).
column([H | T], N, [CH | CT]) :- nth0(N, H, CH), column(T, N, CT).

highFirstList([]).
highFirstList([_]).
highFirstList([H1, H2 | T]) :- H1 > H2, highFirstList([H1 | T]).

visible(Trees, X, Y, 1) :- nth0(Y, Trees, Row), endList(Row, X, East), highFirstList(East), !.
visible(Trees, X, Y, 1) :- nth0(Y, Trees, Row), subList(Row, X, WestR), reverse(WestR, West), highFirstList(West), !.
visible(Trees, X, Y, 1) :- column(Trees, X, Col), endList(Col, Y, South), highFirstList(South), !.
visible(Trees, X, Y, 1) :- column(Trees, X, Col), subList(Col, Y, NorthR), reverse(NorthR, North), highFirstList(North), !.
visible(_, _, _, 0).

visibleSum(Trees, X, _, 0) :- nth0(0, Trees, Row), length(Row, X), !.
visibleSum(Trees, X, Y, Sum) :- visible(Trees, X, Y, 1), !, nextCoord(Trees, X, Y, NX, NY), visibleSum(Trees, NX, NY, SSum), Sum is SSum + 1.
visibleSum(Trees, X, Y, Sum) :- nextCoord(Trees, X, Y, NX, NY), visibleSum(Trees, NX, NY, Sum).

run(Sum) :-
    splitLines(
"30373
25512
65332
33549
35390", L), parseTrees(L, Trees), visibleSum(Trees, 0, 0, Sum).
