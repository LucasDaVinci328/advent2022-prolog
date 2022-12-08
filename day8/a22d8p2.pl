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

visible([], 0).
visible([_], 0).
visible([H1, H2 | _], 1) :- H1 =< H2, !.
visible([H1, H2 | T], N) :- H1 > H2, visible([H1 | T], NN), N is NN + 1.

scenicScore(Trees, X, Y, Score) :- 
    nth0(Y, Trees, Row), endList(Row, X, East), visible(East, E),
    subList(Row, X, WestR), reverse(WestR, West), visible(West, W),
	column(Trees, X, Col), endList(Col, Y, South), visible(South, S),
	subList(Col, Y, NorthR), reverse(NorthR, North), visible(North, N),
    Score is E * W * S * N.

mostInList([Most], Most) :- !.
mostInList([LH1, LH2 | LT], Most) :- LH1 >= LH2, !, mostInList([LH1 | LT], Most).
mostInList([_, LH2 | LT], Most) :- mostInList([LH2 | LT], Most).

visibleSum(Trees, X, _, []) :- nth0(0, Trees, Row), length(Row, X), !.
visibleSum(Trees, X, Y, [SH | ST]) :- scenicScore(Trees, X, Y, SH), nextCoord(Trees, X, Y, NX, NY), visibleSum(Trees, NX, NY, ST).

run(Most) :-
    splitLines(
"30373
25512
65332
33549
35390", L), parseTrees(L, Trees), visibleSum(Trees, 0, 0, Scores), mostInList(Scores, Most).
