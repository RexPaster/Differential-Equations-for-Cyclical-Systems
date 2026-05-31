# Differential Equations for Cyclical Systems — An Exploration of T. Tahara et al.'s Modified LV Model

Implementation and analysis of a modified Lotka–Volterra predator-prey model featuring immigration and migration effects.

## Overview

This project reproduces and extends the work of Tahara et al. on modified Lotka–Volterra systems designed to stabilize predator-prey populations through immigration and migration mechanisms.

The study investigates:

- Classical predator-prey dynamics
- Population stabilization
- Immigration and migration models
- Numerical equilibrium tuning
- Ecological system management applications

## Model

The modified predator-prey system is

$$
\frac{dx}{dt}
=
rx-axy+C(x)
$$

$$
\frac{dy}{dt}
=
bxy-my+D(y)
$$

where:

- $x$ = prey population
- $y$ = predator population
- $r$ = prey growth rate
- $a$ = predation rate
- $b$ = predator reproduction rate
- $m$ = predator mortality rate
- $C(x)$ = prey immigration term
- $D(y)$ = predator immigration term

## Migration Models

The study evaluates several migration strategies:

### Constant Immigration

$$
C(x)=c
$$

$$
D(y)=d
$$

### Population-Dependent Immigration

$$
C(x)=\frac{c}{x}
$$

$$
D(y)=\frac{d}{y}
$$

## Equilibrium Tuning

A numerical optimization framework was developed to:

- Specify target predator populations
- Specify target prey populations
- Determine required immigration rates
- Compute reproduction parameters
- Achieve stable long-term population behavior

The implementation utilizes:

- MATLAB `ode45`
- MATLAB `fminsearch`
- Least-squares optimization

## Results

Major findings include:

- Successful reproduction of Tahara et al.'s published results.
- Constant immigration can stabilize otherwise cyclic systems.
- Migration terms significantly alter long-term dynamics.
- Optimization techniques can tune systems toward desired equilibria.
- Practical implementation requires accurate ecological measurements.


## Technologies

- MATLAB
- Dynamical Systems
- Optimization
- ODE Solvers
- Ecological Modeling

## Applications

Potential applications include:

- Wildlife management
- Conservation planning
- Population control
- Ecosystem restoration
- Ecological forecasting

## Authors

**Rex Paster**  
Washington University in St. Louis

**Ilan Kliman**  
Washington University in St. Louis

## References

Tahara et al., *Asymptotic Stability of a Modified Lotka–Volterra Model with Small Immigrations*, Scientific Reports, 2018.

## License

MIT License
