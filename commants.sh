From Documentation:
docker run --detach \
--publish 9000:8000 --publish 9001:8001 \
--publish 9005:8005 --publish 9006:8006 \
--publish 9009:8009 --publish 9010:8010 \
--publish 9443:8443 --publish 9021:8021 \
--publish 9022:8022 --publish 32001-32300:32001-32300 \
--volume userdata:/opt/HelpSystems/GoAnywhere/userdata/ \
--volume configdir:/etc/HelpSystems/GoAnywhere/config/ \
--volume tomcatserver:/etc/HelpSystems/GoAnywhere/tomcat/conf/server.xml \
--volume tomcatlogsdir:/opt/HelpSystems/GoAnywhere/tomcat/logs/ \
--volume ghttpsrootcustomdir:/opt/HelpSystems/GoAnywhere/ghttpsroot/custom/ \
helpsystems/goanywhere-mft:latest

From Docker HUB:
docker run --detach \
--publish 9000:8000 --publish 9001:8001 --publish 9005:8005 \
--publish 9006:8006 --publish 9009:8009  --publish 9010:8010 \
--publish 9443:443 --publish 9021:21 --publish 9022:22 \
--publish 32001-32300:32001-32300 \
-v userdata:/usr/local/HelpSystems/GoAnywhere/userdata/ \
-v configdir:/usr/local/HelpSystems/GoAnywhere/config/ \
helpsystems/goanywhere-mft:latest

docker run --detach \
--publish 9443:443 --publish 9021:21 --publish 9022:22 \
-v userdata:/usr/local/HelpSystems/GoAnywhere/userdata/ \
-v configdir:/usr/local/HelpSystems/GoAnywhere/config/ \
helpsystems/goanywhere-mft:latest