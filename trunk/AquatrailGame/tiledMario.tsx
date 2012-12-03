<?xml version="1.0" encoding="UTF-8"?>
<tileset name="player" tilewidth="20" tileheight="30">
 <image source="Tutorials/11. AnimatedCharacters/player.png" width="100" height="30"/>
 <tile id="0">
  <properties>
   <property name="HasBody" value=""/>
   <property name="IsAnimated" value=""/>
   <property name="IsPlayer" value=""/>
   <property name="animIdle" value="startFrame=3,frameCount=2,time=5000"/>
   <property name="animJumping" value="startFrame=5,frameCount=1,time=5000"/>
   <property name="animWalking" value="frameCount=2,time=500"/>
   <property name="bounce" value="0.2"/>
   <property name="density" value="1.0"/>
   <property name="friction" value="0.3"/>
   <property name="isFixedRotation" value="true"/>
   <property name="sequences" value="animIdle,animWalking,animJumping"/>
  </properties>
 </tile>
</tileset>
