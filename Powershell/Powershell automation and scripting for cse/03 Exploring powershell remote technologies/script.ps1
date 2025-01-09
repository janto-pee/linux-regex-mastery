As one of the main purposes of PowerShell is automating administration tasks, PowerShell remoting
(PSRemoting) plays a big part in administrating multiple computers at the same time: using only a
single command, you can run the same command line on hundreds of computers

as for PSRemoting: if you don’t harden your configuration
and use insecure settings, attackers can leverage that and use your computers against you
In this chapter, you will learn about the following topics:
• Working remotely with PowerShell
• Enabling PowerShell remoting
• PowerShell endpoints (session configurations)
• PowerShell remoting authentication and security considerations
• Executing commands using PowerShell remoting
• Working with PowerShell remoting
• PowerShell remoting best practices

While PSRemoting can work with a variety of authentication methods, the default protocol for domain
authentication is Kerberos. This is the most secure and commonly used method of authentication
in Active Directory environments, which is where most people using PSRemoting are likely to be
operating. So, when Kerberos is not available, PSRemoting will fall back to NTLM to also support
workgroup authentication.

Windows PowerShell supports remoting over different technologies. By default, PSRemoting uses
Windows Remote Management (WinRM) as its transport protocol. However, it’s important to
note that WinRM is just one of several protocols that can be used to support remote management
in PowerShell. PSRemoting itself is a specific protocol (PSRP) that governs the way that PowerShell
manages input, output, data streams, object serialization, and more. PSRP can be supported over a
variety of transports, including WS-Management (WS-Man), Secure Shell (SSH), Hyper-V VMBus,
and others. While Windows Management Instrumentation (WMI) and Remote Procedure Call
(RPC) are remote management technologies that can be used with PowerShell, they are not considered
part of the PSRemoting protocol.

This difference between those remote management technologies is also reflected in the protocol that’s
being used:

PowerShell remoting using WinRM
PowerShell remoting using WinRM
DMTF (formerly known as the Distributed Management Task Force) is a non-profit organization
that defines open manageability standards, such as the Common Information Model (CIM), and
also WS-Management.
WS-Management defines a Simple Object Access Protocol (SOAP)-based protocol that can be used
to manage servers and web services.
Microsoft’s implementation of WS-Management is WinRM.
As soon as you attempt to establish a PSRemoting connection, the WinRM client sends SOAP messages
within the WS-Management protocol over HTTP or HTTPS.
PSRemoting, when using WinRM, listens on the following ports:
• HTTP: 5985
• HTTPS: 5986
Once traffic is received, the WinRM service determines which PowerShell endpoint or application
the traffic is meant for and forwards it:
As WinRM and WS-Management are the default when establishing remote connections, this chapter
will mostly focus on those technologies. But for completeness, I will shortly introduce all other possible
remoting technologies in this section

Windows Management Instrumentation (WMI) and Common
Information Model (CIM)
WMI is Microsoft’s implementation of CIM, an open standard designed by DMTF
CIM defines how IT system elements are represented as objects and how they relate to each other. This
should offer a good way to manage IT systems, regardless of the manufacturer or platform.
WMI relies on the Distributed Component Object Model (DCOM) and RPC, which is the underlying
mechanism behind DCOM, to communicate.
DCOM was created to let the Component Object Model (COM) communicate over the network and
is the predecessor of .NET Remoting.

WMI cmdlets
WMI cmdlets were deprecated starting with PowerShell Core 6 and should not be used in newer
versions of PowerShell.
To find all the cmdlets and functions that have the wmi string included in their name, leverage the
Get-Command cmdlet. With the -CommandType parameter, you can specify what kind of commands
you want to look for. In this example, I am searching for cmdlets and functions:
> Get-Command -Name *wmi* -CommandType Cmdlet,Function
An example of how to work with WMI is via the Get-WmiObject cmdlet. Using this cmdlet, you
can query local and remote computers.
You can use the -List parameter to retrieve all available WMI classes on your computer:
> Get-WmiObject -List
Here’s an example of how to use Get-WmiObject to retrieve information about Windows services
on your local computer:
> Get-WmiObject -Class Win32_Service
Not only can you query your local computer, but you can also query a remote computer by using the
-ComputerName parameter, followed by the name of the remote computer. The following example
shows how to retrieve the same information from the PSSec-PC02 remote computer:
> Get-WmiObject -Class Win32_Service -ComputerName PSSec-PC02
The preceding code returns a list of all services that are available on the remote computer
By using the -Query parameter, you can even specify the query that should be run against the
CIM database of the specified computer. The following command only retrieves all services with the
name WinRM:
> Get-WmiObject -ComputerName PSSec-PC02 -Query "select * from win32_
service where name='WinRM'"

Using PowerShell WMI cmdlets, you can also call WMI methods, delete objects, and much more.
Did you know?
RPC, on which WMI relies, is no longer supported in PowerShell Core 6. This is due in part to
PowerShell’s goal of cross-platform compatibility: from PowerShell version 7 and above, RPC
is only supported on machines running the Windows operating system

CIM cmdlets
At some point, the WMI cmdlets drifted away from the DMTF standards, which prevented crossplatform management. So, Microsoft moved back to being compliant with the DMTF CIM standards
by publishing the new CIM cmdlets.
To find out all CIM-related cmdlets, you can leverage the Get-Command cmdlet:
> Get-Command -Name "*cim*" -CommandType Cmdlet,Function

Open Management Infrastructure (OMI)
To help with a cross-platform managing approach, Microsoft created the Open Management
Infrastructure (OMI) in 2012 (https://github.com/Microsoft/omi), but it never really
became that popular and isn’t used broadly anymore. Therefore, Microsoft decided to add support
for SSH remoting.

PowerShell remoting using SSH
To enable PSRemoting between Windows and Linux hosts, Microsoft added support for PSRemoting
over SSH with PowerShell 6.
PSRemoting via SSH requirements
To use PSRemoting via SSH, PowerShell version 6 or above and SSH need to be installed on all
computers. Starting from Windows 10 version 1809 and Windows Server 2019, OpenSSH for
Windows was integrated into the Windows operating system

PowerShell remoting on Linux
As a first step, to use PowerShell on Linux, install PowerShell Core by following the steps for your
operating system
Configure /etc/ssh/sshd_config with the editor of your choice. In my example, I am using vi:
> vi /etc/ssh/sshd_config
First, add a PowerShell subsystem entry to your configuration:
Subsystem powershell /usr/bin/pwsh -sshs -NoLogo
In Linux systems, the PowerShell executable is typically located at /usr/bin/pwsh by default.
Please make sure you adjust this part if you installed PowerShell in a different location.
To allow users to log on remotely using SSH, configure PasswordAuthentication
and/or PubkeyAuthentication:
• If you want to allow authentication using a username and a password, set
PasswordAuthentication to yes:
PasswordAuthentication yes
• If you want to enable a more secure method, set PubkeyAuthentication to yes:
PubkeyAuthentication yes

PubkeyAuthentication, which stands for public key authentication, is a method of authentication
that relies on a generated key pair: a private and a public key is generated. While the private key is
kept safe on the user’s computer, the public key is entered on a remote server.

When the user authenticates using this private key, the server can verify the user’s identity using their
public key. A public key can only be used to verify the authenticity of the private key or to encrypt
data that only the private key can encrypt.
Using public key authentication for remote access not only protects against the risk of password
attacks such as brute-force and dictionary attacks but also offers an additional layer of security in case
the server gets compromised. In such cases, only the public key can be extracted while the private
key remains safe.

You can learn how to generate a key pair using the ssh-keygen tool at https://www.ssh.com/
ssh/keygen/.
If you are interested in how public key authentication works, you can read more about it on the official
SSH website: https://www.ssh.com/ssh/public-key-authentication

Of course, both authentication mechanisms can be configured at the same time, but if you use
PubkeyAuthentication and no other user connects using their username and password, you
should use PubkeyAuthentication only:
PasswordAuthentication no
PubkeyAuthentication yes

If you want to learn more about the different options of the sshd configuration file, I highly recommend
that you look at the man pages: https://manpages.debian.org/jessie/opensshserver/sshd_config.5.en.html

Restart the ssh service:
> /etc/init.d/ssh restart
The updated configuration is loaded into memory to activate the changes

PowerShell remoting on macOS
To enable PSRemoting over SSH to manage macOS systems, the steps are quite similar to those when
enabling PSRemoting on a Linux system: the biggest difference is that the configuration files are in
a different location

Edit the ssh configuration:
> vi /private/etc/ssh/sshd_config
Create a subsystem entry for PowerShell:
Subsystem powershell /usr/local/bin/pwsh -sshs -NoLogo
Then, define what kind of authentication you want to configure for this machine:
• Username and password:
PasswordAuthentication yes
• Public key authentication:
PubkeyAuthentication yes
Restart the ssh service to load the new configuration:
> sudo launchctl stop com.openssh.sshd
> sudo launchctl start com.openssh.sshd

PowerShell remoting via SSH on Windows
However, if you want to enable PSRemoting via SSH on your Windows systems, make sure you install
OpenSSH and follow the instructions on how to set up PSRemoting over SSH on Windows:

Enabling PowerShell remoting
Enabling PowerShell remoting manually
If you want to enable PSRemoting on a single machine, this can be done manually by using the
Enable-PSRemoting command on an elevated shell:
> Enable-PSRemoting
In this example, the command ran successfully, so PSRemoting was enabled on this machine
If you’re wondering about the difference between Enable-PSRemoting and winrm quickconfig,
the truth is that there is not much difference technically

Set-WSManQuickConfig error message
Depending on your network configuration, an error message may be shown if you try to enable
PSRemoting manually:
This error message was generated by the Set-WSManQuickConfig command, which is called
during the process of enabling PSRemoting.
This message is shown if one network connection is set to public because, by default, PSRemoting is
not allowed on networks that were defined as public networks:
> Get-NetConnectionProfile

To avoid this error, there are two options:
• Configure the network profile as a private network.
• Enforce Enable-PSRemoting so that the network profile check is skipped.
If you are certain that the network profile is not a public one and instead a network that you trust,
you can configure it as a private network:
> Set-NetConnectionProfile -NetworkCategory Private
If you don’t want to configure the network as a trusted, private network, you can enforce skipping the
network profile check by adding the -SkipNetworkProfileCheck parameter:
> Enable-PSRemoting -SkipNetworkProfileCheck

Checking your WinRM configuration
After enabling PSRemoting and WinRM, you might want to check the current WinRM configuration.
You can achieve this using winrm get winrm/config:
To change your local WinRM configuration, you can use the set option:
> winrm set winrm/config/service '@{AllowUnencrypted="false"}'

Alternatively, you can use the wsman:\ PowerShell drive to access and modify specific items in the
configuration. Using the wsman:\ provider allows you to access and modify specific items of the
WinRM configuration in a more intuitive and cmdlet-like way, with the added benefit of built-in help
and documentation.

To change your local WinRM configuration, you can use the Set-Item cmdlet with the wsman:\
provider to access and modify the WinRM configuration items. For example, to disable the use of
unencrypted traffic, you can run the following command:
> Set-Item wsman:\localhost\Service\AllowUnencrypted -Value $false

Trusted hosts
If you are connecting to a machine that is not domain-joined, which might be the reason why you
configure it manually, Kerberos authentication is not an option and the NTLM protocol should be
used for authentication instead.
In this case, you need to configure the remote machine to be considered a trusted host in WS-Man
on your local device; otherwise, the connection will fail.
To configure TrustedHosts for a remote host, you can use the Set-Item cmdlet, along with the
wsman:\localhost\client\TrustedHosts path. By default, this value is empty, so you
need to add the IP address or domain name of the remote host. To add a new value without replacing
the existing ones, use the -Concatenate switch, as shown here:
> Set-Item wsman:\localhost\client\TrustedHosts -Value 172.29.0.12
-Concatenate -Force

To verify that your changes were applied, you can use the Get-Item cmdlet to display the current
TrustedHosts configuration:
> Get-Item wsman:\localhost\client\TrustedHosts
The preceding example shows that the host with an IP address of 172.29.0.12 has been configured
as a trusted host on the local machine.
It is also a good practice to audit the TrustedHosts list to detect any unauthorized changes. This
can help in detecting tampering attempts on your system.

Connecting via HTTPS
Optionally, you can also configure a certificate to encrypt the traffic over HTTPS. To ensure secure
PSRemoting, it is recommended that you configure a certificate to encrypt the traffic over HTTPS,
especially in scenarios where Kerberos is not available for server identity verification.
Therefore, to provide an extra layer of security, it can make sense to issue a certificate and enable
WinRM via SSL.

If you haven’t purchased a publicly signed SSL certificate from a valid certificate authority (CA),
you can create a self-signed certificate to get started. However, if you’re using this for workgroup
remoting, you can also use an internal CA. This can provide additional security and trust since you
have a trusted source within the organization sign the certificate.

This section only covers how to issue and configure a self-signed certificate. So, make sure you adjust
the steps if you are using a publicly signed certificate or an internal CA.
First, let’s get a self-signed certificate! This step is very easy if you are working on Windows Server
2012 and above – you can leverage the New-SelfSignedCertificate cmdlet:
> $Cert = New-SelfSignedCertificate -CertstoreLocation Cert:\
LocalMachine\My -DnsName "PSSec-PC01"
> Export-Certificate -Cert $Cert -FilePath C:\tmp\cert
Make sure that the value provided via the -DnsName parameter matches the hostname and that a
matching DNS record exists in your DNS server.
Add an HTTPS listener:
> New-Item -Path WSMan:\LocalHost\Listener -Transport HTTPS -Address *
-CertificateThumbPrint $Cert.Thumbprint –Force
Finally, make sure you add an exception for the firewall. The default port for WinRM over HTTPS
is 5986:
> New-NetFirewallRule -DisplayName "Windows Remote Management
(HTTPS-In)" -Name "Windows Remote Management (HTTPS-In)" -Profile Any
-LocalPort 5986 -Protocol TCP

If you want to ensure that only HTTPS is used, remove WinRM’s HTTP listener:
> Get-ChildItem WSMan:\Localhost\listener | Where -Property Keys -eq
"Transport=HTTP" | Remove-Item -Recurse

In some cases, you may want to move the WinRM listener to a different port. This can be useful if
your firewall setup does not allow port 5986 or if you want to use a non-standard port for security
reasons. To move the WinRM listener to a different port, use the Set-Item cmdlet:
> Set-Item WSMan:\Localhost\listener\<ListenerName>\port -Value
<PortNumber>

it’s important to make
sure that it also has these usage restrictions. Additionally, ensure that the root certificate is protected
properly since attackers can use it to forge SSL certificates for trusted websites.

Once you have the appropriate certificate, copy it to a secure location on the computer from where you
want to connect to the remote machine (such as C:\tmp\cert in our example), and then import
it into the local certificate store:
> Import-Certificate -Filepath "C:\tmp\cert" -CertStoreLocation
"Cert:\LocalMachine\Root"
Specify the credentials that you want to use to log in and enter your session. The -UseSSL parameter
indicates that your connection will be encrypted using SSL:
> $cred = Get-Credential
> Enter-PSSession -ComputerName PSSec-PC01 -UseSSL -Credential $cred

Configuring PowerShell Remoting via Group Policy
When working with multiple servers, you may not want to enable PSRemoting manually on each
machine, so Group Policy is the tool of your choice
Using Group Policy, you can configure multiple machines using a single Group Policy Object (GPO)

To get started, create a new GPO: open Group Policy Management, right-click on the Organizational
Unit (OU) in which you want to create the new GPO, and select Create a GPO in this domain, and
Link it here….
GPO is only a tool to configure your machines – it doesn’t start services. Therefore, you still need to
find a solution to reboot all configured servers or start the WinRM service on all servers.
If you want to enable PSRemoting remotely, Lee Holmes has written a great script that leverages
WMI connections (which most systems support): http://www.powershellcookbook.com/
recipe/SQOK/program-remotely-enable-powershell-remoting

Allowing WinRM
In the newly created GPO, navigate to Computer Configuration | Policies | Administrative Templates
| Windows Components | Windows Remote Management | WinRM Service and set the Allow
remote server management through WinRM policy to Enabled.
In this policy, you can define the IPv4 and IPv6 filters. If you don’t use a protocol (for example, IPv6),
theTo allow connections, you can use the wildcard character, *, an IP, or an IP range

Therefore, nowadays, I use the wildcard character, *, but only in combination with a firewall IP
restriction, to secure my setup. We will configure the firewall IP restriction later in this section
(see Creating a firewall rule):

Caution!
Only use the wildcard (*) configuration if you wish to restrict via a firewall rule that remote
IPs are allowed to connect to.

Configuring the WinRM service to start automatically
To configure the WinRM service so that it starts automatically, follow these steps:

Note
This setting only configures the service to start automatically, which usually happens when
your computer starts. It does not start the service for you, so make sure that you reboot your
computer (or start the service manually) so that the WinRM service starts automatically

Creating a firewall rule
To configure the settings of the firewall, follow these steps:

PowerShell endpoints (session configurations)
When we are talking about PowerShell endpoints, each endpoint is a session configuration, which you
can configure to offer certain services or which you can also restrict.
So, every time we run Invoke-Command or enter a PowerShell session, we are connecting to an
endpoint (also known as a remote session configuration).
Sessions that offer fewer cmdlets, functions, and features, as those that are usually available if no
restrictions are in place, are called constrained endpoints.
Before we enable PSRemoting, no endpoint will have been configured on the computer.
You can see all the available session configurations by running the
Get-PSSessionConfiguration command:
However, once the
WinRM service is started, the endpoints are already configured and ready to use, but not exposed
and cannot be connected to until PSRemoting is enabled.
Enabling PSRemoting using Enable-PSRemoting, as we did in the previous section, creates
all default session configurations, which are necessary to connect to this endpoint via PSRemoting:

Typically, in Windows PowerShell 3.0 and above, there are three default preconfigured endpoints on
client systems
microsoft.powershell, microsoft.powershell32, microsoft.powershell.workflow
On server systems, there’s typically a fourth session configuration that’s predefined:
• microsoft.windows.servermanagerworkflows

Connecting to a specified endpoint
By default, the microsoft.powershell endpoint is used for all PSRemoting connections.
But if you want to connect to another specified endpoint, you can do this by using the
-ConfigurationName parameter:
> Enter-PSSession -ComputerName PSSec-PC01 -ConfigurationName
'microsoft.powershell32'

Creating a custom endpoint – a peek into JEA
Creating a custom endpoint (also known as Just Enough Administration or JEA) allows you to
define a restricted administrative environment for delegated administration.
With JEA, you can define
a set of approved commands and parameters that are allowed to be executed on specific machines
by specific users. This enables you to give users just enough permissions to perform their job duties,
without granting them full administrative access
You can restrict the session so that only predefined commands will be run.
• You can enable transcription so that every command that is executed in this session is logged.
• You can specify a security descriptor (SDDL) to determine who is allowed to connect and
who isn’t.
• You can configure scripts and modules that will be automatically loaded as soon as the connection
to this endpoint is established.
• You can even specify that another account is used to run your commands in this session on
the endpoint.
To create and activate an endpoint, two steps need to be followed:
1. Creating a session configuration file
2. Registering the session as a new endpoint

Using New-PSSessionConfigurationFile, you can create an empty skeleton session
configuration file.
A session configuration file ends with the .pssc filename extension, so
make sure you name the file accordingly:
> New-PSSessionConfigurationFile -Path <Path:\To\Your\
SessionConfigurationFile.pssc>
You can either generate an empty session configuration file and populate it later using an editor or
you can use the New-PSSessionConfigurationFile parameters to directly generate the file
with all its defined configuration options:

For this example, we will create a session configuration file for a RestrictedRemoteServer session:
> New-PSSessionConfigurationFile -SessionType RestrictedRemoteServer
-Path .\PSSessionConfig.pssc
By using -SessionType RestrictedRemoteServer, only the most important commands are
being imported into this session, such as Exit-PSSession, Get-Command, Get-FormatData,
Get-Help, Measure-Object, Out-Default, and Select-Object. If you want to allow
other commands in this session, they need to be configured in the role capability file

Registering the session as a new endpoint
After creating the session configuration file, you must register it as an endpoint by utilizing the
Register-PSSessionConfiguration command.
> Register-PSSessionConfiguration -Name PSSessionConfig
The session configuration will be registered, and a new endpoint will be created. Sometimes, it might
be necessary to restart the WinRM service after registering an endpoint:
> Get-PSSessionConfiguration -Name PSSessionConfig

PowerShell remoting authentication and security
considerations
PSRemoting traffic is encrypted by default – regardless of whether a connection was initiated via
HTTP or HTTPS. The underlying protocol that’s used is WS-Man, which is decoupled to allow it to
be used more broadly. PSRemoting uses an authentication protocol, such as Kerberos or NTLM, to
authenticate the session traffic, and SSL/TLS is used to encrypt the session traffic, regardless of whether
the connection was initiated via HTTP or HTTPS
But similar to every other computer, PSRemoting is only as secure as the computer that’s been
configured
Therefore, you should also put effort into hardening your infrastructure and securing your most
valuable identities
It’s important to understand that enabling PSRemoting does not automatically ensure a secure
environment. As with any remote management technology, it’s critical to harden your systems and
take appropriate security measures to protect against potential threats.
First, let’s have a look at how authentication is used within PSRemoting

Authentication
By default, WinRM uses Kerberos for authentication and falls back to NTLM in case Kerberos
authentication is not possible

When used within a domain, Kerberos is the standard to authenticate. To use Kerberos for authentication
in PSRemoting, ensure that both the client and server computers are connected to the same domain
and that the DNS names have been properly configured and are reachable. It’s also important to note
that from a Kerberos perspective, the server must be registered in Active Directory.
In general, you can specify which protocol should be used when connecting to a remote computer:
> Enter-PSSession -ComputerName PSSEC-PC01 -Authentication Kerberos

Typically, Kerberos is the preferred protocol, but if it’s not available or supported, the system will fall
back to using NTLM. More information about Negotiate can be found in the Microsoft documentation
for Negotiate in Win32 applications:

What are the circumstances for an NTLM fallback?
PSRemoting was designed to work with Active Directory, so Kerberos is the preferred authentication
protocol. But in some cases, Kerberos authentication is not possible and NTLM is used
Kerberos:
• Computers are joined to the same domain or are both within domains that trust each other.
• The client can resolve the server’s hostname or IP address.
• The server has a valid Service Principal Name (SPN) registered in Active Directory. The SPN
matches the target you are connecting to.
NTLM:
• Commonly used to connect to non-domain-joined workstations
• If IP addresses are used instead of DNS names
To connect to the PSSec-PC01 computer via Kerberos, we can use the following command:
> Enter-PSSession -ComputerName PSSec-PC01
If no credentials were explicitly specified, if the current user has permission to access the remote
computer, and if the remote computer is configured to accept Kerberos authentication, the connection
will be established automatically without the need to provide any explicit credentials. This is one of
the benefits of using Kerberos authentication, as the authentication process is implicit and seamless
for the user.
If the current user does not have permission to access the remote computer, we can also specify
explicitly which credentials should be used with the -Credential parameter. To simplify testing,
we use Get-Credential to prompt for the credentials and store them in the $cred secure string:
$cred = Get-Credential -Credential "PSSEC\Administrator"
Then, we connect via Kerberos:
Enter-PSSession -ComputerName PSSEC-PC01 -Credential $cred

If you capture the traffic using Wireshark, you will see that WinRM includes Kerberos as its contenttype as part of its protocol, indicating that Kerberos was used for authentication. While the actual
Kerberos traffic itself may not be visible in the HTTP packet, the use of Kerberos for authentication
can still be confirmed by examining the headers in the WinRM traffic. Additionally, you can see that
the entire HTTP session is encrypted, providing an added layer of security:

The level of encryption provided by each authentication protocol is as follows:
• Basic authentication: No encryption.
• NTLM authentication: RC4 cipher with a 128-bit key.
• Kerberos authentication: etype in the TGS ticket determines the encryption. On modern
systems, this is typically AES-256.
• CredSSP authentication: The TLS cipher suite that was negotiated in the handshake will be used.

If you are connecting to a remote computer in the same domain, with working DNS names, NTLM
is still used to connect if the host IP address is specified instead of the hostname:
Enter-PSSession -ComputerName 172.29.0.12 -Credential $cred

Capturing the traffic with Wireshark once more reveals that NTLM was used to authenticate and that
the traffic is encrypted as well:

Similar to connecting with Kerberos, you can see that a connection is established to the host,
172.29.0.12, using WinRM over HTTP (port 5985). But this time, NTLM is used instead of
Kerberos to negotiate the session. Using NTLM, you can even capture the hostname, the username,
the domain name, and the challenge, which is used for authentication.
Going deeper into the TCP stream, it becomes evident that the communication is once again encrypted,
even when NTLM is used, as shown in the following screenshot

When using NTLM authentication, please note that PSRemoting only works if the remote host was
added to the TrustedHosts list.

When using NTLM authentication, it’s important to understand the limitations of the TrustedHosts
list. While adding a remote host to the TrustedHosts list can help you catch your mistakes, it’s
not a reliable way to ensure secure communication. This is because NTLM can’t guarantee that
you are connecting to the intended remote host, which makes using TrustedHosts misleading.
It’s important to note that the main weakness of NTLM is its inability to verify the identity of the
remote host. Therefore, even with TrustedHosts, NTLM connections shouldn’t be considered
more trustworthy
If the host is not specified as a trusted host and if the credentials are not explicitly provided (like
we did when using -Credential $cred), establishing a remote session or running commands
remotely will fail and show an error message:
> Enter-PSSession -ComputerName 172.29.0.10

Authentication protocols
Of course, it is also possible to configure which authentication method should be used by specifying
the -Authentication parameter.
If it is possible to use Kerberos authentication, you should always use Kerberos, as this protocol
provides most security features.
Proceed to Chapter 6, Active Directory – Attacks and Mitigation, to learn more about authentication
and how Kerberos and NTLM work.

The following are all accepted values for the -Authentication parameter:Basic, default,...

Basic authentication security considerations
If used without any additional encryption layers, basic authentication is not secure.
Caution!
Do not configure this in your production environment as this configuration is highly insecure and
is only shown for testing purposes. You will compromise yourself if you use this configuration!
If you want to configure your test environment to use basic authentication and allow unencrypted
traffic, you need to configure your WinRM configuration to allow basic authentication, as well as
unencrypted traffic.
In this example, PSSec-PC01 is the remote host to which we want to connect using unencrypted traffic
and basic authentication. We will connect from a management machine, which will be PSSec-PC02.
When we try to authenticate from PSSec-PC02 to PSSec-PC01 (the IP address is 172.29.0.12)
using the -Authentication Basic parameter, we get a message stating that we need to provide
a username and a password to authenticate using basic authentication:
Once we provide these credentials, we are still not able to authenticate and get another error message
stating that access has been denied. The reason for this is that basic authentication is an insecure
authentication mechanism if it’s not protected by TLS
So, let’s configure basic authentication explicitly in our demo setup, knowing that we will weaken our
configuration on purpose. First, allow unencrypted traffic on PSSec-PC01:
> winrm set winrm/config/service '@{AllowUnencrypted="true"}'
Remember to differentiate between service and client configuration. As we want to connect to
PSSec-PC01, we will connect to the WinRM service, so we are configuring service.
Next, configure basic authentication to be allowed:
> winrm set winrm/config/service/auth '@{Basic="true"}'
After making changes to the WinRM configuration, it is important to restart the WinRM service for
the new configuration to take effect:
> Restart-Service -Name WinRM
Now, let’s configure PSSec-PC02 to establish unencrypted connections to other devices using
basic authentication.
First, we must configure the client so that unencrypted connections can be initialized:
> winrm set winrm/config/client '@{AllowUnencrypted="true"}'
Then, we must make sure that the client is allowed to establish connections using basic authentication:
> winrm set winrm/config/client/auth '@{Basic="true"}'
Lastly, restart the WinRM service to load the new configuration:
> Restart-Service -Name WinRM

Again, this configuration exposes your devices and makes them vulnerable. Specifically, it exposes
your credentials to potential attackers who could intercept network traffic while you connect to your
machines. This could allow an attacker to gain unauthorized access to your systems and potentially
compromise sensitive data or perform malicious actions.
In productive environments,
it’s important to take appropriate security measures, such as enabling encryption and using secure
authentication protocols, to protect your devices and data.

Let’s connect from PSSec-PC02 to PSSec-PC01 (the IP address is 172.29.0.12) by using the
-Authentication parameter while specifying Basic, as well as the credentials for the PSSec user:
> $cred = Get-Credential -Credential "PSSec"

The session is being established. If I track the traffic using Wireshark, I will see the SOAP requests
that are being made. Even worse, I can see the Authorization header, which exposes the Base64-
encrypted username and password:
Base64 can be easily decrypted, for example, with PowerShell itself:
So, an attacker can easily find out that the password of the PSSec user is PS-SecRockz1234! and
can either inject the session as a man in the middle or use the password to impersonate the PSSec
user – a great start when they’re attacking the entire environment.

PowerShell remoting and credential theft
Depending on the authentication method that is used, credentials can be entered into the remote system,
which can be stolen by an adversary. If you are interested in learning more about credential theft
and mitigations, the Mitigating Pass-the-Hash (PtH) Attacks and Other Credential Theft white papers
are a valuable resource: https://www.microsoft.com/en-us/download/details.
aspx?id=36036.

By default, PSRemoting does not leave credentials on the target system, which makes PowerShell an
awesome administration tool.
But if, for example, PSRemoting with CredSSP is used, the credentials enter the remote system, where
they can be extracted and used to impersonate identities.
Keep in mind that when using CredSSP as an authentication mechanism, the credentials used to
authenticate to the remote system are cached on that system. While this is convenient for single sign-on
purposes, it also makes those cached credentials vulnerable to theft. If you can avoid it, do not use
CredSSP as an authentication mechanism. But if you choose to use CredSSP, it is recommended that
you enable Credential Guard to help mitigate this risk.
We will have a closer look at authentication and how the infamous pass-the-hash attack works in
Chapter 6, Active Directory – Attacks and Mitigation.

Executing commands using PowerShell remoting
Sometimes, you may want to run a command remotely but have not configured PSRemoting. Some
cmdlets provide built-in remoting technologies that can be leveraged.

To get a list of locally available commands that have the option to run tasks remotely, use the
Get-Command -CommandType Cmdlet -ParameterName ComputerName command:
> Get-Command -ParameterName ComputerName
Cmdlets with a -ComputerName parameter do not necessarily use WinRM. Some use WMI, many
others use RPC – it depends on the underlying technology of the cmdlet.

Do not be confused!
PSRemoting should not be confused with using the -ComputerName parameter of a cmdlet
to execute it on a remote computer. They are distinct approaches with different capabilities
and usage scenarios. Those cmdlets that utilize the -ComputerName parameter rely on their
underlying protocols, which often need a separate firewall exception rule to run.

Executing single commands and script blocks
You can execute a single command or entire script blocks on a remote or local computer using the
Invoke-Command cmdlet:
Invoke-Command -ComputerName <Name> -ScriptBlock {<ScriptBlock>}
The following example shows how to restart the printer spooler on the PSSec-PC01 remote computer,
which is displaying verbose output:
> Invoke-Command -ComputerName PSSec-PC01 -ScriptBlock { RestartService -Name Spooler -Verbose }
VERBOSE: Performing the operation "Restart-Service" on target "Print
Spooler (Spooler)".
Invoke-Command is a great option for running local scripts and commands on a remote computer.
If you don’t want to copy the same scripts to your remote machine(s), you can use Invoke-Command
with the -FilePath parameter to run the local script on the remote system:
> Invoke-Command -ComputerName PSSec-PC01 -FilePath c:\tmp\test.ps1
When using the -FilePath parameter with Invoke-Command, it is important to keep in mind
that any dependencies required by the script (such as other scripts or commands) must also be present
on the remote system. Otherwise, the script will not run as expected.
You can also execute commands on multiple systems – just specify all the remote systems that you want
to execute your command or script on in the -ComputerName parameter. The following command
restarts the print spooler on PSSec-PC01 and PSSec-PC02:
> Invoke-Command -ComputerName PSSec-PC01,PSSec-PC02 {Restart-Service
-Name Spooler}

Working with PowerShell sessions
The -Session parameter indicates that a cmdlet or function supports sessions within PSRemoting.
To find all locally available commands that support the -Session parameter, you can use the
Get-Command -ParameterName session command:

Interactive sessions
By leveraging the Enter-PSSession command, you can initiate an interactive session. Once the
session has been established, you can work on the remote system’s shell:

Once your work is finished, use Exit-PSSession to close the session and the remote connection.
Persistent sessions
The New-PSSession cmdlet can be utilized to establish a persistent session.
As in a former example, we use Get-Credential once more to store our credentials as a secure
string in the $cred variable.
Using the following command, we create two sessions for the PSSec-PC01 and PSSec-PC01
remote computers to execute commands:
$sessions = New-PSSession -ComputerName PSSec-PC01, PSSec-PC02
-Credential $cred
To display all active sessions, you can use the Get-PSSession command:

A common use case is to check whether all security updates were applied to your remote computers.
In this case, we want to check whether the KB5023773 hotfix is installed on all remote computers.
We also don’t want any error messages to be displayed if the hotfix was not found, so we will use the
-ErrorAction SilentlyContinue parameter in our code snippet:
Invoke-Command –Session $sessions -ScriptBlock { Get-Hotfix -Id
'KB5023773' -ErrorAction SilentlyContinue }
The following is the output we get after running this command:

To act on this and install the missing update, we can either send more commands directly into the
session or we can enter the session interactively by specifying the session ID – that is, EnterPSSession -Id 2:

Now that we have entered the session, we can run the Get-WindowsUpdate command to install
the missing update. Please note that this command is not available by default and requires you to
install the PSWindowsUpdate module:
Get-WindowsUpdate -Install -KBArticleID 'KB5023773'

Note
If you are using an interactive session, all executed modules, such as PSWindowsUpdate,
need to be installed on the remote system. If you use Invoke-Command to run commands
in a persistent session, the module only needs to be installed on the computer that you use to
run the commands:
Invoke-Command – Session $sessions -ScriptBlock { Get-WindowsUpdate
-Install -KBArticleID ‘KB5023773’}

As soon as we are finished with our work and if we don’t need our sessions anymore, we can remove
them using the Remove-PSSession command:
• Here, we can use the $sessions variable, which we specified earlier:
Remove-PSSession -Session $sessions
• Alternatively, we can remove a single session by using the -id parameter:
Remove-PSSession -id 2
After removing one or all session(s), you can use Get-PSSession to verify this:

Best practices
To ensure optimal security and performance when using PSRemoting, it’s important to follow the
best practices enforced by the product. These practices are designed to minimize the risk of security
breaches and ensure that your remote management tasks run smoothly.
Authentication:
• If possible, use only Kerberos or NTLM authentication.
• Avoid CredSSP and basic authentication whenever possible.
• In the best case, restrict the usage of all other authentication mechanisms besides Kerberos/NTLM.
• SSH remoting – configure public key authentication and keep the private key protected.
Limit connections:
• Limit connections via firewall from a management subnet (hardware and software
if possible/available).
PSRemoting’s default firewall policies differ based on the network profile. In a Domain,
Workgroup, or Private network profile, PSRemoting is available to all by default (assuming
they have valid credentials). In a Public profile, PSRemoting refuses to listen to that adapter
by default. If you force it to, the network rule will limit access to only systems on the same
network subnet.
• Use a secure management system to manage systems via PSRemoting. Consider limiting
connections from a management virtual network (VNet) if you have one, which also applies
to other management protocols such as RDP, WMI, CIM, and others.
• Use a secure management system to manage systems via PSRemoting. Use the clean source
principle to build the management system and use the recommended privileged access model:
 https://learn.microsoft.com/en-us/security/privileged-accessworkstations/privileged-access-success-criteria#clean-sourceprinciple
 https://learn.microsoft.com/en-us/security/privileged-accessworkstations/privileged-access-access-model
Restrict sessions:
• Use constrained language and JEA.
• You will learn more about JEA, constrained language, session security, and SDDLs in Chapter 10,
Language Modes and Just Enough Administration (JEA).
Audit insecure settings:
• Use the WinRM group policy to enforce secure PSRemoting settings on all managed systems,
including encryption and authentication requirements.
• Get-Item WSMan:\localhost\Client\AllowUnencrypted: This setting should
not be set to $true.
• Audit insecure WinRM settings regularly to ensure compliance with security policies:
Get-Item WSMan:\localhost\client\AllowUnencrypted
Get-Item wsman:\localhost\service\AllowUnencrypted
Get-Item wsman:\localhost\client\auth\Basic
Get-Item wsman:\localhost\service\auth\Basic
• Eventually, use Desired State Configuration (DSC) to audit and apply your settings.




































































