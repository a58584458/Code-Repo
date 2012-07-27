
NOTE:

To Develop Applications using ACR122JNI.dll:

* Copy the ACR122JNI.dll and acr122.dll into your system32 directory. 
	(Ex path. C:\WINDOWS\system32\ACR122JNI.dll )
* Copy ACR122 package in your Java  workspace. Access the package by importing it to your class.

I. Setting up Java Applet Sample Code in your PC.

Step 1. Check if your system has the latest Java Runtime Enviroment (JRE) installed (version 6). 
   (The java class included here were compiled using JDK1.6.0_04)

Step 2. Copy the ACR122JNI.dll and acr122.dll into your system32 directory. (Ex path. C:\WINDOWS\system32\ACR122JNI.dll )

Step 3: Run the html file (applet) on your default browser (Internet Explorer or Mozilla Firefox).


II. Setting up Java Applet in Host/Client PC.

A. Steps on setting up web server that will host the applet

Step 1: Enable (Internet Information Services) IIS on Windows XP Pro(May be slightly different in other server OS)

	1.1: Click Start -> Control Panel -> Add Remove Programs -> Add/Remove Components
	1.2: Make Sure Internet Information Services (IIS) is checked - Click Next -> Finish
	1.3 Restart your PC

	Note: You can use any Internet Server

Step 2: Copy Sample Codes folder & html file to IIS root folder e.g. C:\Inetpub\wwwroot

Step 3: Configure IIS
	3.1 Click Start -> Run -> Key-in "Compmgmt.msc" from the pop-up window and hit enter
	3.1 From the Computer Management Windows expand "Service and Application" -> Internet Information service ->  Web Sites -> Default Web Site -> Right Click on Sample Codes -> Properties -> On the Directory Tab click Create Button -> Apply -> Ok


B. Steps on setting up client PC

Step 1. Check if your system has the latest Java Runtime Enviroment installed version 6. 
   (The java class included here were compiled using JDK1.6.0_04)

Step 2. Copy the ACR122JNI.dll and acr122.dllinto your system32 directory. (Ex path. C:\WINDOWS\system32\ACR122JNI.dll )

Step 3: Run the applet
	3.1 Open your default internet explorer
	3.1 key-in http://[Web Server Name]/Default.htm e.g
		Note:The Web Server Name is the name of the Computer/PC where you setup the IIS.
		     To get the name of your computer Click Start -> Run -> Key-in "Cmd" -> from the command prompt key-in "hostname"
	3.3 Click the sample application you want to run.

