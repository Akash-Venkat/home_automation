#include <ESP8266WiFi.h>                                               
#include <FirebaseArduino.h>                                        
 
#define FIREBASE_HOST "relaycontrol-615e7.firebaseio.com"              // the project name address from firebase id
#define FIREBASE_AUTH "GJxZwRRuqFImcqpwUqRCZ5WuPwtKU6dXnuzzUYal"       // the secret key generated from firebase
#define WIFI_SSID "Akash_"                                          
#define WIFI_PASSWORD "0123456789"                                  
 
String fireStatus = "";                                                     // led status received from firebase
int led = 0;  
                                                              
void setup() 
{
  Serial.begin(9600);
  delay(1000);    
  pinMode(led, OUTPUT);                 
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);                               
  Serial.print("Connecting to ");
  Serial.print(WIFI_SSID);
  while (WiFi.status() != WL_CONNECTED) 
  {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("Connected to ");
  Serial.println(WIFI_SSID);
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);                  // connect to firebase
  //Firebase.setString("STATUS", "OFF");                       //send initial string of led status
}
 
void loop() 
{
  fireStatus = Firebase.getString("STATUS");                                      // get ld status input from firebase
  if (fireStatus == "OFF") 
  {                                                          // compare the input of led status received from firebase
    Serial.println("Led Turned ON");                                                        
    digitalWrite(led, HIGH);                                                         // make external led ON
  } 
  else if (fireStatus == "ON") 
  {                                                  // compare the input of led status received from firebase
    Serial.println("Led Turned OFF");
    digitalWrite(led, LOW);                                                         // make external led OFF
  }
  else 
  {
    Serial.println("Command Error! Please send ON/OFF");
  }
}
