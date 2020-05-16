#!/bin/bash
clear 

BASEDIR=$(dirname "$0")

echo "Creating Vehicular Traffic Simulation using SUMO..."
echo -n "Enter the Number of vehicles by km2 : "
read CARS

export SUMO_HOME=/home/martin/Desktop/sumo-1.2.0
export OMNET=/home/martin/Desktop/Yachay/HASH_VAINS/veins-veins-5.0-Esbr/veins-veins-5.0/examples/veins
echo -n "Enter the Area of the ROI : "
read AREA

DENSITY=$((CARS*AREA))
cp map.osm erlangen.osm
#./netconvert --osm-files erlangen.osm -o erlangen.net.xml
./polyconvert --net-file erlangen.net.xml --osm-files erlangen.osm --type-file typemap.xml -o erlangen.poly.xml  


#python /opt/sumo-1.2.0/tools/randomTrips.py  -n erlangen.net.xml -r erlangen.rou.xml  -e $DENSITY -l  --intermediate 100 --trip-attributes "departLane=\"best\" departSpeed=\"max\" departPos=\"random\"" --additional-file type.add.xml --trip-attributes="type=\"hSlowCar\"" --additional-file type.add.xml

python $SUMO_HOME/tools/randomTrips.py  -n erlangen.net.xml -r erlangen.rou.xml  -e $DENSITY -l 

sed -i 's/depart=".*"/depart="0.00"'/g $BASEDIR/erlangen.rou.xml #replace departure time by 0.00
echo "Creating Vehicular Traffic Simulation using SUMO..."


read -p "Do you want to copy the files to the VEINS directory in Omnet++ ? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
	cp erlangen.rou.xml $OMNET/erlangen.rou.xml
	cp erlangen.net.xml $OMNET/erlangen.net.xml
	cp erlangen.poly.xml $OMNET/erlangen.poly.xml
	echo "Please, review the values of *.playgroundSize in Omnet.ini file according to the size of the new map"

else

	$SUMO_HOME/bin/sumo-gui erlangen.sumo.cfg
	exit 0
fi
