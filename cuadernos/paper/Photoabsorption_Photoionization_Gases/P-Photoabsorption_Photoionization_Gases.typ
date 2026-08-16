#import "../../../plantilla/paper/paper.typ": paper-template

// <paper:metadata>
#let paper = (
  id: "P-Photoabsorption_Photoionization_Gases",
  slug: "photoabsorption-photoionization-gases",
  title: "Photoabsorption and Photoionization in Gases",
  // Cambia únicamente esta línea por "ieee" o "mdpi" para probar otro estilo.
  // Si se omite `style`, el gestor y la plantilla usan Elsevier por defecto.
  style: "elsevier",
  authors: ("Daniel Vázquez Lago",),
  output: "P-Photoabsorption_Photoionization_Gases.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  abstract: "A compact demonstration paper for testing the paper compilation pathway. We summarize the distinction between photon absorption and photoionization in a dilute gas and introduce the simplest attenuation model used to connect microscopic cross sections with macroscopic interaction probabilities.",
  keywords: ("photoabsorption", "photoionization", "gas detectors", "cross sections"),
  tags: ("gases", "radiation", "test"),
)
// </paper:metadata>

// The body is common to all styles. Only the author dictionaries below adapt
// the same metadata to the native API of each external template.
#let elsevier-authors = (
  (
    name: [Daniel Vázquez Lago],
    affiliations: ("a",),
    corresponding: true,
    email: "daniel@example.com",
  ),
)
#let elsevier-affiliations = (
  "a": [Cuadernos project, Spain],
)

#let ieee-authors = (
  (
    name: [Daniel Vázquez Lago],
    organization: [Cuadernos project],
    location: [Spain],
    email: "daniel@example.com",
  ),
)

#let mdpi-authors = (
  (
    name: "Daniel Vázquez Lago",
    department: "Test paper",
    institution: "Cuadernos project",
    city: "Madrid",
    country: "Spain",
    mail: "daniel@example.com",
  ),
)

#show: paper-template.with(
  meta: paper,
  elsevier-authors: elsevier-authors,
  elsevier-affiliations: elsevier-affiliations,
  ieee-authors: ieee-authors,
  mdpi-authors: mdpi-authors,
)

= Introduction

Photoabsorption denotes any process in which an incident photon transfers its energy to the medium, whereas photoionization is the subset of such interactions that leaves a free electron and a positive ion. In gaseous detectors the distinction matters because absorption controls photon transport, while ionization can seed additional charge and therefore modify the detector response.

= Minimal interaction model

For a uniform gas with number density $n$, path length $L$, and an energy-dependent microscopic cross section $sigma(E)$, a simple independent-interaction model gives

$ P(E, L) = 1 - exp(-n sigma(E) L). $

Using $sigma_"abs"(E)$ gives the total absorption probability, while $sigma_"ion"(E)$ describes only the ionizing branch. Consequently, $sigma_"ion"(E) <= sigma_"abs"(E)$ whenever non-ionizing absorption channels are available.

#figure(
  table(
    columns: (1.3fr, 1fr, 1fr),
    [*Photon regime*], [*$sigma_"abs"$*], [*$sigma_"ion"$*],
    [Below threshold], [finite or small], [0],
    [Near threshold], [increasing], [turn-on],
    [Above threshold], [channel dependent], [finite],
  ),
  kind: table,
  caption: [Illustrative qualitative behaviour; entries are intentionally schematic.],
)

= Photon transport context

In practical gaseous systems the relevant attenuation length depends strongly on photon energy, mixture composition, pressure, and the availability of ionizing and non-ionizing channels. The distinction becomes particularly useful when photons generated in an avalanche can either disappear harmlessly or create a new electron that participates in subsequent multiplication.

#lorem(85)

= Discussion

The simple exponential model above neglects scattering, secondary emission, excited-state kinetics, and spatial variations of the gas. Nevertheless, it provides a useful baseline for checking units, threshold behaviour, and the relation between microscopic cross sections and detector-scale probabilities. A realistic implementation can replace the schematic cross sections by tabulated or calculated data without changing the structure of the transport model.

#lorem(95)

= Scope

This document is deliberately synthetic and exists to exercise the shared paper infrastructure, metadata parsing, style switching, two-column Elsevier layout, and output routing. Its scientific content can later be replaced by a full treatment without changing the compilation workflow.

#lorem(55)
