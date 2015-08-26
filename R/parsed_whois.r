#' Parsed Whois
#'
#' The Parsed Whois API provides parsed information extracted from the raw
#' Whois record. The API is optimized to quickly retrieve the Whois record,
#' group important data together and return a well-structured format. The
#' Parsed Whois API is ideal for anyone wishing to search for, index, or
#' cross-reference data from one or multiple Whois records.
#'
#' The successful retrieval and parsing of a record will always return at least
#' two key pieces of information in its response; the most recent Whois record
#' of the domain you requested and the parsed out data. In rare cases, parsing
#' a record may not be successful. If that occurs, the system will respond
#' with an 206 (partial content) and return an error code with error message.
#' It will still return the Whois record even if it has failed to parse.
#'
#' The Parsed Whois API formatting returns astructure that contains key-value
#' pairing data grouped together by similar data characteristics. Some key data
#' points include contact information for registrant, admins, tech, billing
#' information, registrar information, registrar, name servers, and important
#' date information about the record like expiration, created, and updated. In
#' addition, each piece of data that is parsed is normalized to a consistent
#' format to ensure consistency. Normalization affects dates, country and phone
#' number data as well as lowercases all data parsed. In the event that a
#' normalization could not be applied, the original parsed data is returned for
#' that specific key/value pairing.
#'
#' @param domain domain to perform the Whois query on
#' @note Not all data elements will be available for all domains. What is
#'       available depends on the Whois record returned for that domain.
#' @export
#' @references \url{http://www.domaintools.com/resources/api-documentation/parsed-whois/}
#' @return a \code{list} of parsed Whois result detais for the \code{domain}
#' @examples
#' parsed_whois("domaintools.com")
#' parsed_whois("dailychanges.com")
parsed_whois <- function(domain) {

  url <- paste0(domaintools_url_base, trimws(domain), "/whois/parsed")

  res <- POST(url,
              query=list(api_username=domaintools_username(),
                         api_key=domaintools_api_key()))

  warn_for_status(res)

  jsonlite::fromJSON(content(res, as="text"))

}
