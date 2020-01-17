<cfsetting enablecfoutputonly="Yes">
<!---
	Coded by Fabien Meghazi a.k.a AMIGrAve (http://www.amigrave.com)
	The phonetic friendly mode was inspired from a javascript made by Michel Hoffmann (http://users.swing.be/michel.hoffmann)
--->
<!--- ************************** VALIDITE DES ARGUMENTS ************************************ --->
<cfset params="mode,case,lenght,var">
<cfparam name="attributes.mode" default="phon">
<cfparam name="attributes.case" default="lower">
<cfparam name="attributes.lenght" default="7">
<cfparam name="attributes.var" default="agrpwd">
<cfloop list="#params#" index="myparam"><cfset "#myparam#" = trim(evaluate("attributes.#myparam#"))></cfloop>

<cfset usage='</td></td></td></th></th></th></tr></tr></tr></table></table></table></a></abbrev></acronym></address></applet></au></b></banner></big></blink></blockquote></bq></caption></center></cite></code></comment></del></dfn></dir></div></dl></em></fig></fn></font></form></frame></frameset></h1></h2></h3></h4></h5></h6></head></i></ins></kbd></listing></map></marquee></menu></multicol></nobr></noframes></noscript></note></ol></p></param></person></plaintext></pre></q></s></samp></script></select></small></strike></strong></sub></sup></table></td></textarea></th></title></tr></tt></u></ul></var></wbr></xmp><h2>aGr_password:</h2>This tag genererates random passwords.<br><br><b><u>Usage:</u></b><br><br><pre>&lt;CF_password mode="alpha|num|mixed|<b>phon</b>" case="upper|<b>lower</b>|mixed" lenght="fixed_lenght|lower,higher" var="variable_name"&gt;</pre>'>

<cfif not(listcontainsnocase("alpha,num,mixed,phon",mode)) or not(listcontainsnocase("upper,lower,mixed",case))><cfoutput>error in syntax:<br>#usage#</cfoutput><cfabort></cfif>

<cfif isnumeric(lenght)>
	<cfset start=lenght>
	<cfset stop=lenght>
<cfelse>
	<cfif refind("([^0123456789,])|(,.+,)|,,|.+,$",lenght)><cfoutput>error in lenght argument:<br>#usage#</cfoutput><cfabort></cfif>
	<cfset leng=listtoarray(lenght)><cfset start=leng[1]><cfset stop=leng[2]>
</cfif>

<cfset pwd="">

<cfif mode is "phon">

<!--- *********** PWD GENERATOR (this is not a serial number generator for CF :) ****** --->
<!--- ************************** Phonetic Friendly ************************************ --->
<cfset voy=arraynew(1)>
<cfset voy[1]="a,e,i,o">
<cfset voy[2]="u,ou,eu,an">
<cfset voy[3]="a,e,y">
<cfset voyf="17,4,1">

<cfset con=arraynew(1)>
<cfset con[1]="d,f,g,l,m,n,p,r,s,t">
<cfset con[2]="b,c,br,cr,str,ch">
<cfset con[3]="h,j,k,w,z,v,ss">
<cfset conf="5,4,1">


<cfif not(randrange(0,3))>
	<cfset phon="voy">
	<cfset tmp=listtoarray(evaluate("#phon#f"))>
	<cfset freq=arraysum(tmp)>
	<cfset i=randrange(0,freq-1)>
	<cfif i lt tmp[1]>
		<cfset pwd=pwd & listgetat(evaluate("#phon#[1]"), randrange(1,listlen(evaluate("#phon#[1]"))))> 
	<cfelseif evaluate(i-tmp[1]+1) lt tmp[2]>
		<cfset pwd=pwd & listgetat(evaluate("#phon#[2]"), randrange(1,listlen(evaluate("#phon#[2]"))))> 
	<cfelse>
		<cfset pwd=pwd & listgetat(evaluate("#phon#[3]"), randrange(1,listlen(evaluate("#phon#[3]"))))> 
	</cfif>
</cfif>
<!---
	on pourrait eviter les 25 lignes suivantes si coldfusion permettait de definir
	des fonctions au sein d'une page ! mais bon, c'est pas grave, on a PHP pour ca !
	si on pouvait faire une fonction generphone, elle prendrait le parametre phon
	generphon('con');
	generphon('voy');
	serait plus simple non ? Esperons que pour les prochaines versions ...
--->
<cfset lengphon=randrange(start,stop)>
<cfloop condition="len(pwd) lt lengphon">
	<cfset phon="con">
	<cfset tmp=listtoarray(evaluate("#phon#f"))>
	<cfset freq=arraysum(tmp)>
	<cfset i=randrange(0,freq-1)>
	<cfif i lt tmp[1]>
		<cfset pwd=pwd & listgetat(evaluate("#phon#[1]"), randrange(1,listlen(evaluate("#phon#[1]"))))> 
	<cfelseif evaluate(i-tmp[1]+1) lt tmp[2]>
		<cfset pwd=pwd & listgetat(evaluate("#phon#[2]"), randrange(1,listlen(evaluate("#phon#[2]"))))> 
	<cfelse>
		<cfset pwd=pwd & listgetat(evaluate("#phon#[3]"), randrange(1,listlen(evaluate("#phon#[3]"))))> 
	</cfif>

	<cfset phon="voy">
	<cfset tmp=listtoarray(evaluate("#phon#f"))>
	<cfset freq=arraysum(tmp)>
	<cfset i=randrange(0,freq-1)>
	<cfif i lt tmp[1]>
		<cfset pwd=pwd & listgetat(evaluate("#phon#[1]"), randrange(1,listlen(evaluate("#phon#[1]"))))> 
	<cfelseif evaluate(i-tmp[1]+1) lt tmp[2]>
		<cfset pwd=pwd & listgetat(evaluate("#phon#[2]"), randrange(1,listlen(evaluate("#phon#[2]"))))> 
	<cfelse>
		<cfset pwd=pwd & listgetat(evaluate("#phon#[3]"), randrange(1,listlen(evaluate("#phon#[3]"))))> 
	</cfif>
</cfloop>
<!--- ********************************* Other Modes ************************************ --->
<cfelseif mode is "num">
	<cfloop from="1" to="#randrange(start,stop)#" index="none"><cfset pwd=pwd & chr(randrange(48,57))></cfloop>
<cfelseif mode is "alpha">
	<cfloop from="1" to="#randrange(start,stop)#" index="none"><cfset pwd=pwd & chr(randrange(97,122))></cfloop>
<cfelse>
	<cfloop from="1" to="#randrange(start,stop)#" index="none"><cfif randrange(0,2)><cfset pwd=pwd & chr(randrange(97,122))><cfelse><cfset pwd=pwd & chr(randrange(48,57))></cfif></cfloop>
</cfif>

<cfif case is "upper" and mode is not "num">
	<cfset pwd=ucase(pwd)>
<cfelseif case is "mixed" and mode is not "num">
	<cfset rand=pwd><cfset pwd="">
	<cfloop from="1" to="#len(rand)#" index="none">
		<cfset cr=left(rand,1)><cfif len(rand)-1><cfset rand=right(rand,len(rand)-1)></cfif>
		<cfif not(randrange(0,3))><cfset cr=ucase(cr)></cfif>
		<cfset pwd=pwd & cr>
	</cfloop>
</cfif>

<cfset "caller.#var#"=pwd>
<cfsetting enablecfoutputonly="No">