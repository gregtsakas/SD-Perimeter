# SD-Perimeter

This project is mostly feature complete, however, things should be considered Beta quality at this point.  Contributors and questions are welcome.

This project is focused on providing a set of scripts that can be used to create a Software Defined Perimeter using open source tools readily available in common Linux distributions. The techniques implemented here are heavily influenced by Google's <a href="https://www.beyondcorp.com/">BeyondCorp</a> and the Cloud Security Alliance model of <a href="https://cloudsecurityalliance.org/group/software-defined-perimeter/#_overview">Software Defined Perimeter</a>.

![alt text](SD-Perimter%20Diagram.png "SD-Perimeter Diagram")

The architecture chosen here depends on two levels of SDP gateways.  A 'Broker' that sits in the cloud, outside of the traditional firewall, and a 'Gateway' that sits behind the firewall.  The 'Broker' is a special type of gateway that forwards traffic to another gateway before it is forwarded on to a protected resource.  The 'Broker' itself can also function as a direct gateway to a protected resource.  Using a 'Broker' provides three key benefits.  First, all devices connect directly to a broker, simplifying device configurations. Second, using an on premise 'Gateway' removes the need to open inbound firewall rules.  This is accomplished by the 'Gateway' making an outbound connection to the 'Broker'.  Lastly, by making all traffic go through a cloud-based 'Broker', protected resources are further obscured making them even more difficult for a potential hacker to locate.

Tools:

<a href="http://www.cipherdyne.org/">fwknop</a> - Used to allow the SDP server to remain completely hidden from unauthorized use.  With this tool, the gateway server can be configured with 0 inbound port access.  The net result is that the gateway server is more hardened against port scanning, DDoS attacks, etc.  This component will be optional as the client component is not readily available on all major platforms (ie. iPhone).  This project is definitely worth a look for anyone looking to contribute to a really awesome open source project!

<a href="https://openvpn.net/index.php/open-source.html">OpenVPN</a> - Used to ensure a completely encrypted communication channel between personal devices (laptop, cell phone, etc) and the gateway server.  OpenVPN includes support on every major platform and is simple to adjust the configuration to the user's needs.  In our model, we are not using OpenVPN in the traditional sense of a VPN as the gateway server will not be configured to forward traffic directly to an upstream device.  OpenVPN also supports additional authentication plugins allowing things like two-factor authentication to become possible. OpenVPN also provides the awesome PKI tool easy-rsa. easy-rsa gives us the ability to provision and manage certificates for all of our components.

<a href="http://www.squid-cache.org/">Squid</a> - Used to provide authorization to upstream resources.  Squid is being used because of it's ability to use external authentication helpers and assign access based on group memberships from either a common database, or LDAP server.  Squid also gives us the granularity to apply rules based on destination host, URI, port or a combination.

<a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Proxy_servers_and_tunneling/Proxy_Auto-Configuration_(PAC)_file">Proxy Auto-Configuration</a> - This is a simple a text file using javascript that can be loaded into a web browser to direct specific websites toward our Squid proxy.

<a href="https://github.com/darkk/redsocks">Redsocks Proxy</a> - This tool will be used to forward non-web traffic through our Squid proxy.
