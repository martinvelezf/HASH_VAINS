//
// Copyright (C) 2016 David Eckhoff <david.eckhoff@fau.de>
//
// Documentation for these modules is at http://veins.car2x.org/
//
// SPDX-License-Identifier: GPL-2.0-or-later
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//

#include "veins/modules/application/traci/Esbr.h"




using namespace veins;

Define_Module(veins::Esbr);

void Esbr::initialize(int stage)
{
    DemoBaseApplLayer::initialize(stage);
    if (stage == 0) {
        // Initializing members and pointers of your application goes here
        EV << "Initializing " << par("appName").stringValue() << std::endl;

        sentMessage = false;
        lastDroveAt = simTime();



        currentSubscribedServiceId = -1;

        // configuration variables found in omnetpp.ini
        senderReceiverDistanceThreshold = par("senderReceiverDistanceThreshold").doubleValue();
        sendWarningInterval = par("sendWarningInterval").doubleValue();
        hostToJunctionDistanceThreshold = par("hostToJunctionDistanceThreshold").doubleValue();
        neighborLifetimeThreshold = par("neighborLifetimeThreshold").doubleValue();


        indexOfAccidentNode = par("indexOfAccidentNode").intValue();
        counterThreshold = par("counterThreshold").intValue();
        arrivalSignal = registerSignal("arrival");

        beaconReceivedSignal = registerSignal("beaconReceivedSignal");
        warningReceivedSignal = registerSignal("warningReceivedSignal");
        contador=0;
        counterBeaconReceived=0;
        counterWarningReceived=0;
        WATCH(contador);
        hostIsInWarningMode = false;

    }
    else if (stage == 1) {
        // Initializing members that require initialized other modules goes here
       // junctionIds = traci->getCommandInterface()->getJunctionIds();

        junctionIds = mobility->getCommandInterface()->getJunctionIds();

                for (list<string>::iterator i = junctionIds.begin(); i != junctionIds.end(); ++i) {
                    string jId = *i;
                    Coord jPos = mobility->getCommandInterface()->junction(jId).getPosition();
                    junctionMap[jId] = jPos;
                }

    }
}


void Esbr::finish()
{
    DemoBaseApplLayer::finish();
    // statistics recording goes here
}

void Esbr::onBSM(DemoSafetyMessage* bsm)
{

    DemoSafetyMessage* wsmBeacon = check_and_cast<DemoSafetyMessage*>(bsm);

    // Your application has received a beacon message from another car or RSU
    // code for handling the message goes here
    counterBeaconReceived++;
    emit(beaconReceivedSignal, counterBeaconReceived);

    // if host is in warning mode no need for beacons
       if (hostIsInWarningMode)
           return;

        bool isNewNeighbor=true;


       // is this a new neighbor?
       for (uint i = 0; i < neighbors.size(); ++i) {
           DemoSafetyMessage* neighbor = neighbors[i];
           if (neighbor->getTreeId() == wsmBeacon->getTreeId()) {
               isNewNeighbor = false;
           }
       }

       // if it is a new neighbor, add it's message to the list of neighbors.
       if (isNewNeighbor) {
           neighbors.push_back(wsmBeacon->dup());
       }

       // remove neighbors that have exceeded the neighborLifetimeThreshold found in omnetpp.ini
       vector<int> indices;
       for (uint i = 0; i < neighbors.size(); ++i) {
           DemoSafetyMessage* neighbor = neighbors[i];
           if (simTime() > neighbor->getArrivalTime() + neighborLifetimeThreshold)
               indices.push_back(i);
       }

       vector<DemoSafetyMessage*> newNeighbors;
       for (uint i = 0; i < indices.size(); ++i) {
           newNeighbors.push_back(neighbors[i]->dup());
       }
       neighbors = newNeighbors;
       // end removing neighbors

}

void Esbr::onWSM(BaseFrame1609_4* frame)
{
    // Your application has received a data message from another car or RSU
    // code for handling the message goes here, see TraciDemo11p.cc for examples

    TraCIDemo11pMessage* wsm = check_and_cast<TraCIDemo11pMessage*>(frame);

    // add the new message to storage
    contador++;
    emit(arrivalSignal, contador);

    counterWarningReceived++;
    emit(warningReceivedSignal, counterWarningReceived);

       findHost()->getDisplayString().setTagArg("i", 1, "blue");

       if (mobility->getRoadId()[0] != ':') traciVehicle->changeRoute(wsm->getDemoData(), 9999);


       // prevent originating disseminator from participating in further dissemination attempts
           if (sentMessage)
               return;

           // add message to receivedMessageMap for this warnings index
           receivedMessageMap[wsm->getTreeId()].push_back(wsm->dup());

           // is this the first time the warning was received?
           bool isNewWarningMessage = false;

           if (receivedMessageMap[wsm->getTreeId()].size() == 1) {
               isNewWarningMessage = true;
               // record statistics
           }

           // rebroadcast only under conditions:
           if (isNewWarningMessage) {
               if ((wsm->getSenderPos().distance(curPosition) > senderReceiverDistanceThreshold)
                               || (mobility->getRoadId() != wsm->getDemoData())
                               || ((mobility->getRoadId() == wsm->getDemoData()) && hostIsInJunction())) {
                   scheduleAt(simTime() + 2 + uniform(0.01, 0.2), wsm->dup());
               }
           }


}



bool Esbr::hostIsInJunction()
{
    bool onJunction=false;
    // check to see if this host is near an intersection

    for (map<string,Coord>::iterator i = junctionMap.begin(); i != junctionMap.end(); ++i) {
        string jId = i->first;
        Coord jPos = i->second;
        Coord hPos = mobility->getPositionAt(simTime());
        if (jPos.distance(hPos) < 4) {
            onJunction=true;
            return onJunction;
        }
    }

    return onJunction;
}


void Esbr::onWSA(DemoServiceAdvertisment* wsa)
{
    // Your application has received a service advertisement from another car or RSU
    // code for handling the message goes here, see TraciDemo11p.cc for examples
}

void Esbr::handleSelfMsg(cMessage* msg)
{
    //DemoBaseApplLayer::handleSelfMsg(msg);
    // this method is for self messages (mostly timers)
    // it is important to call the DemoBaseApplLayer function for BSM and WSM transmission

    if (TraCIDemo11pMessage* wsm = dynamic_cast<TraCIDemo11pMessage*>(msg)) {



        // if the number of times a warning message is received exceeds the counterThreshold
        // configuration variable, do not rebroadcast.

        if ((wsm->getSenderPos().distance(curPosition) > senderReceiverDistanceThreshold)
                                      || (mobility->getRoadId() != wsm->getDemoData())
                                      || ((mobility->getRoadId() == wsm->getDemoData()) && hostIsInJunction())){
              findHost()->getDisplayString().setTagArg("i", 1, "green");
              sendDown(wsm->dup());
            //  scheduleAt(simTime() + 1, wsm);
          }
          else{
              // stop service advertisements
                           stopService();
                           delete (wsm);
          }

      }
      else {
          DemoBaseApplLayer::handleSelfMsg(msg);
      }




}

void Esbr::handlePositionUpdate(cObject* obj)
{
    DemoBaseApplLayer::handlePositionUpdate(obj);
    // the vehicle has moved. Code that reacts to new positions goes here.
    // member variables such as currentPosition and currentSpeed are updated in the parent class

    // stopped for for at least 10s?
    if (mobility->getSpeed() < 1) {
        if (simTime() - lastDroveAt >= 10 && !sentMessage  && indexOfAccidentNode == getParentModule()->getIndex()) {
            findHost()->getDisplayString().setTagArg("i", 1, "red");
            sentMessage = true;

            std::cerr << "[INFO] ACCIDENT STARTED @simTime: " << simTime() << " for node: " << getParentModule()->getIndex() << endl;

            TraCIDemo11pMessage* wsm = new TraCIDemo11pMessage();
            populateWSM(wsm);
            wsm->setDemoData(mobility->getRoadId().c_str());
            wsm->setSenderPos(curPosition);
            wsm->setSenderSpeed(curSpeed);

            // host is standing still due to crash
            // send right away on CCH, because channel switching is disabled
                sendDown(wsm);

        }
    }
    else {
        lastDroveAt = simTime();
    }


}
