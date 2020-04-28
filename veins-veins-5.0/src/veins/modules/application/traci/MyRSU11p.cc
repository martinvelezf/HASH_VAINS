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

#include "veins/modules/application/traci/MyRSU11p.h"

using namespace veins;

Define_Module(veins::MyRSU11p);

void MyRSU11p::initialize(int stage)
{
    DemoBaseApplLayer::initialize(stage);
    if (stage == 0) {
        // Initializing members and pointers of your application goes here
        EV << "Initializing " << par("appName").stringValue() << std::endl;
    }
    else if (stage == 1) {
        // Initializing members that require initialized other modules goes here
    }
    contador=0;
    WATCH(contador);
}

void MyRSU11p::finish()
{
    DemoBaseApplLayer::finish();
    // statistics recording goes here
}

void MyRSU11p::onBSM(DemoSafetyMessage* bsm)
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

void MyRSU11p::onWSM(BaseFrame1609_4* wsm)
{
    // Your application has received a data message from another car or RSU
    // code for handling the message goes here, see TraciDemo11p.cc for examples
}

void MyRSU11p::onWSA(DemoServiceAdvertisment* wsa)
{
    // Your application has received a service advertisement from another car or RSU
    // code for handling the message goes here, see TraciDemo11p.cc for examples
}

void MyRSU11p::handleSelfMsg(cMessage* msg)
{
    DemoBaseApplLayer::handleSelfMsg(msg);
    // this method is for self messages (mostly timers)
    // it is important to call the DemoBaseApplLayer function for BSM and WSM transmission
}

void MyRSU11p::handlePositionUpdate(cObject* obj)
{
    DemoBaseApplLayer::handlePositionUpdate(obj);
    // the vehicle has moved. Code that reacts to new positions goes here.
    // member variables such as currentPosition and currentSpeed are updated in the parent class
}
