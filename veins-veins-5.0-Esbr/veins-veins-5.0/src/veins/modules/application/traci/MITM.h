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

#pragma once

#include "veins/veins.h"
#include <map>
#include <vector>

#include "veins/modules/application/ieee80211p/DemoBaseApplLayer.h"
#include "veins/modules/application/traci/beacon.h"
#include "veins/modules/application/traci/TraCIDemo11pMessage_m.h"

using namespace omnetpp;




namespace veins {
#define SCHEDULED_REBROADCAST
typedef std::vector<TraCIDemo11pMessage*> TraCIDemo11pMessages;



/**
 * @brief
 * This is a stub for a typical Veins application layer.
 * Most common functions are overloaded.
 * See MyVeinsApp.cc for hints
 *
 * @author David Eckhoff
 *
 */

class VEINS_API MITM : public DemoBaseApplLayer {
public:
    void initialize(int stage) override;
    void finish() override;

protected:
    int contador;
    int counterBeaconReceived;
    int counterWarningReceived;
    BeaconList ListBeacon;

    simtime_t lastDroveAt;
    bool sentMessage;
    long indexOfAccidentNode;

    int currentSubscribedServiceId;
    long counterThreshold;
    simsignal_t arrivalSignal;
    simsignal_t beaconReceivedSignal;
    simsignal_t warningReceivedSignal;

    map<long,TraCIDemo11pMessages> receivedMessages;    // treeId, onWSM vector


protected:
    void onBSM(DemoSafetyMessage* bsm) override;
    void onWSM(BaseFrame1609_4* wsm) override;
    void onWSA(DemoServiceAdvertisment* wsa) override;

    void handleSelfMsg(cMessage* msg) override;
    void handlePositionUpdate(cObject* obj) override;
};

} // namespace veins
