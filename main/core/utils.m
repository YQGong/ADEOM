BeginPackage["core`utils`"]

SetAttributes[paraEval, HoldAll];
paraEval[exp_] := (Prepend[ParallelEvaluate[exp],Evaluate[exp]];);

SetAttributes[freeze, HoldAll];
freeze[vars_, exp_] :=
    (vars = Reap[Sow[vars]; exp][[2, 1, 1]])

Remove/@{vars,exp};
EndPackage[]