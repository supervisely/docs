# Troubleshoot Archives
Supervisely troubleshoot archive is an important platform service tool, useful for maintenancee and problem-solving.

## Generating a Troubleshoot Archive

There are 2  ways to generate the troubleshoot archive, from the interface and from the server terminal.

### Using the Supervisely Interface

To generate the troubleshoot archive from the platform interface, you need to be logged as the 'admin' user. Open the user menu and select 'Troubleshoot Archive'. 

![generate tsa](https://user-images.githubusercontent.com/48245050/228557293-69f40688-8067-4c32-97c0-75573682dc99.png)

Once the archive is ready, it will be downloaded automatically. Please don't log out or close the window until the download has started. 

### Using the Supervisely Server Terminal

To generate the archive by using the terminal run the following command:

```sudo supervisely troubleshoot```

The system will generate the archive and it MAGIC HAPPENS.


## Troubleshoot Archive Contents

The archives are in .tar.gz format and they are named in a 'supervisely_troubleshoot_year_mm_dd_h_m_s' scheme.
Each archive contains the logs for all running components of the platform in .log format, as well as the information about the platform version, docker, server, etc. stored in .txt format. All of the files inside the archive (both .log and .txt) are in plain text, so that you can easily review them.

![tsa](https://user-images.githubusercontent.com/48245050/228561271-13ddfb37-8f59-44fa-8eb3-eaa6806ee2d2.png)
