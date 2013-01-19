<?xml version="1.0" encoding="UTF-8"?>
<tileset name="tileset-platformer" tilewidth="32" tileheight="32">
 <image source="tileset-platformer.png" width="192" height="544"/>
 <tile id="53">
  <properties>
   <property name="IsGround" value=""/>
   <property name="bodyType" value="static"/>
  </properties>
 </tile>
 <tile id="57">
  <properties>
   <property name="IsAnimated" value=""/>
   <property name="IsCollectable" value=""/>
   <property name="Name" value="Gouttelette"/>
   <property name="Nom" value="1"/>
   <property name="Score" value="100"/>
   <property name="animation1" value="frameCount=3,time=1000"/>
   <property name="bodyType" value="static"/>
   <property name="sequences" value="animation1"/>
  </properties>
 </tile>
 <tile id="58">
  <properties>
   <property name="HasBody" value=""/>
   <property name="IsAnimated" value=""/>
   <property name="IsCollectable" value=""/>
   <property name="Name" value="SuperGouttelette"/>
   <property name="Nom" value="2"/>
   <property name="Score" value="200"/>
   <property name="animation1" value="frameCount=1,time=2000"/>
   <property name="bodyType" value="static"/>
   <property name="isSensor" value="true"/>
   <property name="sequences" value="animation1"/>
  </properties>
 </tile>
 <tile id="62">
  <properties>
   <property name="HasBody" value=""/>
   <property name="IsPickup" value=""/>
   <property name="bodyType" value="static"/>
   <property name="isSensor" value="true"/>
   <property name="pickupType" value="score"/>
   <property name="scoreValue" value="10"/>
  </properties>
 </tile>
 <tile id="64">
  <properties>
   <property name="HasBody" value=""/>
   <property name="IsAnimated" value=""/>
   <property name="IsCollectable" value=""/>
   <property name="Name" value="Esprit"/>
   <property name="Nom" value="3"/>
   <property name="Score" value="1000"/>
   <property name="animation1" value="frameCount=1,time=2000"/>
   <property name="bodyType" value="static"/>
   <property name="isSensor" value="true"/>
   <property name="sequences" value="animation1"/>
  </properties>
 </tile>
 <tile id="71">
  <properties>
   <property name="IsGround" value=""/>
   <property name="bodyType" value="static"/>
  </properties>
 </tile>
 <tile id="83">
  <properties>
   <property name="HasBody" value=""/>
   <property name="IsFrozen" value=""/>
   <property name="IsGround" value=""/>
   <property name="bodyType" value="static"/>
   <property name="bonusJumpLiq" value="0,5"/>
   <property name="bonusJumpSol" value="1"/>
   <property name="bonusSpeedLiq" value="1"/>
   <property name="bonusSpeedSol" value="2"/>
  </properties>
 </tile>
 <tile id="85">
  <properties>
   <property name="HasBody" value=""/>
   <property name="IsDestructible" value=""/>
   <property name="bodyType" value="static"/>
  </properties>
 </tile>
 <tile id="86">
  <properties>
   <property name="IsDestructible" value=""/>
   <property name="IsStalactite" value=""/>
  </properties>
 </tile>
 <tile id="87">
  <properties>
   <property name="IsGround" value=""/>
   <property name="bodyType" value="static"/>
  </properties>
 </tile>
</tileset>
