// name: classextends3.mo
// keywords:
// status: correct
// cflags:   +d=newInst
//

package PartialMedium
  replaceable record ThermodynamicState
  end ThermodynamicState;

  replaceable partial function specificEnthalpy
    input ThermodynamicState state;
    output Real h;
  end specificEnthalpy;
end PartialMedium;

package PartialPureSubstance
  extends PartialMedium;
end PartialPureSubstance;

package SingleGasNasa
  extends PartialPureSubstance;

  redeclare record extends ThermodynamicState
    Real p;
    Real T;
  end ThermodynamicState;

  redeclare function extends specificEnthalpy
  algorithm
    h := state.T;
  end specificEnthalpy;
end SingleGasNasa;

model M
  SingleGasNasa.ThermodynamicState state(p = 1, T = 2);
  Real x = SingleGasNasa.specificEnthalpy(state);
end M;

// Result:
// function SingleGasNasa.specificEnthalpy
//   input Real state.p;
//   input Real state.T;
//   output Real h;
// algorithm
//   h := state.T;
// end SingleGasNasa.specificEnthalpy;
//
// class M
//   Real state.p = 1.0;
//   Real state.T = 2.0;
//   Real x = SingleGasNasa.specificEnthalpy(state);
// end M;
// endResult
