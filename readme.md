# Differential Equations for Cyclical Systems

[View the Paper](paper.pdf)

Implementation, reproduction, and analysis of Tahara et al.'s modified Lotka–Volterra predator–prey model with equilibrium tuning and population stabilization.

## Overview

This project reproduces and extends the modified Lotka–Volterra model introduced by Tahara et al. for stabilizing predator–prey dynamics through immigration-based population control.

Beyond reproducing the original results, this work develops a numerical equilibrium tuning framework capable of identifying immigration and reproduction parameters that drive the system toward user-defined predator and prey population targets.

Key areas of investigation include:

- Classical Lotka–Volterra dynamics
- Immigration-driven stabilization
- Population-dependent migration models
- Numerical equilibrium tuning
- Long-term system stability
- Ecological management applications

## Model

The modified predator–prey system is defined by:

```text
dx/dt = rx - axy + C(x)

dy/dt = bxy - my + D(y)
```

where:

| Parameter | Description |
|------------|------------|
| x | Prey population |
| y | Predator population |
| r | Prey growth rate |
| a | Predation coefficient |
| b | Predator reproduction coefficient |
| m | Predator mortality rate |
| C(x) | Prey immigration function |
| D(y) | Predator immigration function |

## Migration Models

Several immigration strategies were investigated.

### Constant Immigration

```text
C(x) = c

D(y) = d
```

A fixed number of individuals enters the population each cycle.

### Population-Dependent Immigration

```text
C(x) = c/x

D(y) = d/y
```

Immigration scales according to population size and system state.

## Equilibrium Tuning Framework

A numerical optimization routine was developed to determine model parameters that produce desired equilibrium populations.

The framework:

- Accepts target predator and prey populations
- Simulates system dynamics using ODE solvers
- Minimizes equilibrium error using numerical optimization
- Computes immigration and reproduction parameters
- Generates stable population trajectories

The implementation utilizes:

- MATLAB `ode45`
- MATLAB `fminsearch`
- Least-squares optimization

## Results

Key findings include:

- Successful reproduction of the results presented by Tahara et al.
- Immigration terms can stabilize otherwise oscillatory predator–prey systems.
- Different migration models produce substantially different long-term behaviors.
- Numerical optimization can reliably tune systems toward specified equilibrium populations.
- Practical implementation depends heavily on accurate ecological measurements and parameter estimation.

## Technologies

- MATLAB
- Dynamical Systems Modeling
- Numerical Optimization
- ODE Solvers
- Population Dynamics

## Applications

Potential applications include:

- Wildlife population management
- Ecosystem conservation
- Resource planning
- Invasive species control
- Ecological forecasting

## Authors

**Rex Paster**  
Washington University in St. Louis

**Ilan Kliman**  
Washington University in St. Louis

## Reference

Tahara, T. et al. *Asymptotic Stability of a Modified Lotka–Volterra Model with Small Immigrations*. Scientific Reports, 2018.

## License

MIT License
