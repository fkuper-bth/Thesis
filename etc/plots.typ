#import "/etc/utils.typ": colorScheme
#import "@preview/cetz:0.4.0": canvas, draw
#import "@preview/cetz-plot:0.1.2": plot

#let createGamificationInterestPlot() = {
  let rawData = csv("/resources/google_trends_gamification_since_2010.csv", delimiter: ",", row-type: array)
  let data = (
    rawData
      .slice(1, none)
      .map(row => {
        let parts = row.at(0).split("-")
        let year = int(parts.at(0))
        let month = int(parts.at(1))
        let x = year + (month - 1) / 12
        let y = int(row.at(1))
        return (x, y)
      })
  )
  let style = (stroke: colorScheme.hhnBlue)

  return canvas({
    import draw: *

    plot.plot(
      x-label: "Jahr",
      y-label: "Relatives Suchinteresse",
      x-tick-step: 2,
      y-tick-step: 25,
      y-min: 1,
      grid: "major",
      y-grid: true,
      x-grid: true,
      title: "Google Trends: Weltweites Interesse am Suchbegriff 'gamification' im zeitlichen Verlauf seit 2010",
      size: (14, 8),
      {
        plot.add(data, style: style)
      },
    )
  })
}
