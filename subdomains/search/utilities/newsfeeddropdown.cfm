<cfif isdefined('form.submit')>
	<cfset stNewsFeeds = StructNew()>
	<cfset StructClear(stNewsFeeds)>
	<cfloop index="ListSelected" list="#form.NewsFeeds#">
		<cfset stNewsFeeds[#ListGetAt(ListSelected,1,"~")#] = "#ListGetAt(ListSelected,2,"~")#">
	</cfloop>
	<CF_FLASHMOREOVER BGCOLOR="000000" NUMITEMS="10" STNEWSFEEDS="#stNewsFeeds#">
</cfif>
<form name="newsfeedselections" action="newsfeeddropdown.cfm" method="post">
<select name="NewsFeeds" size="10" multiple>
<option value="0">----Business: general----</option>
<option value="CRM news~http://p.moreover.com/cgi-local/page?c=CRM%20news&o=wddx">CRM news
<option value="Entrepreneur news~http://p.moreover.com/cgi-local/page?c=Entrepreneur%20news&o=wddx">Entrepreneur news
<option value="Human resources~http://p.moreover.com/cgi-local/page?c=Human%20resources%20news&o=wddx">Human resources news
<option value="IP and patents news~http://p.moreover.com/cgi-local/page?c=IP%20and%20patents%20news&o=wddx">IP and patents news
<option value="Job markets news~http://p.moreover.com/cgi-local/page?c=Job%20markets%20news&o=wddx">Job markets news
<option value="Law news~http://p.moreover.com/cgi-local/page?c=Law%20news&o=wddx">Law news
<option value="Management news~http://p.moreover.com/cgi-local/page?c=Management%20news&o=wddx">Management news
<option value="Marketing news~http://p.moreover.com/cgi-local/page?c=Marketing%20news&o=wddx">Marketing news
<option value="Small business news~http://p.moreover.com/cgi-local/page?c=Small%20business%20news&o=wddx">Small business news
<option value="UK business news~http://p.moreover.com/cgi-local/page?c=UK%20business%20news&o=wddx">UK business news
<option value="UK law news~http://p.moreover.com/cgi-local/page?c=UK%20law%20news&o=wddx">UK law news
<option value="0">----Business: media----</option>
<option value="Advertising industry news~http://p.moreover.com/cgi-local/page?c=Advertising%20industry%20news&o=wddx">Advertising industry news
<option value="Book publishing news~http://p.moreover.com/cgi-local/page?c=Book%20publishing%20news&o=wddx">Book publishing news
<option value="Broadcasting industry news~http://p.moreover.com/cgi-local/page?c=Broadcasting%20industry%20news&o=wddx">Broadcasting industry news
<option value="Cable industry news~http://p.moreover.com/cgi-local/page?c=Cable%20industry%20news&o=wddx">Cable industry news
<option value="Digital television news~http://p.moreover.com/cgi-local/page?c=Digital%20television%20news&o=wddx">Digital television news
<option value="Journalism news~http://p.moreover.com/cgi-local/page?c=Journalism%20news&o=wddx">Journalism news
<option value="Media: Europe news~http://p.moreover.com/cgi-local/page?c=Media%3A%20Europe%20news&o=wddx">Media: Europe news
<option value="Movie business news~http://p.moreover.com/cgi-local/page?c=Movie%20business%20news&o=wddx">Movie business news
<option value="Music business news~http://p.moreover.com/cgi-local/page?c=Music%20business%20news&o=wddx">Music business news
<option value="Newspaper publishing news~http://p.moreover.com/cgi-local/page?c=Newspaper%20publishing%20news&o=wddx">Newspaper publishing news
<option value="UK media news~http://p.moreover.com/cgi-local/page?c=UK%20media%20news&o=wddx">UK media news
<option value="0">----Companies----</option>
<option value="3M news~http://p.moreover.com/cgi-local/page?c=3M%20news&o=wddx">3M news
<option value="AT&amp;T news~http://p.moreover.com/cgi-local/page?c=AT%26amp%3BT%20news&o=wddx">AT&amp;T news
<option value="Alcoa news~http://p.moreover.com/cgi-local/page?c=Alcoa%20news&o=wddx">Alcoa news
<option value="Altria news~http://p.moreover.com/cgi-local/page?c=Altria%20news&o=wddx">Altria news
<option value="American Express news~http://p.moreover.com/cgi-local/page?c=American%20Express%20news&o=wddx">American Express news
<option value="Boeing news~http://p.moreover.com/cgi-local/page?c=Boeing%20news&o=wddx">Boeing news
<option value="Caterpillar Inc news~http://p.moreover.com/cgi-local/page?c=Caterpillar%20Inc%20news&o=wddx">Caterpillar Inc news
<option value="Citigroup news~http://p.moreover.com/cgi-local/page?c=Citigroup%20news&o=wddx">Citigroup news
<option value="Coca-Cola news~http://p.moreover.com/cgi-local/page?c=Coca%2DCola%20news&o=wddx">Coca-Cola news
<option value="DuPont news~http://p.moreover.com/cgi-local/page?c=DuPont%20news&o=wddx">DuPont news
<option value="Eastman Kodak news~http://p.moreover.com/cgi-local/page?c=Eastman%20Kodak%20news&o=wddx">Eastman Kodak news
<option value="Exxon Mobil news~http://p.moreover.com/cgi-local/page?c=Exxon%20Mobil%20news&o=wddx">Exxon Mobil news
<option value="General Electric Company news~http://p.moreover.com/cgi-local/page?c=General%20Electric%20Company%20news&o=wddx">General Electric Company news
<option value="General Motors news~http://p.moreover.com/cgi-local/page?c=General%20Motors%20news&o=wddx">General Motors news
<option value="Hewlett-Packard news~http://p.moreover.com/cgi-local/page?c=Hewlett%2DPackard%20news&o=wddx">Hewlett-Packard news
<option value="Home Depot news~http://p.moreover.com/cgi-local/page?c=Home%20Depot%20news&o=wddx">Home Depot news
<option value="Honeywell International news~http://p.moreover.com/cgi-local/page?c=Honeywell%20International%20news&o=wddx">Honeywell International news
<option value="IBM news~http://p.moreover.com/cgi-local/page?c=IBM%20news&o=wddx">IBM news
<option value="Intel news~http://p.moreover.com/cgi-local/page?c=Intel%20news&o=wddx">Intel news
<option value="International Paper Company news~http://p.moreover.com/cgi-local/page?c=International%20Paper%20Company%20news&o=wddx">International Paper Company news
<option value="JP Morgan news~http://p.moreover.com/cgi-local/page?c=JP%20Morgan%20news&o=wddx">JP Morgan news
<option value="Johnson &amp; Johnson news~http://p.moreover.com/cgi-local/page?c=Johnson%20%26amp%3B%20Johnson%20news&o=wddx">Johnson &amp; Johnson news
<option value="McDonalds news~http://p.moreover.com/cgi-local/page?c=McDonalds%20news&o=wddx">McDonalds news
<option value="http://p.moreover.com/cgi-local/page?c=Merck%20%26amp%3B%20Co%20news&o=wddx">Merck &amp; Co news
<option value="Microsoft news~http://p.moreover.com/cgi-local/page?c=Microsoft%20news&o=wddx">Microsoft news
<option value="Procter &amp; Gamble news~http://p.moreover.com/cgi-local/page?c=Procter%20%26amp%3B%20Gamble%20news&o=wddx">Procter &amp; Gamble news
<option value="SBC Communications news~http://p.moreover.com/cgi-local/page?c=SBC%20Communications%20news&o=wddx">SBC Communications news
<option value="United Technologies news~http://p.moreover.com/cgi-local/page?c=United%20Technologies%20news&o=wddx">United Technologies news
<option value="Wal-Mart Stores news~http://p.moreover.com/cgi-local/page?c=Wal%2DMart%20Stores%20news&o=wddx">Wal-Mart Stores news
<option value="Walt Disney news~http://p.moreover.com/cgi-local/page?c=Walt%20Disney%20news&o=wddx">Walt Disney news
<option value="0">----Entertainment----</option>
<option value="Arts and culture news~http://p.moreover.com/cgi-local/page?c=Arts%20and%20culture%20news&o=wddx">Arts and culture news
<option value="Consumer: book reviews~http://p.moreover.com/cgi-local/page?c=Consumer%3A%20book%20reviews&o=wddx">Consumer: book reviews
<option value="Entertainment: TV shows news~http://p.moreover.com/cgi-local/page?c=Entertainment%3A%20TV%20shows%20news&o=wddx">Entertainment: TV shows news
<option value="Entertainment: film previews~http://p.moreover.com/cgi-local/page?c=Entertainment%3A%20film%20previews&o=wddx">Entertainment: film previews
<option value="Entertainment: general ne~http://p.moreover.com/cgi-local/page?c=Entertainment%3A%20general%20news&o=wddx">Entertainment: general news
<option value="Entertainment: gossip~http://p.moreover.com/cgi-local/page?c=Entertainment%3A%20gossip&o=wddx">Entertainment: gossip
<option value="Jokes~http://p.moreover.com/cgi-local/page?c=Jokes&o=wddx">Jokes
<option value="MP3 news~http://p.moreover.com/cgi-local/page?c=MP3%20news&o=wddx">MP3 news
<option value="Entertainment: movie reviews~http://p.moreover.com/cgi-local/page?c=Entertainment%3A%20movie%20reviews&o=wddx">Entertainment: movie reviews
<option value="Online games~http://p.moreover.com/cgi-local/page?c=Online%20games&o=wddx">Online games
<option value="Pop music news~http://p.moreover.com/cgi-local/page?c=Pop%20music%20news&o=wddx">Pop music news
<option value="Pop music reviews~http://p.moreover.com/cgi-local/page?c=Pop%20music%20reviews&o=wddx">Pop music reviews
<option value="Videogame news~http://p.moreover.com/cgi-local/page?c=UK%20tabloid%20news&o=wddx">UK tabloid news
<option value="Videogame news~http://p.moreover.com/cgi-local/page?c=Videogame%20news&o=wddx">Videogame news
<option value="0">----Finance----</option>
<option value="Banking news~http://p.moreover.com/cgi-local/page?c=Banking%20news&o=wddx">Banking news
<option value="US banking news~http://p.moreover.com/cgi-local/page?c=US%20banking%20news&o=wddx">US banking news
<option value="Commodities news~http://p.moreover.com/cgi-local/page?c=Commodities%20news&o=wddx">Commodities news
<option value="Corporate finance news~http://p.moreover.com/cgi-local/page?c=Corporate%20finance%20news&o=wddx">Corporate finance news
<option value="Derivatives news~http://p.moreover.com/cgi-local/page?c=Derivatives%20news&o=wddx">Derivatives news
<option value="Emerging markets news~http://p.moreover.com/cgi-local/page?c=Emerging%20markets%20news&o=wddx">Emerging markets news
<option value="Equity markets news~http://p.moreover.com/cgi-local/page?c=Equity%20markets%20news&o=wddx">Equity markets news
<option value="Fed watch~http://p.moreover.com/cgi-local/page?c=Fed%20watch&o=wddx">Fed watch
<option value="Fixed income news~http://p.moreover.com/cgi-local/page?c=Fixed%20income%20news&o=wddx">Fixed income news
<option value="Forex markets news~http://p.moreover.com/cgi-local/page?c=Forex%20markets%20news&o=wddx">Forex markets news
<option value="Fund management news~http://p.moreover.com/cgi-local/page?c=Fund%20management%20news&o=wddx">Fund management news
<option value="IPO news~http://p.moreover.com/cgi-local/page?c=IPO%20news&o=wddx">IPO news
<option value="Mergers and acquisitions news~http://p.moreover.com/cgi-local/page?c=Mergers%20and%20acquisitions%20news&o=wddx">Mergers and acquisitions news
<option value="Mutual funds news~http://p.moreover.com/cgi-local/page?c=Mutual%20funds%20news&o=wddx">Mutual funds news
<option value="Online banking news~http://p.moreover.com/cgi-local/page?c=Online%20banking%20news&o=wddx">Online banking news
<option value="Online broker news~http://p.moreover.com/cgi-local/page?c=Online%20broker%20news&o=wddx">Online broker news
<option value="Personal finance news~http://p.moreover.com/cgi-local/page?c=Personal%20finance%20news&o=wddx">Personal finance news
<option value="Retail investor news~http://p.moreover.com/cgi-local/page?c=Retail%20investor%20news&o=wddx">Retail investor news
<option value="Securities industry news~http://p.moreover.com/cgi-local/page?c=Securities%20industry%20news&o=wddx">Securities industry news
<option value="Stock Exchanges news~http://p.moreover.com/cgi-local/page?c=Stock%20Exchanges%20news&o=wddx">Stock Exchanges news
<option value="Stockwatch~http://p.moreover.com/cgi-local/page?c=Stockwatch&o=wddx">Stockwatch
<option value="Tech stocks news~http://p.moreover.com/cgi-local/page?c=Tech%20stocks%20news&o=wddx">Tech stocks news
<option value="Venture capital news~http://p.moreover.com/cgi-local/page?c=Venture%20capital%20news&o=wddx">Venture capital news
<option value="0">----Industry----</option>
<option value="Accounting news~http://p.moreover.com/cgi-local/page?c=Accounting%20news&o=wddx">Accounting news
<option value="Agriculture news~http://p.moreover.com/cgi-local/page?c=Agriculture%20news&o=wddx">Agriculture news
<option value="Airline industry news~http://p.moreover.com/cgi-local/page?c=Airline%20industry%20news&o=wddx">Airline industry news
<option value="Automotive industry news~http://p.moreover.com/cgi-local/page?c=Automotive%20industry%20news&o=wddx">Automotive industry news
<option value="Biotech news~http://p.moreover.com/cgi-local/page?c=Biotech%20news&o=wddx">Biotech news
<option value="Chemicals industry news~http://p.moreover.com/cgi-local/page?c=Chemicals%20industry%20news&o=wddx">Chemicals industry news
<option value="Clothing industry news~http://p.moreover.com/cgi-local/page?c=Clothing%20industry%20news&o=wddx">Clothing industry news
<option value="Construction news~http://p.moreover.com/cgi-local/page?c=Construction%20news&o=wddx">Construction news
<option value="Consumer durables news~http://p.moreover.com/cgi-local/page?c=Consumer%20durables%20news&o=wddx">Consumer durables news
<option value="Consumer electronics news~http://p.moreover.com/cgi-local/page?c=Consumer%20electronics%20news&o=wddx">Consumer electronics news
<option value="Consumer non-durables news~http://p.moreover.com/cgi-local/page?c=Consumer%20non%2Ddurables%20news&o=wddx">Consumer non-durables news
<option value="Aerospace and defense industry news~http://p.moreover.com/cgi-local/page?c=Aerospace%20and%20defense%20industry%20news&o=wddx">Aerospace and defense industry news
<option value="Drinks and beverages industry news~http://p.moreover.com/cgi-local/page?c=Drinks%20and%20beverages%20industry%20news&o=wddx">Drinks and beverages industry news
<option value="Engineering news~http://p.moreover.com/cgi-local/page?c=Engineering%20news&o=wddx">Engineering news
<option value="Firearms industry news~http://p.moreover.com/cgi-local/page?c=Firearms%20industry%20news&o=wddx">Firearms industry news
<option value="Food industry news~http://p.moreover.com/cgi-local/page?c=Food%20industry%20news&o=wddx">Food industry news
<option value="Gaming news~http://p.moreover.com/cgi-local/page?c=Gaming%20news&o=wddx">Gaming news
<option value="Healthcare management news~http://p.moreover.com/cgi-local/page?c=Healthcare%20management%20news&o=wddx">Healthcare management news
<option value="Hospitality industry news~http://p.moreover.com/cgi-local/page?c=Hospitality%20industry%20news&o=wddx">Hospitality industry news
<option value="Insurance industry news~http://p.moreover.com/cgi-local/page?c=Insurance%20industry%20news&o=wddx">Insurance industry news
<option value="Leisure goods news~http://p.moreover.com/cgi-local/page?c=Leisure%20goods%20news&o=wddx">Leisure goods news
<option value="Logistics news~http://p.moreover.com/cgi-local/page?c=Logistics%20news&o=wddx">Logistics news
<option value="Metals industry news~http://p.moreover.com/cgi-local/page?c=Metals%20industry%20news&o=wddx">Metals industry news
<option value="Mining and metals news~http://p.moreover.com/cgi-local/page?c=Mining%20and%20metals%20news&o=wddx">Mining and metals news
<option value="Mortgage industry news~http://p.moreover.com/cgi-local/page?c=Mortgage%20industry%20news&o=wddx">Mortgage industry news
<option value="Oil and gas news~http://p.moreover.com/cgi-local/page?c=Oil%20and%20gas%20news&o=wddx">Oil and gas news
<option value="Packaging and paper news~http://p.moreover.com/cgi-local/page?c=Packaging%20and%20paper%20news&o=wddx">Packaging and paper news
<option value="Pharma industry news~http://p.moreover.com/cgi-local/page?c=Pharma%20industry%20news&o=wddx">Pharma industry news
<option value="Plastics industry news~http://p.moreover.com/cgi-local/page?c=Plastics%20industry%20news&o=wddx">Plastics industry news
<option value="Real estate news~http://p.moreover.com/cgi-local/page?c=Real%20estate%20news&o=wddx">Real estate news
<option value="Retail sector news~Retail sector news~http://p.moreover.com/cgi-local/page?c=Retail%20sector%20news&o=wddx">Retail sector news
<option value="Shipping industry news~http://p.moreover.com/cgi-local/page?c=Shipping%20industry%20news&o=wddx">Shipping industry news
<option value="Sports business news~http://p.moreover.com/cgi-local/page?c=Sports%20business%20news&o=wddx">Sports business news
<option value="Steelmaking news~http://p.moreover.com/cgi-local/page?c=Steelmaking%20news&o=wddx">Steelmaking news
<option value="Textiles news~http://p.moreover.com/cgi-local/page?c=Textiles%20news&o=wddx">Textiles news
<option value="Tobacco industry news~http://p.moreover.com/cgi-local/page?c=Tobacco%20industry%20news&o=wddx">Tobacco industry news
<option value="Transportation industry news~http://p.moreover.com/cgi-local/page?c=Transportation%20industry%20news&o=wddx">Transportation industry news
<option value="Travel industry news~http://p.moreover.com/cgi-local/page?c=Travel%20industry%20news&o=wddx">Travel industry news
<option value="Utilities news~http://p.moreover.com/cgi-local/page?c=Utilities%20news&o=wddx">Utilities news
<option value="0">----Internet----</option>
<option value="Blogging news~http://p.moreover.com/cgi-local/page?c=Blogging%20news&o=wddx">Blogging news
<option value="Cool sites~http://p.moreover.com/cgi-local/page?c=Cool%20sites&o=wddx">Cool sites
<option value="Cyberculture news~http://p.moreover.com/cgi-local/page?c=Cyberculture%20news&o=wddx">Cyberculture news
<option value="Domain name news~http://p.moreover.com/cgi-local/page?c=Domain%20name%20news&o=wddx">Domain name news
<option value="E-commerce news~http://p.moreover.com/cgi-local/page?c=E%2Dcommerce%20news&o=wddx">E-commerce news
<option value="Internet Europe news~http://p.moreover.com/cgi-local/page?c=Internet%20Europe%20news&o=wddx">Internet Europe news
<option value="Internet Germany news~http://p.moreover.com/cgi-local/page?c=Internet%20Germany%20news&o=wddx">Internet Germany news
<option value="Internet Latin America news~http://p.moreover.com/cgi-local/page?c=Internet%20Latin%20America%20news&o=wddx">Internet Latin America news
<option value="Internet consultancies news~http://p.moreover.com/cgi-local/page?c=Internet%20consultancies%20news&o=wddx">Internet consultancies news
<option value="Internet: international news~http://p.moreover.com/cgi-local/page?c=Internet%3A%20international%20news&o=wddx">Internet: international news
<option value="Internet telephony news~http://p.moreover.com/cgi-local/page?c=Internet%20telephony%20news&o=wddx">Internet telephony news
<option value="Online access news~http://p.moreover.com/cgi-local/page?c=Online%20access%20news&o=wddx">Online access news
<option value="Online auction news~http://p.moreover.com/cgi-local/page?c=Online%20auction%20news&o=wddx">Online auction news
<option value="Online content news~http://p.moreover.com/cgi-local/page?c=Online%20content%20news&o=wddx">Online content news
<option value="Online information news~http://p.moreover.com/cgi-local/page?c=Online%20information%20news&o=wddx">Online information news
<option value="Online legal issues news~http://p.moreover.com/cgi-local/page?c=Online%20legal%20issues%20news&o=wddx">Online legal issues news
<option value="Online marketing news~http://p.moreover.com/cgi-local/page?c=Online%20marketing%20news&o=wddx">Online marketing news
<option value="Online portals news~http://p.moreover.com/cgi-local/page?c=Online%20portals%20news&o=wddx">Online portals news
<option value="Online search engines news~http://p.moreover.com/cgi-local/page?c=Online%20search%20engines%20news&o=wddx">Online search engines news
<option value="Software downloads~http://p.moreover.com/cgi-local/page?c=Software%20downloads&o=wddx">Software downloads
<option value="Vertical portals news~http://p.moreover.com/cgi-local/page?c=Vertical%20portals%20news&o=wddx">Vertical portals news
<option value="Web developer news~http://p.moreover.com/cgi-local/page?c=Web%20developer%20news&o=wddx">Web developer news
<option value="Web services news~http://p.moreover.com/cgi-local/page?c=Web%20services%20news&o=wddx">Web services news
<option value="Webmaster tips~http://p.moreover.com/cgi-local/page?c=Webmaster%20tips&o=wddx">Webmaster tips
<option value="Website owner news~http://p.moreover.com/cgi-local/page?c=Website%20owner%20news&o=wddx">Website owner news
<option value="XML and metadata news~http://p.moreover.com/cgi-local/page?c=XML%20and%20metadata%20news&o=wddx">XML and metadata news
<option value="0">----Lifestyle----</option>
<option value="Consumer: fashion news~http://p.moreover.com/cgi-local/page?c=Consumer%3A%20fashion%20news&o=wddx">Consumer: fashion news
<option value="Consumer: fitness news~http://p.moreover.com/cgi-local/page?c=Consumer%3A%20fitness%20news&o=wddx">Consumer: fitness news
<option value="Consumer: food and drink news~http://p.moreover.com/cgi-local/page?c=Consumer%3A%20food%20and%20drink%20news&o=wddx">Consumer: food and drink news
<option value="Consumer: health news~http://p.moreover.com/cgi-local/page?c=Consumer%3A%20health%20news&o=wddx">Consumer: health news
<option value="Consumer: home and garden news~http://p.moreover.com/cgi-local/page?c=Consumer%3A%20home%20and%20garden%20news&o=wddx">Consumer: home and garden news
<option value="Consumer: mens news~http://p.moreover.com/cgi-local/page?c=Consumer%3A%20mens%20news&o=wddx">Consumer: mens news
<option value="Consumer: natural health news~http://p.moreover.com/cgi-local/page?c=Consumer%3A%20natural%20health%20news&o=wddx">Consumer: natural health news
<option value="Consumer: outdoor recreation news~http://p.moreover.com/cgi-local/page?c=Consumer%3A%20outdoor%20recreation%20news&o=wddx">Consumer: outdoor recreation news
<option value="Consumer: parenting news~http://p.moreover.com/cgi-local/page?c=Consumer%3A%20parenting%20news&o=wddx">Consumer: parenting news
<option value="Consumer: seniors news~http://p.moreover.com/cgi-local/page?c=Consumer%3A%20seniors%20news&o=wddx">Consumer: seniors news
<option value="Consumer: travel news~http://p.moreover.com/cgi-local/page?c=Consumer%3A%20travel%20news&o=wddx">Consumer: travel news
<option value="Consumer: womens news~http://p.moreover.com/cgi-local/page?c=Consumer%3A%20womens%20news&o=wddx">Consumer: womens news
<option value="0">----Regional----</option>
<option value="Afghanistan news~http://p.moreover.com/cgi-local/page?c=Afghanistan%20news&o=wddx">Afghanistan news
<option value="Africa news~http://p.moreover.com/cgi-local/page?c=Africa%20news&o=wddx">Africa news
<option value="Argentina news~http://p.moreover.com/cgi-local/page?c=Argentina%20news&o=wddx">Argentina news
<option value="Australia news~http://p.moreover.com/cgi-local/page?c=Australia%20news&o=wddx">Australia news
<option value="Austria news~http://p.moreover.com/cgi-local/page?c=Austria%20news&o=wddx">Austria news
<option value="Balkans news~http://p.moreover.com/cgi-local/page?c=Balkans%20news&o=wddx">Balkans news
<option value="Benelux news~http://p.moreover.com/cgi-local/page?c=Benelux%20news&o=wddx">Benelux news
<option value="Brazil news~http://p.moreover.com/cgi-local/page?c=Brazil%20news&o=wddx">Brazil news
<option value="Canada news~http://p.moreover.com/cgi-local/page?c=Canada%20news&o=wddx">Canada news
<option value="Caribbean news~http://p.moreover.com/cgi-local/page?c=Caribbean%20news&o=wddx">Caribbean news
<option value="Caucasus news~http://p.moreover.com/cgi-local/page?c=Caucasus%20news&o=wddx">Caucasus news
<option value="Central Asia news~http://p.moreover.com/cgi-local/page?c=Central%20Asia%20news&o=wddx">Central Asia news
<option value="China news~http://p.moreover.com/cgi-local/page?c=China%20news&o=wddx">China news
<option value="Cuba news~http://p.moreover.com/cgi-local/page?c=Cuba%20news&o=wddx">Cuba news
<option value="Czech Republic and Slovakia news~http://p.moreover.com/cgi-local/page?c=Czech%20Republic%20and%20Slovakia%20news&o=wddx">Czech Republic and Slovakia news
<option value="EU integration news~http://p.moreover.com/cgi-local/page?c=EU%20integration%20news&o=wddx">EU integration news
<option value="Eastern Europe news~http://p.moreover.com/cgi-local/page?c=Eastern%20Europe%20news&o=wddx">Eastern Europe news
<option value="Europe news~http://p.moreover.com/cgi-local/page?c=Europe%20news&o=wddx">Europe news
<option value="European business news~http://p.moreover.com/cgi-local/page?c=European%20business%20news&o=wddx">European business news
<option value="France news~http://p.moreover.com/cgi-local/page?c=France%20news&o=wddx">France news
<option value="Germany news~http://p.moreover.com/cgi-local/page?c=Germany%20news&o=wddx">Germany news
<option value="Greece news~http://p.moreover.com/cgi-local/page?c=Greece%20news&o=wddx">Greece news
<option value="Hungary news~http://p.moreover.com/cgi-local/page?c=Hungary%20news&o=wddx">Hungary news
<option value="India news~http://p.moreover.com/cgi-local/page?c=India%20news&o=wddx">India news
<option value="Indian subcontinent news~http://p.moreover.com/cgi-local/page?c=Indian%20subcontinent%20news&o=wddx">Indian subcontinent news
<option value="Indonesia news~http://p.moreover.com/cgi-local/page?c=Indonesia%20news&o=wddx">Indonesia news
<option value="Iran news~http://p.moreover.com/cgi-local/page?c=Iran%20news&o=wddx">Iran news
<option value="Iraq news~http://p.moreover.com/cgi-local/page?c=Iraq%20news&o=wddx">Iraq news
<option value="Ireland news~http://p.moreover.com/cgi-local/page?c=Ireland%20news&o=wddx">Ireland news
<option value="Israel news~http://p.moreover.com/cgi-local/page?c=Israel%20news&o=wddx">Israel news
<option value="Italy news~http://p.moreover.com/cgi-local/page?c=Italy%20news&o=wddx">Italy news
<option value="Japan news~http://p.moreover.com/cgi-local/page?c=Japan%20news&o=wddx">Japan news
<option value="Korea news~http://p.moreover.com/cgi-local/page?c=Korea%20news&o=wddx">Korea news
<option value="Latin America news~http://p.moreover.com/cgi-local/page?c=Latin%20America%20news&o=wddx">Latin America news
<option value="London news~http://p.moreover.com/cgi-local/page?c=London%20news&o=wddx">London news
<option value="Mexico news~http://p.moreover.com/cgi-local/page?c=Mexico%20news&o=wddx">Mexico news
<option value="Mideast news~http://p.moreover.com/cgi-local/page?c=Mideast%20news&o=wddx">Mideast news
<option value="New Zealand news~http://p.moreover.com/cgi-local/page?c=New%20Zealand%20news&o=wddx">New Zealand news
<option value="North Africa news~http://p.moreover.com/cgi-local/page?c=North%20Africa%20news&o=wddx">North Africa news
<option value="Pakistan news~http://p.moreover.com/cgi-local/page?c=Pakistan%20news&o=wddx">Pakistan news
<option value="Philippines news~http://p.moreover.com/cgi-local/page?c=Philippines%20news&o=wddx">Philippines news
<option value="Poland news~http://p.moreover.com/cgi-local/page?c=Poland%20news&o=wddx">Poland news
<option value="Portugal news~http://p.moreover.com/cgi-local/page?c=Portugal%20news&o=wddx">Portugal news
<option value="Russia news~http://p.moreover.com/cgi-local/page?c=Russia%20news&o=wddx">Russia news
<option value="Scandinavia news~http://p.moreover.com/cgi-local/page?c=Scandinavia%20news&o=wddx">Scandinavia news
<option value="South Africa news~http://p.moreover.com/cgi-local/page?c=South%20Africa%20news&o=wddx">South Africa news
<option value="Southeast Asia news~http://p.moreover.com/cgi-local/page?c=Southeast%20Asia%20news&o=wddx">Southeast Asia news
<option value="Spain news~http://p.moreover.com/cgi-local/page?c=Spain%20news&o=wddx">Spain news
<option value="Syria news~http://p.moreover.com/cgi-local/page?c=Syria%20news&o=wddx">Syria news
<option value="Taiwan news~http://p.moreover.com/cgi-local/page?c=Taiwan%20news&o=wddx">Taiwan news
<option value="Turkey news~http://p.moreover.com/cgi-local/page?c=Turkey%20news&o=wddx">Turkey news
<option value="UK news~http://p.moreover.com/cgi-local/page?c=UK%20news&o=wddx">UK news
<option value="Zimbabwe news~http://p.moreover.com/cgi-local/page?c=Zimbabwe%20news&o=wddx">Zimbabwe news
<option value="0">----Science----</option>
<option value="Cancer news~http://p.moreover.com/cgi-local/page?c=Cancer%20news&o=wddx">Cancer news
<option value="Environment news~http://p.moreover.com/cgi-local/page?c=Environment%20news&o=wddx">Environment news
<option value="GMO news~http://p.moreover.com/cgi-local/page?c=GMO%20news&o=wddx">GMO news
<option value="Genetics news~http://p.moreover.com/cgi-local/page?c=Genetics%20news&o=wddx">Genetics news
<option value="Medical news~http://p.moreover.com/cgi-local/page?c=Medical%20news&o=wddx">Medical news
<option value="Nanotechnology news~http://p.moreover.com/cgi-local/page?c=Nanotechnology%20news&o=wddx">Nanotechnology news
<option value="Public health news~http://p.moreover.com/cgi-local/page?c=Public%20health%20news&o=wddx">Public health news
<option value="Science: biological sciences news~http://p.moreover.com/cgi-local/page?c=Science%3A%20biological%20sciences%20news&o=wddx">Science: biological sciences news
<option value="Science news~http://p.moreover.com/cgi-local/page?c=Science%20news&o=wddx">Science news
<option value="Science: human sciences news~http://p.moreover.com/cgi-local/page?c=Science%3A%20human%20sciences%20news&o=wddx">Science: human sciences news
<option value="Science: physical sciences news~http://p.moreover.com/cgi-local/page?c=Science%3A%20physical%20sciences%20news&o=wddx">Science: physical sciences news
<option value="Space science news~http://p.moreover.com/cgi-local/page?c=Space%20science%20news&o=wddx">Space science news
<option value="UK medical news~http://p.moreover.com/cgi-local/page?c=UK%20medical%20news&o=wddx">UK medical news
<option value="0">----Society----</option>
<option value="Black interest news~http://p.moreover.com/cgi-local/page?c=Black%20interest%20news&o=wddx">Black interest news
<option value="Charities news~http://p.moreover.com/cgi-local/page?c=Charities%20news&o=wddx">Charities news
<option value="Crime and punishment news~http://p.moreover.com/cgi-local/page?c=Crime%20and%20punishment%20news&o=wddx">Crime and punishment news
<option value="Economics news~http://p.moreover.com/cgi-local/page?c=Economics%20news&o=wddx">Economics news
<option value="Gay news~http://p.moreover.com/cgi-local/page?c=Gay%20news&o=wddx">Gay news
<option value="Human rights news~http://p.moreover.com/cgi-local/page?c=Human%20rights%20news&o=wddx">Human rights news
<option value="International development news~http://p.moreover.com/cgi-local/page?c=International%20development%20news&o=wddx">International development news
<option value="Jewish news~http://p.moreover.com/cgi-local/page?c=Jewish%20news&o=wddx">Jewish news
<option value="Latino news~http://p.moreover.com/cgi-local/page?c=Latino%20news&o=wddx">Latino news
<option value="Obituaries~http://p.moreover.com/cgi-local/page?c=Obituaries&o=wddx">Obituaries
<option value="Offbeat news~http://p.moreover.com/cgi-local/page?c=Offbeat%20news&o=wddx">Offbeat news
<option value="Personal data privacy news~http://p.moreover.com/cgi-local/page?c=Personal%20data%20privacy%20news&o=wddx">Personal data privacy news
<option value="Police news~http://p.moreover.com/cgi-local/page?c=Police%20news&o=wddx">Police news
<option value="US political columnists~http://p.moreover.com/cgi-local/page?c=US%20political%20columnists&o=wddx">US political columnists
<option value="Religion news~http://p.moreover.com/cgi-local/page?c=Religion%20news&o=wddx">Religion news
<option value="Trade news~http://p.moreover.com/cgi-local/page?c=Trade%20news&o=wddx">Trade news
<option value="UK black interest news~http://p.moreover.com/cgi-local/page?c=UK%20black%20interest%20news&o=wddx">UK black interest news
<option value="UK education news~http://p.moreover.com/cgi-local/page?c=UK%20education%20news&o=wddx">UK education news
<option value="UK immigration news~http://p.moreover.com/cgi-local/page?c=UK%20immigration%20news&o=wddx">UK immigration news
<option value="UK politics news~http://p.moreover.com/cgi-local/page?c=UK%20politics%20news&o=wddx">UK politics news
<option value="US education news~http://p.moreover.com/cgi-local/page?c=US%20education%20news&o=wddx">US education news
<option value="US immigration news~http://p.moreover.com/cgi-local/page?c=US%20immigration%20news&o=wddx">US immigration news
<option value="US politics news~http://p.moreover.com/cgi-local/page?c=US%20politics%20news&o=wddx">US politics news
<option value="US security news~http://p.moreover.com/cgi-local/page?c=US%20security%20news&o=wddx">US security news
<option value="US social policy news~http://p.moreover.com/cgi-local/page?c=US%20social%20policy%20news&o=wddx">US social policy news
<option value="Womens rights news~http://p.moreover.com/cgi-local/page?c=Womens%20rights%20news&o=wddx">Womens rights news
<option value="0">----Sports----</option>
<option value="Sports: baseball news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20baseball%20news&o=wddx">Sports: baseball news
<option value="Sports: basketball news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20basketball%20news&o=wddx">Sports: basketball news
<option value="Sports: boxing news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20boxing%20news&o=wddx">Sports: boxing news
<option value="Sports: cricket news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20cricket%20news&o=wddx">Sports: cricket news
<option value="Sports: cycling news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20cycling%20news&o=wddx">Sports: cycling news
<option value="Sports: American football news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20American%20football%20news&o=wddx">Sports: American football news
<option value="Sports: soccer news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20soccer%20news&o=wddx">Sports: soccer news
<option value="Sports: golf news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20golf%20news&o=wddx">Sports: golf news
<option value="Sports: horse racing news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20horse%20racing%20news&o=wddx">Sports: horse racing news
<option value="Sports: ice hockey news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20ice%20hockey%20news&o=wddx">Sports: ice hockey news
<option value="Sports: major league soccer news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20major%20league%20soccer%20news&o=wddx">Sports: major league soccer news
<option value="Sports: motor sports news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20motor%20sports%20news&o=wddx">Sports: motor sports news
<option value="Sports: Olympic sports news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20Olympic%20sports%20news&o=wddx">Sports: Olympic sports news
<option value="Sports: rugby news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20rugby%20news&o=wddx">Sports: rugby news
<option value="Sports: tennis news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20tennis%20news&o=wddx">Sports: tennis news
<option value="Sports: wrestling news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20wrestling%20news&o=wddx">Sports: wrestling news
<option value="Sports: yachting news~http://p.moreover.com/cgi-local/page?c=Sports%3A%20yachting%20news&o=wddx">Sports: yachting news
<option value="0">----Technology----</option>
<option value="3G and GPRS news~http://p.moreover.com/cgi-local/page?c=3G%20and%20GPRS%20news&o=wddx">3G and GPRS news
<option value="ASP news~http://p.moreover.com/cgi-local/page?c=ASP%20news&o=wddx">ASP news
<option value="Communications equipment news~http://p.moreover.com/cgi-local/page?c=Communications%20equipment%20news&o=wddx">Communications equipment news
<option value="http://p.moreover.com/cgi-local/page?c=Computer%20games%20news&o=wddx">Computer games news
<option value="Computer security news~http://p.moreover.com/cgi-local/page?c=Computer%20security%20news&o=wddx">Computer security news
<option value="Computer services news~http://p.moreover.com/cgi-local/page?c=Computer%20services%20news&o=wddx">Computer services news
<option value="Database industry news~http://p.moreover.com/cgi-local/page?c=Database%20industry%20news&o=wddx">Database industry news
<option value="Developer news~http://p.moreover.com/cgi-local/page?c=Developer%20news&o=wddx">Developer news
<option value="Enterprise computing news~http://p.moreover.com/cgi-local/page?c=Enterprise%20computing%20news&o=wddx">Enterprise computing news
<option value="Graphics industry news~http://p.moreover.com/cgi-local/page?c=Graphics%20industry%20news&o=wddx">Graphics industry news
<option value="Handhelds news~http://p.moreover.com/cgi-local/page?c=Handhelds%20news&o=wddx">Handhelds news
<option value="Imaging equipment news~http://p.moreover.com/cgi-local/page?c=Imaging%20equipment%20news&o=wddx">Imaging equipment news
<option value="Java news~http://p.moreover.com/cgi-local/page?c=Java%20news&o=wddx">Java news
<option value="Knowledge management news~http://p.moreover.com/cgi-local/page?c=Knowledge%20management%20news&o=wddx">Knowledge management news
<option value="Linux news~http://p.moreover.com/cgi-local/page?c=Linux%20news&o=wddx">Linux news
<option value="Macintosh news~http://p.moreover.com/cgi-local/page?c=Macintosh%20news&o=wddx">Macintosh news
<option value="OS news~http://p.moreover.com/cgi-local/page?c=OS%20news&o=wddx">OS news
<option value="Open source news~http://p.moreover.com/cgi-local/page?c=Open%20source%20news&o=wddx">Open source news
<option value="PC industry news~http://p.moreover.com/cgi-local/page?c=PC%20industry%20news&o=wddx">PC industry news
<option value="PC software news~http://p.moreover.com/cgi-local/page?c=PC%20software%20news&o=wddx">PC software news
<option value="Personal technology news~http://p.moreover.com/cgi-local/page?c=Personal%20technology%20news&o=wddx">Personal technology news
<option value="Robotics news~http://p.moreover.com/cgi-local/page?c=Robotics%20news&o=wddx">Robotics news
<option value="Semiconductor industry news~http://p.moreover.com/cgi-local/page?c=Semiconductor%20industry%20news&o=wddx">Semiconductor industry news
<option value="Tech events~http://p.moreover.com/cgi-local/page?c=Tech%20events&o=wddx">Tech events
<option value="Tech policy news~http://p.moreover.com/cgi-local/page?c=Tech%20policy%20news&o=wddx">Tech policy news
<option value="Telecom news~http://p.moreover.com/cgi-local/page?c=Telecom%20news&o=wddx">Telecom news
<option value="Virus warnings~http://p.moreover.com/cgi-local/page?c=Virus%20warnings&o=wddx">Virus warnings
<option value="Windows 2000 news~http://p.moreover.com/cgi-local/page?c=Windows%202000%20news&o=wddx">Windows 2000 news
<option value="Wireless sector news~http://p.moreover.com/cgi-local/page?c=Wireless%20sector%20news&o=wddx">Wireless sector news
<option value="0">----Top stories----</option>
<option value="Asia-Pacific latest~http://p.moreover.com/cgi-local/page?c=Asia%2DPacific%20latest&o=wddx">Asia-Pacific latest
<option value="International relations news~http://p.moreover.com/cgi-local/page?c=International%20relations%20news&o=wddx">International relations news
<option value="Tech latest~http://p.moreover.com/cgi-local/page?c=Tech%20latest&o=wddx">Tech latest
<option value="Top Asia-Pacific stories~http://p.moreover.com/cgi-local/page?c=Top%20Asia%2DPacific%20stories&o=wddx">Top Asia-Pacific stories
<option value="Top US stories~http://p.moreover.com/cgi-local/page?c=Top%20US%20stories&o=wddx">Top US stories
<option value="Top business stories~http://p.moreover.com/cgi-local/page?c=Top%20business%20stories&o=wddx">Top business stories
<option value="Consumer: top stories~http://p.moreover.com/cgi-local/page?c=Consumer%3A%20top%20stories&o=wddx">Consumer: top stories
<option value="Top finance stories~http://p.moreover.com/cgi-local/page?c=Top%20finance%20stories&o=wddx">Top finance stories
<option value="Top internet stories~http://p.moreover.com/cgi-local/page?c=Top%20internet%20stories&o=wddx">Top internet stories
<option value="Top media stories~http://p.moreover.com/cgi-local/page?c=Top%20media%20stories&o=wddx">Top media stories
<option value="Sports: top stories~http://p.moreover.com/cgi-local/page?c=Sports%3A%20top%20stories&o=wddx">Sports: top stories
<option value="Top stories~http://p.moreover.com/cgi-local/page?c=Top%20stories&o=wddx">Top stories
<option value="Top technology stories~http://p.moreover.com/cgi-local/page?c=Top%20technology%20stories&o=wddx">Top technology stories
<option value="0">----US regional----</option>
<option value="Atlanta news~http://p.moreover.com/cgi-local/page?c=Atlanta%20news&o=wddx">Atlanta news
<option value="Boston news~http://p.moreover.com/cgi-local/page?c=Boston%20news&o=wddx">Boston news
<option value="Chicago news~http://p.moreover.com/cgi-local/page?c=Chicago%20news&o=wddx">Chicago news
<option value="Cleveland-Akron news~http://p.moreover.com/cgi-local/page?c=Cleveland%2DAkron%20news&o=wddx">Cleveland-Akron news
<option value="DC area news~http://p.moreover.com/cgi-local/page?c=DC%20area%20news&o=wddx">DC area news
<option value="Dallas-Fort Worth news~http://p.moreover.com/cgi-local/page?c=Dallas%2DFort%20Worth%20news&o=wddx">Dallas-Fort Worth news
<option value="Denver-Boulder news~http://p.moreover.com/cgi-local/page?c=Denver%2DBoulder%20news&o=wddx">Denver-Boulder news
<option value="Detroit news~http://p.moreover.com/cgi-local/page?c=Detroit%20news&o=wddx">Detroit news
<option value="Houston news~http://p.moreover.com/cgi-local/page?c=Houston%20news&o=wddx">Houston news
<option value="LA news~http://p.moreover.com/cgi-local/page?c=LA%20news&o=wddx">LA news
<option value="Miami-Fort Lauderdale news~http://p.moreover.com/cgi-local/page?c=Miami%2DFort%20Lauderdale%20news&o=wddx">Miami-Fort Lauderdale news
<option value="Minneapolis-St Paul news~http://p.moreover.com/cgi-local/page?c=Minneapolis%2DSt%20Paul%20news&o=wddx">Minneapolis-St Paul news
<option value="New York City news~http://p.moreover.com/cgi-local/page?c=New%20York%20City%20news&o=wddx">New York City news
<option value="Philadelphia news~http://p.moreover.com/cgi-local/page?c=Philadelphia%20news&o=wddx">Philadelphia news
<option value="Phoenix news~http://p.moreover.com/cgi-local/page?c=Phoenix%20news&o=wddx">Phoenix news
<option value="Pittsburgh news~http://p.moreover.com/cgi-local/page?c=Pittsburgh%20news&o=wddx">Pittsburgh news
<option value="Portland-Salem news~http://p.moreover.com/cgi-local/page?c=Portland%2DSalem%20news&o=wddx">Portland-Salem news
<option value="Bay Area news~http://p.moreover.com/cgi-local/page?c=Bay%20Area%20news&o=wddx">Bay Area news
<option value="San Diego news~http://p.moreover.com/cgi-local/page?c=San%20Diego%20news&o=wddx">San Diego news
<option value="Seattle-Tacoma news~http://p.moreover.com/cgi-local/page?c=Seattle%2DTacoma%20news&o=wddx">Seattle-Tacoma news
<option value="Silicon Valley news~http://p.moreover.com/cgi-local/page?c=Silicon%20Valley%20news&o=wddx">Silicon Valley news</option>
<option value="St Louis news~http://p.moreover.com/cgi-local/page?c=St%20Louis%20news&o=wddx">St Louis news</option>
<option value="Tampa-St Petersburg news~http://p.moreover.com/cgi-local/page?c=Tampa%2DSt%20Petersburg%20news&o=wddx">Tampa-St Petersburg news</option>
</select><input type="submit" name="submit" value="Select">
</form>




   
