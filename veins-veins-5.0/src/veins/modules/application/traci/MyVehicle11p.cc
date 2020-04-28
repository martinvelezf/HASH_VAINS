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

#include "veins/modules/application/traci/MyVehicle11p.h"




using namespace veins;

Define_Module(veins::MyVehicle11p);

void MyVehicle11p::initialize(int stage)
{
    DemoBaseApplLayer::initialize(stage);
    if (stage == 0) {
        // Initializing members and pointers of your application goes here
        EV << "Initializing " << par("appName").stringValue() << std::endl;

        sentMessage = false;
        lastDroveAt = simTime();



        currentSubscribedServiceId = -1;

        // configurable variables in omnetpp.ini
        indexOfAccidentNode = par("indexOfAccidentNode").intValue();
        counterThreshold = par("counterThreshold").intValue();
        arrivalSignal = registerSignal("arrival");
        contador=0;
        WATCH(contador);


    }
    else if (stage == 1) {
        // Initializing members that require initialized other modules goes here
    }

}

void MyVehicle11p::finish()
{
    DemoBaseApplLayer::finish();
    // statistics recording goes here
}

void MyVehicle11p::onBSM(DemoSafetyMessage* bsm)
{

    DemoSafetyMessage* wsmBeacon = check_and_cast<DemoSafetyMessage*>(bsm);

    // Your application has received a beacon message from another car or RSU
    // code for handling the message goes here


     int b=int(wsmBeacon->getPsid());
        double dsr=wsmBeacon->getSenderPos().distance(curPosition);


        if (ListBeacon.SearchBeacon(b)){
                ListBeacon.UpdateBeacon(wsmBeacon->getPsid(),wsmBeacon->getArrivalTime(), wsmBeacon->getCreationTime(), wsmBeacon->getPsid(),sqrt(wsmBeacon->getSenderSpeed().squareLength()), wsmBeacon->getSenderPos().x,
                        wsmBeacon->getSenderPos().y, wsmBeacon->getSenderPos().z, 0,wsmBeacon->getSenderPos().distance(curPosition), 0,0, 0);

        }

        else{
                ListBeacon.AddBeacon(wsmBeacon->getPsid(),wsmBeacon->getArrivalTime(), wsmBeacon->getCreationTime(), wsmBeacon->getPsid(),sqrt(wsmBeacon->getSenderSpeed().squareLength()), wsmBeacon->getSenderPos().x,
                        wsmBeacon->getSenderPos().y, wsmBeacon->getSenderPos().z, 0,wsmBeacon->getSenderPos().distance(curPosition), 0,0, 0);
        }

        EV << ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Neighbors Table<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< "<<std::endl;
        double ttl=5;
        contador=ListBeacon.PurgeBeacons(ttl);
        ListBeacon.SortBeacons();
        ListBeacon.PrintBeacons();



}

void MyVehicle11p::onWSM(BaseFrame1609_4* frame)
{
    // Your application has received a data message from another car or RSU
    // code for handling the message goes here, see TraciDemo11p.cc for examples

    TraCIDemo11pMessage* wsm = check_and_cast<TraCIDemo11pMessage*>(frame);

    // add the new message to storage
    contador++;
    emit(arrivalSignal, contador);

       findHost()->getDisplayString().setTagArg("i", 1, "blue");

       if (mobility->getRoadId()[0] != ':') traciVehicle->changeRoute(wsm->getDemoData(), 9999);
       if (!sentMessage) {
           sentMessage = true;
           // repeat the received traffic update once in 2 seconds plus some random delay
           wsm->setSenderAddress(myId);
           wsm->setSerial(3);

        //   EV << ">>>>>>>>>>RECIBI WSM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< "<< receivedMessages.size() <<std::endl;
          scheduleAt(simTime() + 2 + uniform(0.01, 0.2), wsm->dup());

       }


}

void MyVehicle11p::onWSA(DemoServiceAdvertisment* wsa)
{
    // Your application has received a service advertisement from another car or RSU
    // code for handling the message goes here, see TraciDemo11p.cc for examples
}

void MyVehicle11p::handleSelfMsg(cMessage* msg)
{
    //DemoBaseApplLayer::handleSelfMsg(msg);
    // this method is for self messages (mostly timers)
    // it is important to call the DemoBaseApplLayer function for BSM and WSM transmission

    if (TraCIDemo11pMessage* wsm = dynamic_cast<TraCIDemo11pMessage*>(msg)) {



        // if the number of times a warning message is received exceeds the counterThreshold
        // configuration variable, do not rebroadcast.

          if (contador <= (uint)counterThreshold) {
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

void MyVehicle11p::handlePositionUpdate(cObject* obj)
{
    DemoBaseApplLayer::handlePositionUpdate(obj);
    // the vehicle has moved. Code that reacts to new positions goes here.
    // member variables such as currentPosition and currentSpeed are updated in the parent class

    // stopped for for at least 10s?
    if (mobility->getSpeed() < 1) {
        if (simTime() - lastDroveAt >= 10 && sentMessage == false && indexOfAccidentNode == getParentModule()->getIndex()) {
            findHost()->getDisplayString().setTagArg("i", 1, "red");
            sentMessage = true;

            std::cerr << "[INFO] ACCIDENT STARTED @simTime: " << simTime() << " for node: " << getParentModule()->getIndex() << endl;

            TraCIDemo11pMessage* wsm = new TraCIDemo11pMessage();
            populateWSM(wsm);
            wsm->setDemoData(mobility->getRoadId().c_str());

            // host is standing still due to crash
            // send right away on CCH, because channel switching is disabled
                sendDown(wsm);

        }
    }
    else {
        lastDroveAt = simTime();
    }


}
