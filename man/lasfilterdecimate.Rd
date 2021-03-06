% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lasfilterdecimate.r
\name{lasfilterdecimate}
\alias{lasfilterdecimate}
\title{Thin LiDAR data}
\usage{
lasfilterdecimate(.las, density, homogenize = TRUE, res = 5,
  use_pulse = FALSE)
}
\arguments{
\item{.las}{An object of the class \code{LAS}}

\item{density}{numeric. The expected density}

\item{homogenize}{logical. If \code{TRUE}, the algorithm tries to homogenize the pulse density to
provide a uniform dataset. If \code{FALSE} the algorithm will reach the pulse density over the whole
area.}

\item{res}{numeric. Cell size to compute the pulse density.}

\item{use_pulse}{logical. Decimate by removing random pulses instead of random points}
}
\value{
It returns a \code{LAS} object.
}
\description{
Thin LIDAR data randomly removes a given proportion of points to reach specific point/pulse densities.
}
\details{
\code{lasfilterdecimate} is designed to produce output datasets that have uniform densities
throughout the coverage area. For each cell, the proportion of points/pulses that will
be retained is computed using the actual density and the desired density. If the required density
is greater than the actual density it returns an unchanged set of points (it cannot increase the
density). If \code{homogenize = FALSE} is selected, it randomly removes points/pulses to reach the
required density over the whole area (see \code{\link[lidR:area]{area}}). The cell size must be large
enough to compute a coherent local pulse density i.e., in a 2 points/m^2 dataset, 25 square meters
would be feasible; however, an extent too small to thin (e.g. <1 square meter) would not be feasible
because density does not have meaning at this scale.
}
\examples{
LASfile <- system.file("extdata", "Megaplot.laz", package="lidR")
lidar = readLAS(LASfile, select = "xyz")

# By default the method is homogenize = TRUE
thinned = lasfilterdecimate(lidar, 1, res = 5)
plot(grid_density(lidar))
plot(grid_density(thinned))

# Method homogenize = FALSE enables a global pulse density to be reached
thinned = lasfilterdecimate(lidar, 1, homogenize = FALSE)
summary(thinned)
d = grid_density(thinned)
plot(d)
}
