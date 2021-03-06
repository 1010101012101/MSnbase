\name{addIdentificationData-methods}
\docType{methods}
\alias{addIdentificationData-methods}
\alias{addIdentificationData}

\title{ Adds Identification Data }

\description{

  These methods add identification data to a raw MS experiment (an
  \code{"\linkS4class{MSnExp}"} object) or to quantitative data (an
  \code{"\linkS4class{MSnSet}"} object). The identification data needs
  to be available as a \code{mzIdentML} file (and passed as filenames,
  or directly as identification object) or, alternatively, can be passed
  as an arbitrary \code{data.frame}. See details in the \emph{Methods}
  section.
  
}

\details{

  The \code{featureData} slots in a \code{"\linkS4class{MSnExp}"} or a
  \code{"\linkS4class{MSnSet}"} instance provides only one row per MS2
  spectrum but the identification is not always bijective. Prior to
  addition, the identification data is filtered as documented in the
  \code{\link{filterIdentificationDataFrame}} function: (1) only PSMs
  matching the regular (non-decoy) database are retained; (2) PSMs of
  rank greater than 1 are discarded; and (3) only proteotypic peptides
  are kept.

  If after filtering, more then one PSM per spectrum are still present,
  these are combined (reduced, see
  \code{\link{reduce,data.frame-method}}) into a single row and
  separated by a semi-colon. This has as side-effect that feature
  variables that are being reduced are converted to characters. See the
  \code{reduce} manual page for examples.

  See also the section about identification data in the
  \emph{MSnbase-demo} vignette for details and additional examples.

  After addition of the identification data, new feature variables are
  created. The column \code{nprot} contains the number of members in the
  protein group; the columns \code{accession} and \code{description}
  contain a semicolon separated list of all matches. The columns
  \code{npsm.prot} and \code{npep.prot} represent the number of PSMs and
  peptides that were matched to a particular protein group. The column
  \code{npsm.pep} indicates how many PSMs were attributed to a peptide
  (as defined by its sequence \code{pepseq}). All these values are
  re-calculated after filtering and reduction.

}


\section{Methods}{

  \describe{

    \item{\code{signature(object = "MSnExp", id = "character", ...}}{
      Adds the identification data stored in mzIdentML files to a
      \code{"\linkS4class{MSnExp}"} instance. The method handles one or
      multiple mzIdentML files provided via \code{id}. \code{id} has to
      be a \code{character} vector of valid filenames. See below for
      additional arguments.
    }

    \item{\code{signature(object = "MSnExp", id = "mzID", ...)}}{ Same
      as above but \code{id} is a \code{mzID} object generated by
      \code{mzID::mzID}. See below for additional arguments. }

    \item{\code{signature(object = "MSnExp", id = "mzIDCollection",
	...)}}{ Same as above but \code{id} is a \code{mzIDCollection}
      object. See below for additional arguments. }

    \item{\code{signature(object = "MSnExp", id = "mzRident", ...}}{
      Same as above but \code{id} is a \code{mzRident} object generated
      by \code{mzR::openIdfile}. See below for additional arguments. }

  
    \item{\code{signature(object = "MSnExp", id = "data.frame", ...}}{
      Same as above but \code{id} could be a \code{data.frame}. See
      below for additional arguments. }

    \item{\code{signature(object = "MSnSet", id = "character", ...)}}{
      Adds the identification data stored in mzIdentML files to an
      \code{"\linkS4class{MSnSet}"} instance.  The method handles one or
      multiple mzIdentML files provided via \code{id}. \code{id} has to
      be a \code{character} vector of valid filenames. See below for
      additional arguments. }

    \item{\code{signature(object = "MSnSet", id = "mzID", ...)}}{ Same
      as above but \code{id} is a \code{mzID} object. See below for
      additional arguments.  }

    \item{\code{signature(object = "MSnSet", id = "mzIDCollection",
	...)}}{ Same as above but \code{id} is a \code{mzIDCollection}
      object. See below for additional arguments.  }

    \item{\code{signature(object = "MSnSet", id = "data.frame", ...)}}{
      Same as above but \code{id} is a \code{data.frame}.  See below for
      additional arguments.  }

  }

  The methods above take the following additional argument. These need
  to be set when adding identification data as a \code{data.frame}. In
  all other cases, the defaults are set automatically.


  \describe{

    \item{fcol}{

      The matching between the features (raw spectra or quantiative
      features) and identification results is done by matching columns
      in the featue data (the \code{featureData} slot) and the
      identification data. These values are the spectrum file index and
      the acquisition number, passed as a \code{character} of length
      2. The default values for these variables in the \code{object}'s
      feature data are \code{"spectrum.file"} and
      \code{"acquisition.num"}. Values need to be provided when
      \code{id} is a \code{data.frame}.

    }

    \item{icol}{

      The default values for the spectrum file and acquisition numbers
      in the identification data (the \code{id} argument) are
      \code{"spectrumFile"} and \code{"acquisitionNum"}. Values need to
      be provided when \code{id} is a \code{data.frame}.
      
    }

    \item{acc}{

      The protein (group) accession number or identifier. Defaults are
      \code{"DatabaseAccess"} when passing filenames or \code{mzRident}
      objects and \code{"accession"} when passing \code{mzID} or
      \code{mzIDCollection} objects. A value needs to be provided when
      \code{id} is a \code{data.frame}.

    }

    \item{desc}{

      The protein (group) description. Defaults are
      \code{"DatabaseDescription"} when passing filenames or
      \code{mzRident} objects and \code{"description"} when passing
      \code{mzID} or \code{mzIDCollection} objects. A value needs to be
      provided when \code{id} is a \code{data.frame}.

    }

    \item{pepseq}{

      The peptide sequence variable name. Defaults are \code{"sequence"}
      when passing filenames or \code{mzRident} objects and
      \code{"pepseq"} when passing \code{mzID} or \code{mzIDCollection}
      objects. A value needs to be provided when \code{id} is a
      \code{data.frame}.

    }

    \item{key}{

      The key to be used when the identification data need to be reduced
      (see details section). Defaults are \code{"spectrumID"} when
      passing filenames or \code{mzRident} objects and
      \code{"spectrumid"} when passing \code{mzID} or
      \code{mzIDCollection} objects. A value needs to be provided when
      \code{id} is a \code{data.frame}.

    }

    \item{decoy}{

      The feature variable used to define whether the PSM was matched in
      the decoy of regular fasta database for PSM filtering. Defaults
      are \code{"isDecoy"} when passing filenames or \code{mzRident}
      objects and \code{"isdecoy"} when passing \code{mzID} or
      \code{mzIDCollection} objects. A value needs to be provided when
      \code{id} is a \code{data.frame}. See
      \code{\link{filterIdentificationDataFrame}} for details.

    }

    \item{rank}{

      The feature variable used to defined the rank of the PSM for
      filtering. Defaults is \code{"rank"}. A value needs to be provided
      when \code{id} is a \code{data.frame}. See
      \code{\link{filterIdentificationDataFrame}} for details.

    }

    \item{accession}{

      The feature variable used to defined the protein (groupo)
      accession or identifier for PSM filterin. Defaults is to use the
      same value as \code{acc} . A value needs to be provided when
      \code{id} is a \code{data.frame}. See
      \code{\link{filterIdentificationDataFrame}} for details.
      
    }

    \item{verbose}{A \code{logical} defining whether to print out
      messages or not. Default is to use the session-wide open from
      \code{\link{isMSnbaseVerbose}}.}

  }
  
}

\author{
  Sebastian Gibb <mail@sebastiangibb.de> and Laurent Gatto
}

\seealso{

  \code{\link{filterIdentificationDataFrame}} for the function that
  filters identification data, \code{\link{readMzIdData}} to read the
  identification data as a unfiltered \code{data.frame} and
  \code{\link{reduce,data.frame-method}} to reduce it to a
  \code{data.frame} that contains only unique PSMs per row.
  
}

\examples{
## find path to a mzXML file
quantFile <- dir(system.file(package = "MSnbase", dir = "extdata"),
                 full.name = TRUE, pattern = "mzXML$")
## find path to a mzIdentML file
identFile <- dir(system.file(package = "MSnbase", dir = "extdata"),
                 full.name = TRUE, pattern = "dummyiTRAQ.mzid")

## create basic MSnExp
msexp <- readMSData(quantFile)

## add identification information
msexp <- addIdentificationData(msexp, identFile)

## access featureData
fData(msexp)

idSummary(msexp)
}

\keyword{methods}
