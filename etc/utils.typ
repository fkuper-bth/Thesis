#import "@preview/big-todo:0.2.0": *
#import "@preview/glossarium:0.5.8": *
#import "@preview/wrap-it:0.1.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let colorScheme = (
  hhnOrange: color.rgb("E86423"),
  hhnBlue: color.rgb("222A78"),
  hhnBlueLight: color.rgb("222A78").lighten(25%),
  hhnWhite: color.rgb("FFFFFF"),
  background: luma(240),
)

#let tableFrame(stroke) = (x, y) => (
  left: if x > 0 { 0pt } else { stroke },
  right: stroke,
  top: if y < 2 { stroke } else { 0pt },
  bottom: stroke,
)

#let configureCodlyStyle() = {
  codly-reset()
  codly(
    languages: codly-languages,
    zebra-fill: none,
    stroke: 1pt + colorScheme.background,
  )
}
