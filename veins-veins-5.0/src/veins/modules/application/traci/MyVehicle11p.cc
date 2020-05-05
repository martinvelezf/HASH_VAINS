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

        rmMsg=par("rmMsg").boolValue();
        // configurable variables in omnetpp.ini
        indexOfAccidentNode = par("indexOfAccidentNode").intValue();
        counterThreshold = par("counterThreshold").intValue();
        arrivalSignal = registerSignal("arrival");

        beaconReceivedSignal = registerSignal("beaconReceivedSignal");
        warningReceivedSignal = registerSignal("warningReceivedSignal");
        contador=0;
        counterBeaconReceived=0;
        counterWarningReceived=0;
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
    cout<<"Llego un beacon \n";

    DemoSafetyMessage* wsmBeacon = check_and_cast<DemoSafetyMessage*>(bsm);

    // Your application has received a beacon message from another car or RSU
    // code for handling the message goes here
    counterBeaconReceived++;
    emit(beaconReceivedSignal, counterBeaconReceived);

    //std::cout<<counterBeaconReceived;
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

    size_t hash=wsm->getHash();
    wsm->setHash();
    size_t hash2=wsm->getHash();
    wsm->sethash(hash);
    std::cerr<<"Hash Recibido "<<hash<<" hash generado "<<hash2<<" texto "<<wsm->getText()<<"\n";
    // add the new message to storage
    contador++;
    emit(arrivalSignal, contador);

    counterWarningReceived++;
    emit(warningReceivedSignal, counterWarningReceived);




       if (mobility->getRoadId()[0] != ':') traciVehicle->changeRoute(wsm->getDemoData(), 9999);

       if (!sentMessage) {
           sentMessage = true;
           if (hash!=hash2){
                           findHost()->getDisplayString().setTagArg("i", 1, "yellow");
                           FakeMsg++;

                           if(rmMsg){
                               cout<<FakeMsg<<" myid "<< myId<<"\n";
                               stopService();
                               //delete (wsm);
                           }
                           else{
                               wsm->setSenderAddress(myId);
                               wsm->setSerial(3);
                              //   EV << ">>>>>>>>>>RECIBI WSM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< "<< receivedMessages.size() <<std::endl;
                               scheduleAt(simTime() + 2 + uniform(0.01, 0.2), wsm->dup());

                           }
                   }
           else{
               findHost()->getDisplayString().setTagArg("i", 1, "blue");
           }

           // repeat the received traffic update once in 2 seconds plus some random delay



    }


}


void MyVehicle11p::onWSA(DemoServiceAdvertisment* wsa)
{
    cout<<"Llego un onWSA \n";
    // Your application has received a service advertisement from another car or RSU
    // code for handling the message goes here, see TraciDemo11p.cc for examples
}

void MyVehicle11p::handleSelfMsg(cMessage* msg)
{
    //DemoBaseApplLayer::handleSelfMsg(msg);
    // this method is for self messages (mostly timers)
    // it is important to call the DemoBaseApplLayer function for BSM and WSM transmission

    if (TraCIDemo11pMessage* wsm = dynamic_cast<TraCIDemo11pMessage*>(msg)) {
           // send this message on the service channel until the counter is 3 or higher.
           // this code only runs when channel switching is enabled
            //std::cout<<"envia txt: "<<wsm->getText()<<"Hash: "<<wsm->getHash()<<" id: "<<myId<<"\n\n";

            //get hash and compare hash
            size_t hash=wsm->getHash();
            wsm->setHash();
            size_t hash2=wsm->getHash();
            wsm->sethash(hash);
            ///////////////////////////
            if (hash!=hash2){
                FakeMsg++;
                findHost()->getDisplayString().setTagArg("i", 1, "yellow");
                stopService();
                delete (wsm);
            }
            else{
                RealMsg++;
            }


            if(!rmMsg){
               //std::cout<<"envia txt: "<<wsm->getText()<<"Hash: "<<wsm->getHash()<<" id: "<<myId<<"\n";
               sendDown(wsm->dup());
               wsm->setSerial(wsm->getSerial() + 1);
               findHost()->getDisplayString().setTagArg("i", 1, "green");
               if (wsm->getSerial() >= 3) {
                   //stop service advertisements
                  stopService();
                  delete (wsm);
               }
               else {
                   scheduleAt(simTime() + 1, wsm);
               }
            }
       }
       else {
           DemoBaseApplLayer::handleSelfMsg(msg);
       }

       // if the number of times a warning message is received exceeds the counterThreshold
       // configuration variable, do not rebroadcast.

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
            wsm->setHash();

            std::cerr<<"Envia Hash "<<wsm->getHash()<<" texto "<<wsm->getText() <<" carro "<<myId<<"\n";
            // host is standing still due to crash
            // send right away on CCH, because channel switching is disabled
            sendDown(wsm);

        }
    }
    else {
        lastDroveAt = simTime();
    }


}
