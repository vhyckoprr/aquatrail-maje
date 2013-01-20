--require ("xml_parser")require ("ScoreScreen")	------------------		-- listener for xml request
function networkListenerData(event)	if (event.isError) then
	   print("Network error!")
   else
   	--local xml = XmlParser:ParseXmlText(event.response)		local inbox = xml:loadFile( "score.xml", system.DocumentsDirectory )   	list:displayData(inbox)
   end
endfunction xmlValue(xmlTree, nodeName)	for i,xmlNode in pairs(xmlTree.ChildNodes) do
       
		if(xmlNode.Name==nodeName) then
			return xmlNode.Value
		end
	end
end