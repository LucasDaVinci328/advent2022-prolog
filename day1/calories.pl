splitLines(S, L) :- split_string(S, "\n", "", L).

calories([], Sum, [Sum]) :- !.
calories(["" | L], Sum, [Sum | T]) :- !, calories(L, 0, T).
calories([NumStr | L], Sum, T) :- number_string(Num, NumStr), SSum is Sum + Num, calories(L, SSum, T).

subList([H | _], 1, [H]) :- !.
subList([H | T], N, [H | L]) :- NN is N - 1, subList(T, NN, L).

mostInList([Most], Most, []) :- !.
mostInList([LH1, LH2 | LT], Most, [LH2 | LLT]) :- LH1 >= LH2, !, mostInList([LH1 | LT], Most, LLT).
mostInList([LH1, LH2 | LT], Most, [LH1 | LLT]) :- mostInList([LH2 | LT], Most, LLT).

sortList([], []).
sortList(List, [SH | ST]) :- mostInList(List, SH, LList), sortList(LList, ST).    

sumList([], 0).
sumList([H | T], Sum) :- sumList(T, SSum), Sum is H + SSum.

run(N) :- run_part_one(N);
    run_part_two(N).

run_part_one(Best) :-
    splitLines(
"1000
2000
3000

4000

5000
6000

7000
8000
9000

10000", L), calories(L, 0, Elves), sortList(Elves, ElvesSorted), nth0(0, ElvesSorted, Best).

run_part_two(Sum) :-
    splitLines(
"1000
2000
3000

4000

5000
6000

7000
8000
9000

10000", L), calories(L, 0, Elves), sortList(Elves, ElvesSorted),
    subList(ElvesSorted, 3, Best), sumList(Best, Sum).
