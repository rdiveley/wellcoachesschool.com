<cfcomponent>
	<cfscript>
			function arrayOfStructsSort(aOfS,key){
				//by default we'll use an ascending sort
				var sortOrder = "asc";		
				//by default, we'll use a textnocase sort
				var sortType = "textnocase";
				//by default, use ascii character 30 as the delim
				var delim = ".";
				//make an array to hold the sort stuff
				var sortArray = arraynew(1);
				//make an array to return
				var returnArray = arraynew(1);
				//grab the number of elements in the array (used in the loops)
				var count = arrayLen(aOfS);
				//make a variable to use in the loop
				var ii = 1;
				//if there is a 3rd argument, set the sortOrder
				if(arraylen(arguments) GT 2)
					sortOrder = arguments[3];
				//if there is a 4th argument, set the sortType
				if(arraylen(arguments) GT 3)
					sortType = arguments[4];
				//if there is a 5th argument, set the delim
				if(arraylen(arguments) GT 4)
					delim = arguments[5];
				//loop over the array of structs, building the sortArray
				for(ii = 1; ii lte count; ii = ii + 1)
					sortArray[ii] = aOfS[ii][key] & delim & ii;
				//now sort the array
				arraySort(sortArray,sortType,sortOrder);
				//now build the return array
				for(ii = 1; ii lte count; ii = ii + 1)
					returnArray[ii] = aOfS[listLast(sortArray[ii],delim)];
				//return the array
				return returnArray;
		}
		</cfscript>
</cfcomponent>