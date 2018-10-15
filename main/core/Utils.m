BeginPackage["core`Utils`"];

paraEval::usage = "paraEval[]";
SetAttributes[paraEval, HoldAll];
paraEval[exp_] := (Prepend[ParallelEvaluate[exp],Evaluate[exp]];);

freeze::usage = "freeze[]";
SetAttributes[freeze, HoldAll];
freeze[vars_, exp_] :=
    (vars = Reap[Sow[vars]; exp][[2, 1, 1]])

Remove/@{vars,exp};
EndPackage[];