
#include "veins/modules/application/ieee80211p/DemoBaseApplLayer.h"
#include "veins/modules/mobility/traci/TraCIMobility.h"
#include "veins/modules/mobility/traci/TraCICommandInterface.h"
#include <cstdlib>
#include <iostream>
#include <vector>
#include "veins/modules/application/traci/beacon.h"
#include <iomanip>
#include <string>

using namespace std;

BeaconList::BeaconList(){
    head=NULL;
    curr=NULL;
    temp=NULL;
}


void BeaconList::AddBeacon(int b_idMsg, simtime_t b_time, simtime_t b_timeRx, int b_idVehicle,double b_s, double b_pX, double b_pY, double b_pZ,
            double b_disJunction, double b_disToSource,simtime_t b_idleTime, double b_abe, double b_angle){
    beaconPtr n = new beacon;
    string txt;
    txt=to_string(b_idMsg)+to_string(b_idVehicle)+to_string(b_s) +to_string(b_pX)+to_string(b_pY)+to_string(b_pZ)+to_string(b_disJunction)+to_string(b_disToSource)+to_string(b_abe)+to_string(b_angle);
    n->source_hash=hash<string>{}(txt);
    n->next =NULL;
    n->idMsg=b_idMsg;
    n->time=b_time;
    n->timeRx=b_timeRx;
    n->idVehicle=b_idVehicle;
    n->s=b_s;
    n->pX=b_pX;
    n->pY=b_pY;
    n->pZ=b_pZ;
    n->disJunction=b_disJunction;
    n->disToSource=b_disToSource,
    n->idleTime=b_idleTime;
    n->abe=b_abe;
    n->angle=b_angle;
    n->hash=n->source_hash;


    if(head != NULL){
        curr = head;
        while(curr->next != NULL){
            curr = curr->next;

        }
        curr->next=n;
    }
    else{
        head=n;
    }
}

void BeaconList::DeleteBeacon(int delb_idVehicle){
    beaconPtr delPtr = NULL;
    temp = head;
    curr = head;
    while(curr !=NULL && curr->idVehicle != delb_idVehicle){
        temp = curr;
        curr = curr->next;
    }
    if(curr == NULL){
        EV << delb_idVehicle << " was not in the beacon List" <<std::endl;
        delete delPtr;
    }
    else{
        delPtr = curr;
        curr = curr->next;
        temp->next = curr;
        if(delPtr==head){
            head= head->next;
            temp = NULL;
        }


        delete delPtr;
        EV << delb_idVehicle << " This beacon was deleted" <<std::endl;
    }

}

void BeaconList::PrintBeacons(){
    curr = head;
    EV<<"----------------------------------------------------------------------------------------------------------------------------------------------"<<endl;
    EV<<setw(40)<<"Neighbor Table"<<endl;
    EV<<"----------------------------------------------------------------------------------------------------------------------------------------------"<<endl;
    EV<<"Original Hash"<<setw(20)<<"ArrivalTime"<<setw(20)<<"Id_Vehicle"<<setw(15)<<"Speed"<<setw(15)<<"CoordX"<<setw(15)<<"CoordY"<<setw(15)<<"Distance"<<setw(25)<<"idleTime"<<setw(25)<<"abe"<<setw(25)<<"disNextJunction"<<setw(25)<<"angleRad"<<setw(25)<<"Hash"<<endl;
    while(curr != NULL)
    {
        EV<<curr->source_hash<<setw(5)<<curr->time<<setw(15)<<curr->idVehicle<<setw(15)<<curr->s<<setw(15)<<curr->pX<<setw(15)<<curr->pY<<setw(15)<<curr->disToSource<<setw(25)<<curr->idleTime<<setw(25)<<curr->abe<<setw(25)<<curr->disJunction<<setw(25)<<curr->angle<<setw(25)<<curr->hash<<endl;
        curr = curr->next;

    }
    EV<<"----------------------------------------------------------------------------------------------------------------------------------------------"<<endl;
    //EV<<curr->hash;
}


int BeaconList::CounterBeacons(){
    curr = head;
    int counter =0;

    while(curr != NULL)
    {
        curr = curr->next;
        counter++;


    }
    return counter;
}

bool BeaconList::SearchBeacon(int delb_idVehicle){
    bool foundBeacon;
    beaconPtr delPtr = NULL;
    temp = head;
    curr = head;
    while(curr !=NULL && curr->idVehicle != delb_idVehicle){
        temp = curr;
        curr = curr->next;
    }
    if(curr == NULL){
        EV << delb_idVehicle << " was not in the beacon List" <<std::endl;
        foundBeacon = false;
    }
    else{
        EV << delb_idVehicle << " This beacon was found!!" <<std::endl;
        foundBeacon = true;
    }
    delete delPtr;
    return foundBeacon;

}


void BeaconList::UpdateBeacon(int b_idMsg, simtime_t b_time, simtime_t b_timeRx,int b_idVehicle,double b_s, double b_pX, double b_pY, double b_pZ,
            double b_disJunction, double b_disToSource, simtime_t b_idleTime, double b_abe, double b_angle){
    beaconPtr n = new beacon;
    n =head;
    string txt;

    while(n != NULL)
    {
        txt=to_string(b_idMsg)+to_string(b_idVehicle)+to_string(b_s) +to_string(b_pX)+to_string(b_pY)+to_string(b_pZ)+to_string(b_disJunction)+to_string(b_disToSource)+to_string(b_abe)+to_string(b_angle);
        if(n->idVehicle == b_idVehicle)
        {
            n->idMsg=b_idMsg;
            n->time=b_time;
            n->timeRx=b_timeRx;
            n->idVehicle=b_idVehicle;
            n->s=b_s;
            n->pX=b_pX;
            n->pY=b_pY;
            n->pZ=b_pZ;
            n->disJunction=b_disJunction;
            n->disToSource=b_disToSource,
            n->idleTime= b_idleTime;
            n->abe=b_abe;
            n->angle=b_angle;
            n->hash=hash<string>{}(txt);
            return;
        }
        else
            n = n->next;

    }

}



void BeaconList::SortBeacons(){
    bool changeMade;
    do{
        changeMade = false;
        curr = head;
        while( curr != NULL ){
            temp = curr;
            curr = curr->next;

            if( curr && curr->disToSource < temp->disToSource ){
                changeMade = true;
                swap( temp->time, curr->time );
                swap( temp->idVehicle, curr->idVehicle);
                swap( temp->s, curr->s);
                swap( temp->pX, curr->pX);
                swap( temp->pY, curr->pY);
                swap( temp->disToSource, curr->disToSource);
                swap( temp->idleTime, curr->idleTime);
                swap( temp->abe, curr->abe);
                swap( temp->angle, curr->angle);
            }
        }
    } while( changeMade );
}



int BeaconList::PurgeBeacons(double b_ttl){

    curr =head;
    double counter=0;
    double ttl=simTime().dbl();
    while(curr != NULL && curr->next !=NULL)
       {
           if(curr->next->time < ttl-b_ttl)
           {
              temp = curr->next;
              curr->next= temp->next;
              free(temp);
              counter++;
           }
           else
               curr= curr->next;

       }

      EV  << " This beacon list was purged. "<<counter<<" has been deleted" <<std::endl;
      return counter;

}



