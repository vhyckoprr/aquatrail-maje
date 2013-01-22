<?xml version="1.0" encoding="UTF-8"?>
<tileset name="player" tilewidth="50" tileheight="64">
 <image source="SpritesHero.png" width="450" height="320"/>
 <tile id="0">
  <properties>
   <property name="HasBody" value=""/>
   <property name="IsAnimated" value=""/>
   <property name="IsPlayer" value=""/>
   <property name="animDJumping" value="startFrame=6,frameCount=3,time=800"/>
   <property name="animJumpingLiq" value="startFrame=6,frameCount=3,time=800"/>
   <property name="animJumpingSol" value="startFrame=14,frameCount=3,time=800"/>
   <property name="animTransition" value="startFrame=29,frameCount=3,time=500,loopCount=1"/>
   <property name="animWalkingLiq" value="frameCount=4,time=500"/>
   <property name="animWalkingSol" value="startFrame=10,frameCount=4,time=500"/>
   <property name="bounceGla" value="0"/>
   <property name="bounceLiq" value="0"/>
   <property name="densityGla" value="0.5"/>
   <property name="densityLiq" value="0.5"/>
   <property name="globalJump" value="0.4"/>
   <property name="globalSpeed" value="6"/>
   <property name="isFixedRotation" value="true"/>
   <property name="sequences" value="[&quot;animWalkingLiq&quot;,&quot;animWalkingSol&quot;,&quot;animJumpingLiq&quot;,&quot;animJumpingSol&quot;,&quot;animTransition&quot;,&quot;animDJumping&quot;]"/>
  </properties>
 </tile>
</tileset>
