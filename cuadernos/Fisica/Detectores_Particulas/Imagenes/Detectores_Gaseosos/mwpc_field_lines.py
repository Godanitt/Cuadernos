#!/usr/bin/env python3
"""
High-resolution electrostatic field-line plot for a Multi-Wire Proportional Chamber (MWPC).

Geometry (2D cross-section):
    - two infinite parallel cathode planes at y = +/- gap/2, both at V_cathode
    - N thin cylindrical anode wires, normally centered at y = 0
    - all anode wires at V_anode

Method:
    Exact 2D Green function for a line charge between two grounded parallel planes.
    The cathode voltage is added as a constant offset. Line-charge densities are
    obtained from the requested wire voltage. This is especially well suited to
    MWPCs because the anode-wire radius is usually much smaller than the pitch/gap.

Outputs:
    mwpc_field_lines.png
    mwpc_field_lines.pdf

Dependencies:
    numpy, scipy, matplotlib
"""

from dataclasses import dataclass
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle
from scipy.integrate import solve_ivp

EPS0 = 8.854_187_8128e-12  # F/m


@dataclass
class MWPC:
    gap_mm: float = 10.0           # cathode-to-cathode distance
    pitch_mm: float = 3.0         # wire-to-wire pitch
    wire_diameter_um: float = 20.0
    n_wires: int = 3
    V_cathode: float = 0.0        # V0
    V_anode: float = 1800.0       # V1
    periodic_array: bool = True   # True -> infinite periodic array, plot central n_wires
    ghost_periods: int = 5        # only used when periodic_array=True

    # plotting / numerical resolution
    nx: int = 1600
    ny: int = 1100
    n_field_lines_per_cathode: int = 90
    n_equipotentials: int = 42
    dpi: int = 600

    @property
    def gap(self):
        return self.gap_mm * 1e-3

    @property
    def pitch(self):
        return self.pitch_mm * 1e-3

    @property
    def radius(self):
        return 0.5 * self.wire_diameter_um * 1e-6

    @property
    def half_gap(self):
        return 0.5 * self.gap

    @property
    def plotted_wire_x(self):
        # symmetric positions, e.g. n=3 -> [-p, 0, +p]
        return (np.arange(self.n_wires) - 0.5 * (self.n_wires - 1)) * self.pitch


# -----------------------------------------------------------------------------
# Green function for two parallel grounded planes
# -----------------------------------------------------------------------------

def green_parallel_plates(x, y, x0, y0, gap):
    """Potential Green function G [V / (C/m)] for a line charge.

    Physical coordinates use cathodes at y = +/- gap/2.
    Internally map to Y in [0, gap].

    G = 1/(4*pi*eps0) ln[(cosh(k dx)-cos(k(Y+Y0))) /
                         (cosh(k dx)-cos(k(Y-Y0)))]

    This satisfies G=0 exactly at both cathode planes.
    """
    k = np.pi / gap
    Y = y + 0.5 * gap
    Y0 = y0 + 0.5 * gap
    dx = x - x0

    c = np.cosh(k * dx)
    num = c - np.cos(k * (Y + Y0))
    den = c - np.cos(k * (Y - Y0))

    tiny = np.finfo(float).tiny
    num = np.maximum(num, tiny)
    den = np.maximum(den, tiny)
    return np.log(num / den) / (4.0 * np.pi * EPS0)


def green_grad_parallel_plates(x, y, x0, y0, gap):
    """Return dG/dx, dG/dy for the same Green function."""
    k = np.pi / gap
    Y = y + 0.5 * gap
    Y0 = y0 + 0.5 * gap
    dx = x - x0

    kd = k * dx
    c = np.cosh(kd)
    s = np.sinh(kd)

    num = c - np.cos(k * (Y + Y0))
    den = c - np.cos(k * (Y - Y0))

    tiny = np.finfo(float).tiny
    num = np.maximum(num, tiny)
    den = np.maximum(den, tiny)

    pref = k / (4.0 * np.pi * EPS0)
    dGdx = pref * s * (1.0 / num - 1.0 / den)
    dGdy = pref * (
        np.sin(k * (Y + Y0)) / num
        - np.sin(k * (Y - Y0)) / den
    )
    return dGdx, dGdy


# -----------------------------------------------------------------------------
# Charge densities that reproduce the requested wire voltage
# -----------------------------------------------------------------------------

def average_surface_green(x_wire, y_wire, x_source, y_source, radius, gap, ntheta=64):
    """Average Green function on a circular wire surface."""
    theta = (np.arange(ntheta) + 0.5) * 2.0 * np.pi / ntheta
    xs = x_wire + radius * np.cos(theta)
    ys = y_wire + radius * np.sin(theta)
    return np.mean(green_parallel_plates(xs, ys, x_source, y_source, gap))


def build_sources(cfg: MWPC):
    """Return source x positions and line charge densities lambda [C/m]."""
    y0 = 0.0
    dV = cfg.V_anode - cfg.V_cathode

    if cfg.periodic_array:
        # Infinite regular array approximated with exponentially convergent ghost wires.
        # Every wire has the same lambda by periodic symmetry.
        m = np.arange(-cfg.ghost_periods, cfg.ghost_periods + 1)
        xs = m * cfg.pitch
        coeff = 0.0
        for xj in xs:
            coeff += average_surface_green(
                0.0, y0, xj, y0, cfg.radius, cfg.gap
            )
        lam = dV / coeff
        lambdas = np.full(xs.size, lam)
        return xs, np.zeros_like(xs), lambdas

    # Finite set of N wires. Solve the electrostatic influence matrix.
    xw = cfg.plotted_wire_x
    yw = np.zeros_like(xw)
    n = xw.size
    A = np.empty((n, n), dtype=float)

    for i in range(n):
        for j in range(n):
            A[i, j] = average_surface_green(
                xw[i], yw[i], xw[j], yw[j], cfg.radius, cfg.gap
            )

    rhs = np.full(n, dV)
    lambdas = np.linalg.solve(A, rhs)
    return xw, yw, lambdas


# -----------------------------------------------------------------------------
# Potential and E field
# -----------------------------------------------------------------------------

def potential(cfg, x, y, src_x, src_y, lambdas):
    V = np.full(np.broadcast(x, y).shape, cfg.V_cathode, dtype=float)
    for xj, yj, lam in zip(src_x, src_y, lambdas):
        V += lam * green_parallel_plates(x, y, xj, yj, cfg.gap)
    return V


def electric_field(cfg, x, y, src_x, src_y, lambdas):
    shape = np.broadcast(x, y).shape
    Ex = np.zeros(shape, dtype=float)
    Ey = np.zeros(shape, dtype=float)
    for xj, yj, lam in zip(src_x, src_y, lambdas):
        dGdx, dGdy = green_grad_parallel_plates(x, y, xj, yj, cfg.gap)
        Ex -= lam * dGdx
        Ey -= lam * dGdy
    return Ex, Ey


# -----------------------------------------------------------------------------
# Field-line integration (analytic field, not grid interpolation)
# -----------------------------------------------------------------------------



def electric_field_scalar(cfg, x, y, src_x, src_y, lambdas):
    """Fast scalar E-field evaluation for ODE field-line tracing."""
    k = np.pi / cfg.gap
    Y = y + 0.5 * cfg.gap
    Y0 = src_y + 0.5 * cfg.gap
    dx = x - src_x

    kd = k * dx
    c = np.cosh(kd)
    s = np.sinh(kd)
    num = c - np.cos(k * (Y + Y0))
    den = c - np.cos(k * (Y - Y0))
    tiny = np.finfo(float).tiny
    num = np.maximum(num, tiny)
    den = np.maximum(den, tiny)

    pref = k / (4.0 * np.pi * EPS0)
    dGdx = pref * s * (1.0 / num - 1.0 / den)
    dGdy = pref * (
        np.sin(k * (Y + Y0)) / num
        - np.sin(k * (Y - Y0)) / den
    )
    Ex = -np.sum(lambdas * dGdx)
    Ey = -np.sum(lambdas * dGdy)
    return float(Ex), float(Ey)


def integrate_field_line(cfg, x0, y0, src_x, src_y, lambdas, xlim):
    """Trace one field line from a cathode toward an anode wire."""

    # Determine which direction along E points into the chamber.
    Ex0, Ey0 = electric_field_scalar(cfg, x0, y0, src_x, src_y, lambdas)
    desired_dy = -1.0 if y0 > 0 else +1.0
    direction = 1.0 if Ey0 * desired_dy > 0.0 else -1.0

    def rhs(_s, r):
        x, y = r
        Ex, Ey = electric_field_scalar(cfg, x, y, src_x, src_y, lambdas)
        norm = np.hypot(Ex, Ey)
        if not np.isfinite(norm) or norm == 0.0:
            return [0.0, 0.0]
        return [direction * Ex / norm, direction * Ey / norm]

    # Stop when the trajectory reaches any actual/ghost wire surface.
    def hit_wire(_s, r):
        x, y = r
        d2 = (x - src_x) ** 2 + (y - src_y) ** 2
        return np.min(d2) - (1.02 * cfg.radius) ** 2

    hit_wire.terminal = True
    hit_wire.direction = -1

    # Stop if it exits the visible region laterally or returns to a cathode.
    def leave_region(_s, r):
        x, y = r
        margin = 0.05 * cfg.pitch
        return min(
            x - (xlim[0] - margin),
            (xlim[1] + margin) - x,
            y + cfg.half_gap,
            cfg.half_gap - y,
        )

    leave_region.terminal = True
    leave_region.direction = -1

    sol = solve_ivp(
        rhs,
        (0.0, 5.0 * cfg.gap),
        [x0, y0],
        method="RK45",
        rtol=2e-7,
        atol=1e-10,
        max_step=cfg.gap / 700.0,
        events=(hit_wire, leave_region),
    )
    return sol.y[0], sol.y[1]


# -----------------------------------------------------------------------------
# Plot
# -----------------------------------------------------------------------------

def make_plot(cfg: MWPC):
    src_x, src_y, lambdas = build_sources(cfg)

    # Show N central wire pitches.
    xw_plot = cfg.plotted_wire_x
    xmin = xw_plot[0] - 0.5 * cfg.pitch
    xmax = xw_plot[-1] + 0.5 * cfg.pitch
    xlim = (xmin, xmax)

    # High-resolution potential grid for equipotential contours.
    x = np.linspace(xmin, xmax, cfg.nx)
    y = np.linspace(-cfg.half_gap, cfg.half_gap, cfg.ny)
    X, Y = np.meshgrid(x, y)
    V = potential(cfg, X, Y, src_x, src_y, lambdas)

    # Mask the visible wire interiors.
    mask = np.zeros_like(V, dtype=bool)
    for xj in xw_plot:
        mask |= (X - xj) ** 2 + Y**2 <= cfg.radius**2
    V = np.ma.array(V, mask=mask)

    fig, ax = plt.subplots(figsize=(7.0, 8.5))

    # Equipotentials: nonlinear spacing gives detail near the wires and cathodes.
    f1 = np.linspace(0.015, 0.75, max(8, cfg.n_equipotentials - 12))
    f2 = np.linspace(0.78, 0.985, 12)
    frac = np.unique(np.concatenate([f1, f2]))
    levels = cfg.V_cathode + frac * (cfg.V_anode - cfg.V_cathode)
    levels = np.sort(levels)
    ax.contour(X * 1e3, Y * 1e3, V, levels=levels, linewidths=0.34, colors="0.72")

    # Field lines seeded uniformly from both cathode planes.
    seed_margin = 0.006 * cfg.pitch
    seeds_x = np.linspace(xmin + seed_margin, xmax - seed_margin,
                          cfg.n_field_lines_per_cathode)
    y_eps = 2e-6 * cfg.gap

    for side in (+1.0, -1.0):
        y_start = side * (cfg.half_gap - y_eps)
        for xs in seeds_x:
            xl, yl = integrate_field_line(
                cfg, xs, y_start, src_x, src_y, lambdas, xlim
            )
            ax.plot(xl * 1e3, yl * 1e3, linewidth=0.42, color="0.18")

    # Cathode planes.
    ax.plot([xmin * 1e3, xmax * 1e3],
            [cfg.half_gap * 1e3, cfg.half_gap * 1e3],
            linewidth=1.45, color="black")
    ax.plot([xmin * 1e3, xmax * 1e3],
            [-cfg.half_gap * 1e3, -cfg.half_gap * 1e3],
            linewidth=1.45, color="black")

    # Anode wires. A minimum display radius keeps micron-scale wires visible on screen;
    # the electrostatic calculation always uses the physical radius above.
    display_radius_mm = max(cfg.radius * 1e3, 0.035)
    for xj in xw_plot:
        ax.add_patch(Circle((xj * 1e3, 0.0), display_radius_mm,
                            facecolor="black", edgecolor="black", zorder=10))

    ax.set_xlim(xmin * 1e3, xmax * 1e3)
    ax.set_ylim(-cfg.half_gap * 1e3, cfg.half_gap * 1e3)
    ax.set_aspect("equal", adjustable="box")
    ax.set_xlabel("x [mm]")
    ax.set_ylabel("y [mm]")
    ax.set_title(
        f"MWPC field lines: {cfg.n_wires} wires, "
        f"pitch={cfg.pitch_mm:g} mm, gap={cfg.gap_mm:g} mm\n"
        f"V_cathode={cfg.V_cathode:g} V, V_anode={cfg.V_anode:g} V"
    )

    fig.tight_layout()
    fig.savefig("mwpc_field_lines.png", dpi=cfg.dpi, bbox_inches="tight")
    fig.savefig("mwpc_field_lines.pdf", bbox_inches="tight")
    plt.show()

    print("Line-charge densities [C/m]:")
    if cfg.periodic_array:
        print(f"  periodic lambda = {lambdas[len(lambdas)//2]:.6e} C/m")
    else:
        for i, (xj, lam) in enumerate(zip(src_x, lambdas), 1):
            print(f"  wire {i}: x={xj*1e3:+.4f} mm, lambda={lam:.6e} C/m")


if __name__ == "__main__":
    # ---------------------------------------------------------------------
    # CHANGE THESE PARAMETERS FOR YOUR CHAMBER
    # ---------------------------------------------------------------------
    cfg = MWPC(
        gap_mm=10.0,              # distance between the two cathode planes
        pitch_mm=3.0,             # distance between anode wires
        wire_diameter_um=20.0,    # anode-wire diameter
        n_wires=3,
        V_cathode=0.0,            # V0
        V_anode=1800.0,           # wire voltage
        periodic_array=True,      # True reproduces an infinite regular MWPC array
        ghost_periods=5,
        nx=1600,
        ny=1100,
        n_field_lines_per_cathode=90,
        n_equipotentials=42,
        dpi=600,
    )

    make_plot(cfg)
