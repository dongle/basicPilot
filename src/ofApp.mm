#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
	ofBackground(0, 0, 0);
	this->thrust = ofPoint(0,0);
	this->angle = 0;
	this->currentPosition = ofPoint(ofGetWindowWidth()/2, ofGetWindowHeight()/2);
}

//--------------------------------------------------------------
void ofApp::update(){
	// Update position
	this->thrust *= .99f;
	this->currentPosition += this->thrust;

	// Boundary wraps
	if (this->currentPosition.x > ofGetScreenWidth()) {
		this->currentPosition.x = 0;
	} else if (currentPosition.x < 0) {
		this->currentPosition.x = ofGetScreenWidth();
	}
	if (this->currentPosition.y > ofGetScreenHeight()) {
		this->currentPosition.y = 0;
	} else if (currentPosition.y < 0) {
		this->currentPosition.y = ofGetScreenHeight();
	}

	if (this->pointList.size() > 50 || this->thrust.length() < 0.3) {
		if (this->pointList.size() > 0) {
			this->pointList.pop_front();
		}
	}

	if (this->thrust.length() > 0.2) {
		this->pointList.push_back(ofPoint(this->currentPosition.x - (5 * sin(this->angle)), this->currentPosition.y + (5 * cos(this->angle))));
	}
}

//--------------------------------------------------------------
void ofApp::draw(){
	ofPushMatrix();

	ofTranslate(this->currentPosition.x, this->currentPosition.y);
	ofRotate(ofRadToDeg(this->angle));
	ofSetColor(0, 50, 200);
	ofDrawTriangle(-10, 0, 0, -30, 10, 0);

	ofPopMatrix();

	ofSetColor(255, 255, 255);
	for (int i = 0; i < this->pointList.size(); ++i) {
		ofDrawCircle(this->pointList[i].x, this->pointList[i].y, i/12.0f);
	}
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
	this->lastTouch = ofPoint(touch.x, touch.y);
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
	// Find touch vector
	ofPoint currentTouch = ofPoint(touch.x,	touch.y);
	this->thrust += 0.16f * (currentTouch -	this->lastTouch);

	// Update angle
	this->angle = atan2(this->thrust.y, this->thrust.x) + M_PI_2;

	this->lastTouch = currentTouch;
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}
