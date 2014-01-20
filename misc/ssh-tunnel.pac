/**
* .pac files are for automated proxy configuration
* This is a fix for chrome to use SOCKS5 as it assumes SOCKS4
*/
function FindProxyForURL(url, host)
{
// no proxy for localhost
if (host.match('localhost') return false;
// proxy for other hosts
return "SOCKS5 localhost:8111";
}
