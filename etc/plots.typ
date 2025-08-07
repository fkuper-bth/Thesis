#import "/etc/utils.typ": colorScheme
#import "@preview/cetz:0.4.0": canvas, draw
#import "@preview/cetz-plot:0.1.2": chart, plot

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

#let createVnEnginePopularityOnItchIoPlot() = {
  // number of visual novel games on itch.io by tool tag
  let rawData = (
    "Ren'Py": 4956,
    "Unity": 1819,
    "Twine": 816,
    "Godot": 496,
    "TyranoBuilder": 207,
    "Unreal Engine": 136,
    "Ink": 49,
    "Visual Novel Maker": 11,
  )

  // calculate relative percentages
  let total = rawData.values().sum()
  let relativeData = rawData
    .pairs()
    .map(pair => {
      let key = pair.at(0)
      let value = (pair.at(1) / total) * 100
      return (key, value)
    })

  // filter out items with less than 5% and aggregate them into "Andere"
  let data = relativeData.filter(pair => pair.at(1) >= 5)
  let aggregateItems = relativeData.filter(pair => pair.at(1) < 5)
  let aggregatePercentage = aggregateItems.map(pair => pair.at(1)).sum()
  let aggregateData = ("Andere", aggregatePercentage)
  data.push(aggregateData)

  // create pie chart
  return canvas({
    import draw: *

    let colors = gradient.linear(
      colorScheme.hhnBlue,
      colorScheme.hhnOrange,
      colorScheme.hhnWhite,
    )

    chart.piechart(
      data,
      label-key: 0,
      value-key: 1,
      radius: 5,
      inner-radius: 1,
      gap: 0.3deg,
      slice-style: colors,
      inner-label: (content: (value, label) => [#text(label)], radius: 200%),
      outer-label: (
        content: (value, label) => [#text(
            white,
            stroke: 0.3pt + black,
            size: 16pt,
            weight: "bold",
            [#calc.round(value)%],
          )],
        radius: 60%,
      ),
    )
  })
}

#let createVnEnginePopularityOnItchIoColumnChart() = {
  // number of visual novel games on itch.io by tool tag
  let rawData = (
    "Ren'Py": 4956,
    "Unity": 1819,
    "Twine": 816,
    "Godot": 496,
    "TyranoBuilder": 207,
    "Unreal Engine": 136,
    "Ink": 49,
    "VN Maker": 11,
  )

  let data = rawData.pairs()

  return canvas({
    import draw: *

    set-style(
      axes: (
        bottom: (
          tick: (
            label: (
              angle: 45deg,
              offset: 1,
            ),
          ),
        ),
      ),
    )

    let colors = (
      colorScheme.hhnBlue,
      colorScheme.hhnBlueLight,
      colorScheme.hhnOrange,
      colorScheme.hhnWhite,
    )

    chart.columnchart(
      data,
      x-inset: 0,
      y-tick-step: none,
      y-ticks: (100, 1000, 2000, 4000),
      x-label-offset: 10,
      bar-style: (index => (fill: colors.at(calc.rem(index, 4)))),
      size: (auto, 5),
    )
  })
}
