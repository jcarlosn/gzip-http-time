<?php
/*
* Proof of concept
* Get HTTP Server remote date using HTTP GZIP compression
*
* usage: php time.php example.com
*
* This script is a quick and dirty PoC for getting the remote date of a server by reading
* the information contained in the gzip header of a compressed HTTP Response
*
* Author: Jose Carlos Norte (jcarlos.norte@gmail.com)
*
*/

if(count($argv) < 2) {
	echo "Try to get the remote time set at a specific web server by using the gzip headers in the response\n";
	echo "Usage: time.php <URL>\n\n";
	exit;
}
$host = $argv[1];

date_default_timezone_set('UTC');

$bytes = shell_exec("curl -sL0 --raw --compressed -k http://".$host);
if(ord($bytes{1}) == 139 && ord($bytes{0}) == 31) {
	$timebytes = substr($bytes, 4, 4);

	$rdate = unpack("V", $timebytes);
	$rdate = $rdate[1];

	if(!$rdate) {
		echo "Error: the server has not specified the time of compression in the gzip headers\n";
		exit;
	}
	echo "The server that processed the request on: ".$host." has local date set to: \n";
	echo date('l jS \of F Y h:i:s A', $rdate);
	echo "\n";
} else {
	echo "Error: HTTP Response is not gzip encoded\n";
}

?>

