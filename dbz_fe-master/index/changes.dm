/*
Common Gateway Interface (CGI)

This library may be included by writers of CGI programs.  Such programs are
executed by web servers, to generate web pages dynamically and to process
HTML form input.  To find out more, see CGI.html.

If your web environment is not the standard UNIX one assumed below, you will
need to assign world/executor to something else.

*/

#include <dantom/htmllib>

#define UNIX_CGI_TRUSTED_EXECUTOR "/usr/local/byond/bin/DreamDaemon -CGI -logself -trusted"
#define UNIX_CGI_SAFE_EXECUTOR "/usr/local/byond/bin/DreamDaemon -logself -CGI"

//assume a UNIX environment by default (and allow access to entire site)
world/executor = UNIX_CGI_TRUSTED_EXECUTOR
world/cache_lifespan = 0  //no point in caching uploaded files in CGI mode

//These are the environment variables defined by the web server.
//Use client.cgi.GetEnv() to see the associated value.
//Using the macros helps catch typos at compile-time.

#define SERVER_SOFTWARE   "SERVER_SOFTWARE"
#define SERVER_NAME       "SERVER_NAME"
#define GATEWAY_INTERFACE "GATEWAY_INTERFACE"
#define SERVER_PROTOCOL   "SERVER_PROTOCOL"
#define SERVER_PORT       "SERVER_PORT"
#define REQUEST_METHOD    "REQUEST_METHOD"
#define PATH_INFO         "PATH_INFO"
#define PATH_TRANSLATED   "PATH_TRANSLATED"
#define SCRIPT_NAME       "SCRIPT_NAME"
#define QUERY_STRING      "QUERY_STRING"
#define REMOTE_HOST       "REMOTE_HOST"
#define REMOTE_ADDR       "REMOTE_ADDR"
#define AUTH_TYPE         "AUTH_TYPE"
#define REMOTE_USER       "REMOTE_USER"
#define REMOTE_IDENT      "REMOTE_IDENT"
#define CONTENT_TYPE      "CONTENT_TYPE"
#define HTTP_ACCEPT       "HTTP_ACCEPT"
#define HTTP_USER_AGENT   "HTTP_USER_AGENT"
#define HTTP_REFERER      "HTTP_REFERER"
#define HTTP_REFERRER     "HTTP_REFERER" /*no, this is not a speling error!*/
#define HTTP_COOKIE       "HTTP_COOKIE"

CGI
	_dm_interface = 9
	var
		content_type = "text/html"
		expires = "0"       //by default, force expiration of all CGI output
		http_headers
		default_form
		Form/waiting_form   //in byond_mode, this is used to handle file uploads and other button clicks
		authenticate

		cookies[]
		params[]
		header_done
		byond_mode   //1 if we are using CGI object for Dream Seeker
	proc
		Login(new_url)
			if(usr.ckey != "guest") return usr.key //already logged in
			return ..()  //handled internally by DreamDaemon
		Logout(new_url)
			return ..()  //handled internally by DreamDaemon

		GetEnv(name) //get the value of the named CGI environment variable
			return world.GetConfig("env",name)
		SetCookie(name,value,expires,domain,path,secure)
			var/url_encoded[1]

			if(header_done)
				world.log << "Error: SetCookie() must be called before any other output."
			if(byond_mode)
				world.log << "Error: SetCookie() does not work in BYOND mode."

			if(http_headers) http_headers += "\n"
			http_headers += "Set-cookie: "
			url_encoded[1] = name
			http_headers += list2params(url_encoded)
			http_headers += "="
			if(value)
				url_encoded[1] = value
				http_headers += list2params(url_encoded)

			if(expires)
				if(istext(expires)) http_headers += "; expires=[expires]"
				else http_headers += "; expires=[time2text(expires,"DDD, DD-MMM-YYYY hh:mm:ss GMT")]"

			if(domain)
				http_headers += "; domain=[domain]"

			if(path)
				http_headers += "; path=[path]"

			if(secure)
				http_headers += "; secure=1"

		WebifyByondUrl(url)
			if(byond_mode) return url
			url = list2params(list("url" = url))
			return "http://www.byond.com/script/dms.cgi?[url]"

		Reroute(url)
			if(byond_mode)
				usr << link(url)
				return
			if(header_done)
				world.log << "Error: Reroute() must be called before any other output."

			if(http_headers) http_headers += "\n"
			http_headers += "Status: 302\nLocation: [url]"

			//in case browser does not automatically reroute (and this also flushes the HTTP header)
			usr << browse("<html><body><a href='[html_encode(url)]'>Continue.</a></body></html>")

		HttpHeader() //automatically called before any output
			if(http_headers) usr << http_headers
			if(expires)
				if(isnum(expires)) usr << "Expires: [time2text(expires,"DDD, DD-MMM-YYYY hh:mm:ss GMT")]"
				else usr << "Expires: [expires]"
			if(content_type) usr << "Content-type: [content_type]"
			header_done = 1

	Topic(){
		var
			mudName = "{YDrag({x{R*{x{Y)n{x{RBall Z: ({x{WFE{x{R){x {Y({x{DALPHA{x{Y){x";
			changes = world.Export("byond://dbzfe.com:4000?action=changes");
			//header = "<title>Drag(*)nBall Z: (FE) (ALPHA)</title><body bgcolor=#000000>"
			//footer = "</body>"
			content = "[mudName] {WChanges{x[breakL(4)][changes]"

		usr << rColor(content);
	}


//Tell forms to include form type in URL instead of a src reference
Form/form_cgi_mode = 1

Form/New()
	if(usr && usr.client && usr.client.CGI)
		form_byond_mode = usr.client.CGI.byond_mode
	return ..()

client
	var
		auto_cgi = 1           //in byond-mode, this enables automatic creation of client.CGI

	proc
		CreateCGI()
			if(!CGI)
				CGI = new/CGI()
				CGI.cookies = list()
				CGI.byond_mode = 1

//for testing without a web server (ie user runs world directly)
client/New(href)
	if(!CGI && auto_cgi)
		//normally this is automatically done in -CGI mode
		//but we must be running directly without a web server
		CreateCGI()
		if(!href) href = "" //older BYOND versions require href to be non-null in order for CGI.Topic() to get called in the default client.New() proc
	return ..()
