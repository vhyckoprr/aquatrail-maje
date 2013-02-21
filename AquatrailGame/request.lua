require ("ScoreScreen")require ("parsing")-------------------- listener for xml request
function networkListenerData(event)	if (event.isError) then
	   print("Network error!")
   else
		--local xml = XmlParser:ParseXmlText(event.response)		local inbox = xml:loadFile( "score.xml", system.DocumentsDirectory )		print(inbox.child[1].name)		DisplayData(inbox)
   end
end