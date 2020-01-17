
        <form method="post" action="<cfoutput>#buildURL('main.getCoaches')#</cfoutput>" style="color:#878b8e">
              <div class="form-group">
				  <label for="last name">Last Name:</label>
				  <input type="text" class="form-control" name="coachLname" value="<cfoutput>#rc.coachLname#</cfoutput>">
				</div>
				<div class="form-group">
				  <label for="state">State/Province/Other:</label>
				  <select class="form-control" name="coachState">
				     <option value="">--Select --</option>
                            <cfoutput query="rc.getCoachesState" group="state">
                                <cfif len(state) AND !FindNoCase('select',state)>
                                    <option value="#state#" <cfif rc.coachState eq state>selected</cfif>>#state#</option>
                                </cfif>
                            </cfoutput>
                        </select>
				</div>
                <div class="form-group">
				  <label for="country">Country</label>
				  		<select class="form-control" name="coachCountry">
			      			<option value="">--Select --</option>
                           <cfoutput query="rc.getCoachesCountry" group="country">
                               <cfif len(country) AND !FindNoCase('select',country)>
                                   <option value="#country#" <cfif rc.coachCountry eq country>selected</cfif>>#country#</option>
                               </cfif>
                           </cfoutput>
                       </select>
				</div>
				<div class="form-group">
					  <label for="coach zip code">Zip Code</label>
					  <select class="form-control" name="coachZip">
					      <option value="">--Select --</option>
                           <cfoutput query="rc.getCoachesZip" group="zipcode">
                               <cfif len(zipcode)>
                                   <option value="#zipcode#" <cfif rc.coachZip eq zipcode>selected</cfif>>#zipcode#</option>
                               </cfif>
                           </cfoutput>
                       </select>
				</div>
				<div class="form-group">
					  <label for="Licenses">License(s)</label>
					  <select class="form-control" name="licenses" multiple="true">
								<option value="0">--Select--</option>
									<cfoutput query="rc.getLicenses">
										<option value="#license#" <cfif structkeyExists(rc,'licenses') AND listFind(rc.licenses,license)>selected</cfif>>#license#</option>
									</cfoutput>
								</select>
                       </select>
				</div>
				<div class="form-group">
					  <label for="Education">Education</label>
					  <select class="form-control" name="education" multiple="true">
							<option value="0">--Select--</option>
							<cfoutput query="rc.getEducation">
								<option value="#education#" <cfif structkeyExists(rc,'education') AND listFind(rc.education,education)>selected</cfif>>#education#</option>
							</cfoutput>
						</select>
				</div>
				<a name="results"></a>
				<div class="form-group">
					  <label for="Coaching Certification">Coaching Certification(s)</label>
					  <select class="form-control" name="certification" multiple="true">
							<option value="0">--Select--</option>
							<cfoutput query="rc.getcoachCertifications">
								<option value="#certification#" <cfif structkeyExists(rc,'certification') AND listFind(rc.certification,certification)>selected</cfif>>#certification#</option>
							</cfoutput>
						</select>

				</div>
				<div class="form-group">
					  <label for="Coaching Specialties">Coaching Specialties</label>
					  <select class="form-control" name="specialties" multiple="true">
							<option value="0">--Select--</option>
							<cfoutput query="rc.getcoachingSpecialties">
								<option value="#specialty#" <cfif structkeyExists(rc,'specialties') AND listFind(rc.specialties,specialty)>selected</cfif>>#specialty#</option>
							</cfoutput>
						</select>

				</div>

				<div class="form-group">
					   <label for="Coaching Methods">Coaching Methods</label>
						<select class="form-control" name="coachingMethods" multiple="true">
							<option value="0">--Select--</option>
							<cfoutput query="rc.getcoachingMethods">
								<option value="#methods#" <cfif structkeyExists(rc,'coachingMethods') AND listFind(rc.coachingMethods,methods)>selected</cfif>>#methods#</option>
							</cfoutput>
						</select>
				</div>
				<div class="form-group">
					  <label for="Coaching Rate">Coaching Rate</label>
					  <select class="form-control" name="rate" multiple="true">
							<option value="0">--Select Rate--</option>
							<cfoutput query="rc.getCoachingRate">
								<option value="#rate#" <cfif structkeyExists(rc,'rate') AND listFind(rc.rate,rate)>selected</cfif>>#rate#</option>
							</cfoutput>
						</select>
				</div>
				<input class="btn btn-primary" value="Search" type="submit">
			<div>&nbsp;</div>
          
        </form>
