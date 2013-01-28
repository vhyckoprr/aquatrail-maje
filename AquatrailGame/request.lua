require ("ScoreScreen")	------------------		-- listener for xml request
function networkListenerData(event)	if (event.isError) then
	   print("Network error!")
   else
   	--local xml = XmlParser:ParseXmlText(event.response)		local inbox = xml:loadFile( "score.xml", system.DocumentsDirectory )   	list:displayData(inbox)
   end
end