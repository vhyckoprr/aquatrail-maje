<?xml version="1.0" encoding="UTF-8"?>
<tileset name="player" tilewidth="45" tileheight="58">
 <image source="SpritesHero.png" width="405" height="522"/>
 <tile id="0">
  <properties>
   <property name="HasBody" value=""/>
   <property name="IsAnimated" value=""/>
   <property name="IsPlayer" value=""/>
   <property name="animDJumping" value="startFrame=6,frameCount=3,time=800"/>
   <property name="animEndLevel" value="startFrame=73,frameCount=6,time=1000,loopCount=1"/>
   <property name="animJumpingGaz" value="startFrame=22,frameCount=3,time=800"/>
   <property name="animJumpingLiq" value="startFrame=6,frameCount=3,time=800"/>
   <property name="animJumpingSol" value="startFrame=14,frameCount=3,time=800"/>
   <property name="animPluie" value="startFrame=25,frameCount=4,time=500,loopCount=1"/>
   <property name="animStartLevel" value="startFrame=64,frameCount=6,time=1000,loopCount=1"/>
   <property name="animTransitionGazLiq" value="startFrame=55,frameCount=6,time=500,loopCount=1"/>
   <property name="animTransitionLiqGaz" value="startFrame=46,frameCount=6,time=500,loopCount=1"/>
   <property name="animTransitionLiqSol" value="startFrame=29,frameCount=6,time=500,loopCount=1"/>
   <property name="animTransitionSolLiq" value="startFrame=37,frameCount=6,time=500,loopCount=1"/>
   <property name="animWalkingGaz" value="startFrame=19,frameCount=3,time=500"/>
   <property name="animWalkingLiq" value="frameCount=5,time=500"/>
   <property name="animWalkingSol" value="startFrame=10,frameCount=5,time=500"/>
   <property name="bounceGla" value="0"/>
   <property name="bounceLiq" value="0"/>
   <property name="densityGaz" value="0.5"/>
   <property name="densityGla" value="0.5"/>
   <property name="densityLiq" value="0.5"/>
   <property name="gazFly" value="4"/>
   <property name="gazSpeed" value="4"/>
   <property name="globalJump" value="0.4"/>
   <property name="globalSpeed" value="6"/>
   <property name="ignoreCulling" value="true"/>
   <property name="isFixedRotation" value="true"/>
   <property name="sequences" value="[&quot;animWalkingLiq&quot;,&quot;animWalkingSol&quot;,&quot;animWalkingGaz&quot;,&quot;animJumpingLiq&quot;,&quot;animJumpingSol&quot;,&quot;animJumpingGaz&quot;,&quot;animTransitionLiqSol&quot;,&quot;animTransitionSolLiq&quot;,&quot;animTransitionGazLiq&quot;,&quot;animTransitionSolGaz&quot;,&quot;animTransitionLiqGaz&quot;,&quot;animDJumping&quot;,&quot;animPluie&quot;,&quot;animStartLevel&quot;,&quot;animTransitionGazSol&quot;,&quot;animEndLevel&quot;]"/>
   <property name="zanimTransitionGazSol" value="startFrame=37,frameCount=5,time=5000,loopCount=1"/>
   <property name="zanimTransitionSolGaz" value="startFrame=29,frameCount=5,time=5000,loopCount=1"/>
  </properties>
 </tile>
</tileset>
