# gzip-http-time

PoC for getting remote HTTP Server date using gzip compressed HTTP Response.

This script is a quick and dirty PoC for getting the remote date of a server by reading
the information contained in the gzip header of a compressed HTTP Response.

This can be used to guess the country, or at least the timezone where a TOR hidden service is located.
