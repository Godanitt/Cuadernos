#include <iostream>
#include <vector>
#include <cmath>

// --- Garfield++
#include "Garfield/MediumMagboltz.hh"
#include "Garfield/ViewMedium.hh"
#include "Garfield/ViewDrift.hh"
#include "Garfield/TrackHeed.hh"
#include "Garfield/DriftLineRKF.hh"
#include "Garfield/Sensor.hh"
#include "Garfield/ComponentAnalyticField.hh"
#include "Garfield/ViewCell.hh"

// --- ROOT
#include "TApplication.h"
#include "TCanvas.h"
#include "TH1F.h"
#include "TGraph.h"
#include "TRandom3.h"
#include "TLegend.h"
#include "TStyle.h"

// --- Geant4 (solo cabeceras ligeras para validar instalación)
#include "G4Version.hh"
#include "G4SystemOfUnits.hh"
#include "G4RunManager.hh"
#include "G4UImanager.hh"
#include "G4NistManager.hh"

using namespace Garfield;

int main(int argc, char** argv) {
  TApplication app("app", &argc, argv);  // <-- Necesario para inicializar ROOT
  // Crear gas con Magboltz
  MediumMagboltz gas;
  gas.LoadGasFile("ar_93_co2_7.gas");

  // Crear visualizador del medio
  ViewMedium view;
  view.SetMedium(&gas);

  // Mostrar curva de velocidad de deriva  
  auto c1 = new TCanvas("c1","Propiedades del gas",800,600);
  view.SetCanvas(c1);                     // <- muy importante
  view.PlotElectronVelocity();

  c1->Update();
  c1->SaveAs("drift_velocity.pdf");

  // Destruye primero el canvas que TÚ creaste, antes de que ~ViewMedium corra
  delete c1;
  ComponentAnalyticField cmp;
  cmp.SetMedium (& gas);

  // Radio del cable [cm]
  const double rWire = 25.e-4;
  // Radio del tubo externo [cm]
  const double rTube = 0.71;
  // Voltajes
  const double vWire = 2730.;
  const double vTube = 0.;
  // Añadimos el cable en el centro de la disposición
  cmp.AddWire (0,0,2 * rWire , vWire , "s");
  // Añadimos el tubo
  cmp.AddTube (rTube , vTube , 0);

  // Calculamos el campo eléctrico usando el objeto Componente cmp.
  Sensor sensor (& cmp);
  // Hacemos una petición para que calcule la señal del electrodo llamado s
  // usando el campo dado por el objeto Componente cmp.
  sensor.AddElectrode (&cmp ,"s");

  const double tstep = 0.5;
  const double tmin = -0.5 * tstep;
  const unsigned int nbins = 1000;
  sensor.SetTimeWindow (tmin ,tstep ,nbins);

  TrackHeed track (& sensor);
  track.SetParticle ("muon");
  track.SetEnergy (170.e9);

  DriftLineRKF drift (& sensor);

  const double rTrack = 0.3;
  const double x0=rTrack;
  const double y0 = -sqrt(rTube * rTube - rTrack * rTrack);
  track.NewTrack (x0 ,y0 ,0 ,0 ,0 ,1 ,0);
  // Hacemos un bucle sobre los clusters producidos por el camino (track)
  for (const auto& cluster : track. GetClusters ()) {
    // Bucle alrededor de los electrones del cluster
    for (const auto& electron : cluster . electrons ) {
      drift.DriftElectron ( electron .x, electron .y, electron .z, electron .t);
    }
  }

  // Creamos un canvas
  auto cD = new TCanvas ("cD","", 600, 600);
  ViewDrift driftView;
  ViewCell cellView(&cmp);
  driftView.SetCanvas(cD);
  drift.EnablePlotting(&driftView);
  track.EnablePlotting(&driftView);
  cellView.SetCanvas(cD);
  cellView.Plot2d();
  constexpr bool twod=true;
  constexpr bool drawaxis = false;
  driftView.Plot(twod,drawaxis);
  cD->SaveAs("drift_view.pdf");
  delete cD;

  auto cS = new TCanvas ("cS","" ,600 ,600);
  sensor.PlotSignal("s",cS);
  cS->SaveAs("signal.pdf");
  delete cS;


  return 0;
}
