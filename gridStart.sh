#!/bin/bash
nohup sh -c "java -jar selenium-server-standalone-3.141.59.jar -role hub" > hub.txt 2>&1 &
java -DDwebdriver.gecko.driver="$(pwd)/geckodriver" -DDwebdriver.chrome.driver="$(pwd)/chromedriver" -jar selenium-server-standalone-3.141.59.jar -role node -hub http://localhost:4444/grid/register -nodeConfig nodeconfig.json -port 5556
