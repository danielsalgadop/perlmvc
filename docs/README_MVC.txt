____DESCRITPTION____
perl libraries
	uses CGI  (perl built-in)
	uses JSON
css
	bootstrap_3
js libraries
	jquery 1.11.2
	bootstrap_3
	datatables

tiny mvc written in perl with user validation.
Tested in IE8+ and Firefox 3.5+


____BASIC STRUCTURE OF A PROJECT____
(there are small variations from proyect to proyect, for example place of /models )
============
html/js/   				 	# all javscript code (and libraries)
html/css/ 					# all css code 
html/img/ 					# front-end images
html/cgi-bin/index.pl    	# ALL petitions pass throw here (once you are loged in)
html/cgi-bin/login.pl 		# for login in
html/cgi-bin/models/   		# models (usually .json)
html/cgi-bin/lib_proyect/   # folder with ALL libs used in mvc, or app (THIS wil be re-distributed in following versions)
		- miEnrutador.pm    	# (mvc) Maps url => controllers or view (web templates) . See below
		- controladores.pm  	# (mvc) controllers 
		- webTemplates.pm 		# (mvc) views
		- variables_globales.pm # (app) super global variables, are seen in all app
		- variables_paths.pm 	# (app) paths used in app
		- proyectHelpers.pm     # (app) extending functionality for app or mvc libraries
		- PROJECT-libraries     # (app) unique for this proyect
		- common-libraries.pm   # (common) multipurpose libraries time.pm, debug.pm, write2FileWithBlocker.pmm, miJson.pm miSession, are equal in all proyects. Details inside each library
html/cgi-bin/lib_proyect/tests  unit test of any sub
============
docs/    					# requirements
docs/svgs/    				# schemes of requirementes
============
deploy/ 					# shell script with rsync configured
============

____MVC____
From wikipedia:
MVC (Model-View-Comtroller) is an architectural pattern for implementing user interfaces. It divides the app intro three interconected parts

Model (inside models/ folder)  - manages the data, logic and rules of the aplication.
Controller (defined in controladores.pm lib) - can send messages to model (to update the model state). Can send messages to view to change representation.
View (defined in webTemplates.pm lib) - any representation of a model

login.pl to verifies log against models/users.json
stores de id_number in a cookie
and stores 'alias' in a SESSION varible

After loggin is done, all petitions are managed from index.pl (in every petition):
- boot comprobations are done
- reloging comprobation (redirected to login.pl if validation is lost)
- index.pl calles miEnrutador()

_Before explainig miEnrutador will see in glance the whole picture_
The petition STARTS at index.pl and ENDS (rare exceptions) in View (called webTemplates.pm)
1)The simpliest example (static pages). miEnrutador matches an url, calls the view.
2)The most complex example. miEnrutador matches and url and greps data, this is passed to the controller that interacts with the model, the controller then calls de View.
There are lots of possible complexities between this two cases.

_More level of detail_
1) simpliest example:
If in url you have
    index.pl/contacts
in miEnrutador.pm
	if ($url =~ /contacts&/){   # regex
		wtContacts()        # defined in webTemplates.pm
	}
in webTemplates.pm
	sub wtContacts(){
		print header();   # html headers are defined here, navigation bar etc...
		print "contacts are : blablablablabla";
		print footer();  # exit;
	}


2) complex example:
If in url you have
    index.pl/remove_user/Paul
in miEnrutador.pm
      /remove_user\/(\w)&/ (regex)
      cAction($1)     (notice you are passing 'Paul' to controller Action via $1) (defined in contoladores.pm)
in controladores.pm
	sub cRemoveUser($){
		my $user_name = shift;
		# logic to remove user, and also populating $message_of_logic
		wtRemoveUser($message_of_logic,$user_name);    (defined in webTemplates.pm)
	}
if webTemplates.pm
	sub wtRemoveUser($$){
		my $message = shift;
		my $user_name = shift;
		print header();
		print "borrar este user ".$user_name." tuvo este resultado ".$message."; 
		print footer();
	}
To see the logic in this last example, we have used the wtRemoveUser, while in real code a more usefull sub will need two extra params $result and an $action, it would be constructed this way:
sub wtUserActionResult($$$){
	my ($message,$user_name,$result,$action) = @_;
	my $div_color;
	if($result eq "OK"){
		$div_color="green";
	}
	else{
		$div_color="red";
	
	print '<div style="background-color:$div_color;">Al hacer $action, del usuario $user se obtuvo este mensaje $message</div>';
}

Using this you can reuse it for all controllers used for model user. (cRemoveUser, cCreateUser, cModifyUser).


To acomplish this there is a name convention.
Controllers use 'c' prefix and views use 'wt' prefix
Url '_' are not used in controllers or views, instead CamelCase is used. url(remove_user/Paul) is transalted to controller (cRemoveUser) and view (wtRemoveUser)


Generalities:

miEnrutador.pm
	- has the relationship between url=>actions to make.
	


Views (webTemplates)
	- is where html is written
	- you can have multiple views for same model


Other 'Pieces'
to mantain legible code if a logic is shared by multiple controllers, views or models. We use libraries called Helpers; controladoresHelpers.pm, webTemplateHelpers.pm modelsHelpers.pm. Not only for this components. Also tableHelpers.pm or logsHelpers.pm


Common libraries
miJson.pm				- json reader/writer
httpParamsControl.pm   	- function used to see if certain params are received via POST
miSession.pm			- getter and setters for SESSION variables
time.pm 				- datetime formated
write2FileWithBlocker 	- wirte 2 File with file blocker and error control
debug.pm 				- write 2 debug file can be called in any place of app


TODO-
html/cgi-bin/lib_proyect/ is too populated
separate pure mvc-libraries form helpers, from common-libraries form proyect-libraries from helper-libraries and super global variables
